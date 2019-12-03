$LogbogFile = 'C:\Temp\PostNordLogbog.txt'
$Title = "PostNord Hovedecomputer"
$ScriptPassword = "pass"

Function Show-Title {
    param (
           [string]$Title = 'Menu Title'
     )
    Write-Host "================ $($Title) ================" -ForegroundColor Blue
}


# Main menu, allowing user selection
function Show-Menu {
    Clear-Host
    Show-Title    
    Write-Host "1 - Vis Pakkecentral status."
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
    "" | Out-File -FilePath $LogbogFile -Encoding utf8 -Append
    "[$(Get-Date -format 'dd-MM-yyyy - hh:mm:ss')]" | Out-File -FilePath $LogbogFile -Encoding utf8 -Append
    $content | Out-File -FilePath $LogbogFile -Encoding utf8 -Append
}

#Functions go here

Function Login {
        # Log-in to the applicaion 
    do {
        Clear-Host 
        Show-Title -Title $Title
        Write-Host "==== LOGIN ===="
        $password = Read-Host -Prompt "Indtast password"
        if ($password -ceq $ScriptPassword) {
            Clear-Host
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

login
