<#

  File:   prosesserOgTråder.ps1
  Author: Alexander Jakobsen, 16BITSEC, Studentnr: 473151, e-mail: alexajak@stud.ntnu.no
  Created on March 28, 2018
  Created with Windows powerShell ISE in Windows 10

  Tested in: 
  PSVersion: 5.1.16299.251
  PSEdition: Desktop
  
#>
    # feilhåndtering
trap {
    write-output "`n"
    write-output "$($Error[0].Exception.Message)"    

        # send error-object til egen funksjon
    # Feil_Håndterings_Funkjon( $Error[0] )

    continue
}

    # Hent alle chrome prosesser og skriv alle Prosess ID og antal tråer til consol
Get-Process chrome | ForEach-Object {Write-Output "chrome $($_.id)  $($_.threads.count)" } 


    

