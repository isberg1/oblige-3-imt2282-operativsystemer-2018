

<#

  File:   myprocinfo.ps1
  Author: Alexander Jakobsen, 16BITSEC, Studentnr: 473151, e-mail: alexajak@stud.ntnu.no
  Created on March 26, 2018
  Created with Windows powerShell ISE in Windows 10
  
  Tested in: 
  PSVersion: 5.1.16299.251
  PSEdition: Desktop
#>


###########  Funksjoner  ############
 
 # - print meny til consol
function meny () {
  Write-Output "`n"  #newline
  Write-Output "1 - Hvem er jeg og hva er navnet paa dette scriptet?"
  Write-Output "2 - Hvor lenge er det siden siste boot?"
  Write-Output "3 - Hvor mange prosesser og traader finnes?"
  Write-Output "4 - Hvor mange context switch'er fant sted siste sekund?"
  Write-Output "5 - Hvor stor andel av CPU-tiden ble benyttet i kernelmode og i usermode siste sekund?"
  Write-Output "6 - Hvor mange interrupts fant sted siste sekund?"
  Write-Output "9 - Avslutt dette scriptet"
}

#  2 - Hvor lenge er det siden siste boot?"
function oppetid () { 

  
     
     # hent tiden siden last boot, formater den og skriv den til consol
 $a = $($((Get-CimInstance -ClassName win32_operatingsystem).LocalDateTime -`
          (Get-CimInstance -ClassName win32_operatingsystem).LastBootUpTime )|`
           Format-Table Days, hours, minutes, seconds)

 Write-Output "last boot var: "
 $a
}

# 3 - Hvor mange prosesser og traader finnes?"
function aktiviteter () {
  
     # finn basis objekter
  $a = $(Get-Process)   
     
     # finn antall av hver type og adder de 2 relevanter tallene fra basis objekt
  Write-Output "Det finnes  $($(($a).length) + $(($a).threads.id.length)) prosesser og tårer" 

}

#  4 - Hvor mange context switch'er fant sted siste sekund?
function context () {
 
  Write-Output "Antall Context Switcher det siste sekundet var: "
    # hent ut og print relevant tall til consol
  Write-Output  "$((Get-CimInstance -ClassName Win32_PerfFormattedData_PerfOS_System).ContextSwitchesPersec)"

}

#  5 - Hvor stor andel av CPU-tiden ble benyttet i Privileged mode og i user mode siste sekund?"
Function modes () {

    

      # ta en måling av bruk
  $a =  ((Get-Counter -Counter "\\$(hostname)\processor(_total)\% user time", "\\$(hostname)\processor(_total)\% privileged time").CounterSamples)
      # finn % i Privileged mode + formater med kun 2 desimaltall
  $Privileged = $("{0:F2}" -f ($a | Where-Object {$_.Path -match "privileged" }).CookedValue )
      # finn % i user mode + formater med kun 2 desimaltall
  $user = $("{0:F2}" -f ($a | Where-Object {$_.Path -match "user" }).CookedValue )
      
      # print verdier til consol
  Write-Output "andel tid i user mode var:  $user %"
  Write-Output "andel tid i Privileged var:  $Privileged %"
  Write-Output "resten av tiden var prosessoren i idle mode"

}

#  6 - Hvor mange interrupts fant sted siste sekund?
function interrupts () {
     
      # fin riktig objekter
  $a = (Get-CimInstance -ClassName Win32_PerfFormattedData_Counters_ProcessorInformation)
      # finn relevant objekt og verdi
  $b = $( ($a | Where-Object {$_.Name -eq "_Total" }).InterruptsPersec )
      
      # print verdi til consol
  Write-Output "Antall interrupts siste sekund var: $b"

}


##############  Main  ###############

$i = -1 # Sett en startverdi for lup variabel $i

while ( $i -ne 9 )
{
  
  Start-Sleep 2
    # print en meny på consol
  meny  
    # les i brukervalg fra consol
  $valg = Read-Host "`nvelg et av fuksjonene over"
    # kjør funksjonalitet basert på brukervalget 
  switch ($valg )
   {
      #  - Hvem er jeg og hva er navnet paa dette scriptet?
      1 { Write-Output "Jeg er $($env:USERNAME), dette scriptet heter $($MyInvocation.MyCommand))";  } 
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
      default { Write-Output "`n`n------ Feil inputtverdi ------"} 
   }   

 }
   # avslutt script med returkode "0"
 exit 0