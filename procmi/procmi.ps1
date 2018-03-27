<#
d) (OBLIG) En prosess sin bruk av virtuelt og fysisk minne.
Skriv et script procmi.ps1 som tar et sett med prosess-ID’er som kommandolinjeargument og for hver av disse prosessene skriver til en fil PID-dato.meminfo
følgende info:
(a) Total bruk av virtuelt minne (VirtualMemorySize)
(b) Størrelse pa Working Set ˚

Eksempel kjøring:
23212.4. LAB EXERCISES

$ procmi.ps1 420 8566
$ Get-Content 420--20100314-221523.meminfo

******** Minne info om prosess med PID 420 ********
Total bruk av virtuelt minne: 35.6875MB
Størrelse p˚ a Working Set: 816KB
$

#>

function tilFil ($a, $vSize, $wSet) {
$prosessID = $a
$dato = $(date -Format yyyyMMdd/Hms)
$navn = "$prosessID--$dato.meminfo"

Tee-Object $navn
Write-Output "******** Minne info om prosess med PID $prosessID ********" >> $navn
Write-Output "Total bruk av virtuelt minne: $($vSize /1MB) MB" >> $navn
Write-Output "Total bruk av virtuelt minne: $wSet KB" >> $navn

}


##############  Main  ##############

foreach ($id in $args) {
#sjekk om ID existerer

$virtualMemory = $((Get-Process -Id $id ).VirtualMemorySize )
$workingSet = $((Get-Process -Id $id).WorkingSet)

tilFil $id $virtualMemory $workingSet

}
