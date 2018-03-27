<#

  File:   procmi.ps1
  Author: Alexander Jakobsen, 16BITSEC, Studentnr: 473151, e-mail: alexajak@stud.ntnu.no
  Created on March 27, 2018
  Created with Windows powerShell ISE in Windows 10

#>

##############  Feilsjekk  ##############

            # Sjekk om det IKKE er medsendt argumenter til scriptet, 
            # hvis så, print feilmelding og exit fra scipt
if( $args.Length -lt 1 ) {

    Write-Output "`nDette scriptet trenger minst et ProsessID argument for å kunne kjøre`n"
    exit 0
}

##############  Funksjoner  ##############

            # Får in PID, virituelt minne størelse og WorkingSet størelse som argumenter            
function tilFil ($prosessID, $vSize, $wSet) {

    $dato = $(date -Format yyyyMMdd/Hms)
            # Lag et filnavn basert på PID og dato
    $navn = "$prosessID--$dato.meminfo"
            # Lag en fil
    Tee-Object $navn
            # Skriv text til fil
    Write-Output "******** Minne info om prosess med PID $prosessID ********" >> $navn
    Write-Output "Total bruk av virtuelt minne: $($vSize /1MB) MB" >> $navn
    Write-Output "Total bruk av virtuelt minne: $wSet KB" >> $navn

}

##############  Main  ##############

            #  Kjør loop 1 gang, pr. medsendte argumenter til scriptet,
foreach ($id in $args) {
            # Sjekk om PID existerer og send eventuelle feilmeldinger i søpla
    $test = $(Get-Process -id $id) 2>$null
            # Hvis PID existerer, hent relevant data og skriv det til fil
    if($test) {

        $virtualMemory = $((Get-Process -Id $id ).VirtualMemorySize )
        $workingSet = $((Get-Process -Id $id).WorkingSet)
                    
        tilFil $id $virtualMemory $workingSet

    }     
    else {     # Hvis PID ikke exsisterer, print feilmelding til consol
        Write-Output "finner ingen prosess med ID: $id"  
    }

}
            # Avslutt script
exit 0
