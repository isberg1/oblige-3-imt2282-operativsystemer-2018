README #

### What is this repository for? ###

  11.7 Lab exercises b) (OBLIG) Prosesser og traader.
  
  v�r obs p� at det er 2 oppgaver i kompendiet som heter: b)(OBLIG) Prosesser og traader

### How do I run program? ###

last ned repo

i terminalen: flytt deg til den mappen som har dette scriptet

kjoor kommando:

som admin 

    Set-ExecutionPolicy -ExecutionPolicy RemoteSigned     
    
bekreft valg med Y
    
    .\myprocinfo.ps1
	
velg den funksjonen du vil kj�re fra menyen, eller tast 9 for avslutt
    

### code quality ###
Til kvalitetstesing av koden har jeg kjoort 
den ene testene som Erik H. anbefaler til paa siden(8.4.2018):
 
 	https://github.com/NTNUcourses/opsys/blob/master/README-PowerShell-code-quality.txt 
  
  
  Kjoorte foolgende:
  
      Invoke-ScriptAnalyzer .\myprocinfo.ps1
       
  Resultat:
  
     alt ok
         

### Who do I talk to? ###
Alexander Jakobsen, 16BITSEC, Studentnr: 473151, alexajak@stud.ntnu.no