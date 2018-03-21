# myprocinfo.ps1

function meny () {
Write-Host 
Write-Host "1 - Hvem er jeg og hva er navnet paa dette scriptet?"
Write-Host "2 - Hvor lenge er det siden siste boot?"
Write-Host "3 - Hvor mange prosesser og traader finnes?"
Write-Host "4 - Hvor mange context switch'er fant sted siste sekund?"
Write-Host "5 - Hvor stor andel av CPU-tiden ble benyttet i kernelmode og i usermode siste sekund?"
Write-Host "6 - Hvor mange interrupts fant sted siste sekund?"
Write-Host "9 - Avslutt dette scriptet"
}

###########  Main  ##########

$i = -1 # Sett en startverdi for lup variabel $i

while ( $i -ne 9 )
{
  sleep 2
  clear
  meny  # print en meny på consol

  $valg = Read-Host "`nvelg et av fuksjonene under"

  switch ($valg )
   {
      1 { Write-Host "Jeg er $($env:USERNAME), dette scriptet heter $($MyInvocation.MyCommand))";  break } #"1 - Hvem er jeg og hva er navnet paa dette scriptet?"
      2 { Write-Host "siste boot time var $((Get-CimInstance -ClassName Win32_OperatingSystem).LastBootUpTime)"}   #"2 - Hvor lenge er det siden siste boot?"
      3 { Write-Host "Det finnes $( $(((Get-Process).id).length) + $(((Get-Process).Threads.id).length) ) prosesser og tårer"} #"3 - Hvor mange prosesser og traader finnes?"
      4 { Write-Host "Antall Context Switcher det siste sekundet var: $((Get-CimInstance -ClassName Win32_PerfFormattedData_PerfOS_System).ContextSwitchesPersec)"}
      5 { "It is four."}
      6 { Write-Host "Antall interrupts siste secund var: $((Get-CimInstance -ClassName Win32_PerfFormattedData_Counters_ProcessorInformation | Where-Object {$_.Name -eq "_Total" }).InterruptsPersec )"}
      9 { $i = 9}
      default { Write-Host "`n`n------ Feil inputtverdi ------"} 
   }
   

 }

 exit 0