<#
.SYNOPSIS
  PostNord Mainframe program for Juleturs natteløb 2019
.DESCRIPTION
    The script asks for a password to unlock the program, and if the password is correct a menu will be showed.
    Menu Items
     [1] Show the status of the Package central, if there are any problems with delivery and the package que.
     [2] Show the content of the work log
     [3] Adds entries to the work log
     [Q] Closes the program
       
.NOTES
  Version:        2.1
  Author:         William Johansson
  E-mail:         willi.the.scout@gmail.com  
  Creation Date:  2019-11-23
  Purpose/Change: Added Main menu and created options as functions
#>

#---------------------------------------------------------[Script Parameters]------------------------------------------------------
[CmdletBinding()]
Param (
  #Script parameters go here
)

#----------------------------------------------------------[Declarations]----------------------------------------------------------
$Title = "PostNord Hovedecomputer"                      # Title of the program (is always showed)
$ScriptPassword = "pass"                                # Password for the program
$LogbogFile = "$($PSScriptRoot)\PostNordLogbog.txt"     # The file that contains the 'Post Nord Logbog'

#-----------------------------------------------------------[Functions]------------------------------------------------------------´
# Functions go here
Function Show-Title {
    param (
           [string]$Title = 'Menu Title'
     )
    Write-Host "================ $($Title) ================" -ForegroundColor Blue
}

# Main menu, allowing user selection
function Show-Menu {
    Clear-Host
    Show-Title -Title $Title
    # Show Menu options
    Write-Host "----------- MENU -----------"
    Write-Host "1 - Vis Pakkecentral status"
    Write-Host "2 - Vis Logbog"
    Write-Host "3 - Skriv Logbog"
    Write-Host "Q - For lukke programmet"
}

function Pakkestatus {
    Clear-Host
    Show-Title -Title $Title
    Write-Host "------ Pakkecentral ------"
    Write-Host
    Write-Host "Cental Status: "-NoNewline 
    Write-Host "OK" -ForegroundColor Green
    Write-Host "Levetings Status: " -NoNewline  
    Write-Host "Forsinket!" -ForegroundColor Yellow
    Write-Host "Pakke kø: 27155"
}

function VisLogbog {

    # Check if the $LogbogFile exists, if not create it.
    if (!(Test-Path -Path $LogbogFile)) {
        New-Item $LogbogFile -ItemType File | Out-Null
    }

    Clear-Host
    Show-Title -Title $Title
    Write-Host "------ Logbog ------"
    $Content = Get-Content $LogbogFile
    $Content
}

function SkrivLogbog {
    param ( 
        $content 
    ) 

    # Check if the $LogbogFile exists, if not create it.
    if (!(Test-Path -Path $LogbogFile)) {
        New-Item $LogbogFile -ItemType File | Out-Null
    }

    Show-Title -Title $Title
    "" | Out-File -FilePath $LogbogFile -Encoding utf8 -Append
    "[$(Get-Date -format 'dd-MM-yyyy - hh:mm:ss')]" | Out-File -FilePath $LogbogFile -Encoding utf8 -Append
    $content | Out-File -FilePath $LogbogFile -Encoding utf8 -Append
}

Function Login {
        # Log-in to the applicaion 
    do {
        Clear-Host 
        Show-Title -Title $Title
        Write-Host "==== LOGIN ===="
        $password = Read-Host -Prompt "Indtast password"
        if ($password -ceq $ScriptPassword) {
            Clear-Host
            Show-Title -Title $Title
            Write-Host "Godkendt!"
            Start-Sleep -Seconds 1
            Write-Host "Logger ind."
            Start-Sleep -Seconds 3
            Write-Host "OK!"
            Start-Sleep -Seconds 1
            Write-Host ""
            Write-Host "Loader prograrm"
            Write-Host "Loading [" -NoNewline
            Write-Host "=" -NoNewline
            Start-Sleep -Seconds 1
            Write-Host "=" -NoNewline
            Start-Sleep -Seconds 1
            Write-Host "=" -NoNewline
            Start-Sleep -Seconds 1
            Write-Host "=" -NoNewline
            Start-Sleep -Seconds 1
            Write-Host "=" -NoNewline
            Start-Sleep -Seconds 1
            Write-Host "=" -NoNewline
            Start-Sleep -Seconds 1
            Write-Host "=" -NoNewline
            Start-Sleep -Seconds 1
            Write-Host "=" -NoNewline
            Start-Sleep -Seconds 1
            Write-Host "=" -NoNewline
            Start-Sleep -Seconds 1
            Write-Host "=" -NoNewline
            Write-Host "]"
            Menu
        }
        else {
            Write-Host "Password Forket!"
            Start-Sleep 3
        }
    }
    while (!($password -ceq $ScriptPassword))
}

function Menu {
    #Main menu loop
    do {
        Show-Menu -Title "PostNord Hovedecomputer"
        $input = Read-Host "Vælg: "
        switch ($input)
        {
            '1' {
                Pakkestatus
            } 
            '2' {
                VisLogbog
            } 
            '3' {
                Clear-Host
                $UserInput = Read-Host -Prompt "Indtast log: "
                SkrivLogbog -content $UserInput
            } 
            'q' {
                return
            }
        }
        Write-Host ""
        pause
    }
    until ($input -eq 'q')
}

#-----------------------------------------------------------[Execution]------------------------------------------------------------
# Start the program by running the login function, if the login in is successfully, the menu will be showed to the user.
login