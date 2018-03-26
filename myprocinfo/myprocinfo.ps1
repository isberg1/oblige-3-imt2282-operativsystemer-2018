

<#

  File:   myprocinfo.ps1
  Author: Alexander Jakobsen, 16BITSEC, Studentnr: 473151, e-mail: alexajak@stud.ntnu.no
  Created on March 26, 2018
  Created with Windows powerShell ISE in Windows 10

#>


###########  Funksjoner  ############
 
 # - print meny til consol
function meny () {
  Write-Host "`n"  #newline
  Write-Host "1 - Hvem er jeg og hva er navnet paa dette scriptet?"
  Write-Host "2 - Hvor lenge er det siden siste boot?"
  Write-Host "3 - Hvor mange prosesser og traader finnes?"
  Write-Host "4 - Hvor mange context switch'er fant sted siste sekund?"
  Write-Host "5 - Hvor stor andel av CPU-tiden ble benyttet i kernelmode og i usermode siste sekund?"
  Write-Host "6 - Hvor mange interrupts fant sted siste sekund?"
  Write-Host "9 - Avslutt dette scriptet"
}

#  - Hvor lenge er det siden siste boot?"
function oppetid () { 
  write-host "maskinen har vært oppe i: "
     # hent verdien "Uptime", formater den og skriv den til consol
  (Get-Uptime).uptime | Format-Table -Property Days, Hours, Minutes, Seconds
}

# - Hvor mange prosesser og traader finnes?"
function aktiviteter () {
     # finn basis objekter
  $a = $(Get-Process)   

  Write-Host -noNewline "Det finnes "
     # finn antall av hver type og adder de 2 relevanter tallene fra basis objekt
  Write-Host -NoNewline " $($(($a).threads.id.length) + $(($a).threads.id.length))" 
  Write-Host -NoNewline " prosesser og tårer"

}

#  - Hvor mange context switch'er fant sted siste sekund?
function context () {
  Write-Host "Antall Context Switcher det siste sekundet var: "
    # hent ut og print relevant tall til consol
  Write-Host -NoNewline "$((Get-CimInstance -ClassName Win32_PerfFormattedData_PerfOS_System).ContextSwitchesPersec)"
}

#  - Hvor mange interrupts fant sted siste sekund?
function interrupts () {
      # fin riktig objekter
  $a = (Get-CimInstance -ClassName Win32_PerfFormattedData_Counters_ProcessorInformation)
      # finn relevant objekt og verdi
  $b = $(  ($a | Where-Object {$_.Name -eq "_Total" }).InterruptsPersec )
      # print verdi til consol
  Write-Host "Antall interrupts siste sekund var: $b"
}

#  - Hvor stor andel av CPU-tiden ble benyttet i Privileged mode og i user mode siste sekund?"
Function modes () {
      # ta en måling av bruk
  $a = $(((Get-Counter -counter "\Processor(*)\% Privileged Time", "\Processor(*)\% User Time" ).CounterSamples | Where-Object {$_.InstanceName -match "_total"  }))
      # finn % i Privileged mode + formater med kun 2 desimaltall
  $Privileged = $("{0:F2}" -f ($a | Where-Object {$_.Path -match "privileged" }).CookedValue )
      # finn % i user mode + formater med kun 2 desimaltall
  $user = $("{0:F2}" -f ($a | Where-Object {$_.Path -match "user" }).CookedValue )
      # print verdier til consol
  Write-Host "andel tid i user mode var:  $user %"
  Write-Host "andel tid i Privileged var:  $Privileged %"
  Write-Host "resten av tiden var prosessoren i idle mode"
}

##############  Main  ###############

$i = -1 # Sett en startverdi for lup variabel $i

while ( $i -ne 9 )
{
  
  sleep 2
    # print en meny på consol
  meny  
    # les i brukervalg fra consol
  $valg = Read-Host "`nvelg et av fuksjonene over"
    # kjør funksjonalitet basert på brukervalget 
  switch ($valg )
   {
      #  - Hvem er jeg og hva er navnet paa dette scriptet?
      1 { Write-Host "Jeg er $($env:USERNAME), dette scriptet heter $($MyInvocation.MyCommand))";  } 
      #  - Hvor lenge er det siden siste boot?"
      2 { oppetid }  
      #  - Hvor mange prosesser og traader finnes?"
      3 { aktiviteter } 
      #  - Hvor mange context switch'er fant sted siste sekund?
      4 { context }
      #  - Hvor stor andel av CPU-tiden ble benyttet i kernelmode og i usermode siste sekund?"
      5 { modes }
      #  - Hvor mange interrupts fant sted siste sekund?
      6 { interrupts  }
      #  - Avslutt dette scriptet
      9 { $i = 9}
      default { Write-Host "`n`n------ Feil inputtverdi ------"} 
   }   

 }
   # avslutt script med returkode "0"
 exit 0