#prepare system
#folders
mkdir "C:\ProgramData\Ansible" -ErrorAction Ignore | Out-Null
mkdir "C:\ProgramData\Ansible\scripts\" -ErrorAction Ignore | Out-Null
mkdir "C:\ProgramData\Ansible\templates\" -ErrorAction Ignore | Out-Null
mkdir "C:\ProgramData\Ansible\scripts\files" -ErrorAction Ignore | Out-Null
remove-item -Path C:\ProgramData\Ansible\scripts\files\* -recurse -force

#Download mulighed
If (!(Test-Path "HKLM:\SOFTWARE\Microsoft\Internet Explorer\Main")) {
    New-Item -Path "HKLM:\SOFTWARE\Microsoft\Internet Explorer\Main" -Force | Out-Null}
    Set-ItemProperty -Path  "HKLM:\SOFTWARE\Microsoft\Internet Explorer\Main" -Name "DisableFirstRunCustomize"  -Value 1
#Script
$script = "C:\ProgramData\Ansible\scripts\files\script.ps1"; $folder = Split-Path $script
New-item $script -Force | Out-Null



function klientautomatisering{
Do {
    Write-Host "`t`t`t- Vil du installere applikationer? (y/n)" -f yellow -nonewline; ;
    $answer = Read-Host " " 
    Switch ($answer) { 
Y {

echo "Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))" >> $script
echo "Start-Sleep -s 3" >> $script;

$appheader = 
"
                   _           _        _ _                 
  __ _ _ __  _ __ (_)_ __  ___| |_ __ _| | | ___ _ __ 
 / _`  | '_ \| '_ \| | '_ \/ __| __/ _`  | | |/ _ \ '__|
| (_| | |_) | |_) | | | | \__ \ |  (_| | | |  __/ |   
 \__,_| .__/| .__/|_|_| |_|___/\__\__,_|_|_|\___|_|   
      |_|   |_|                                               
" 
    
        Write-host $appheader -f Yellow 
        write-host "    BROWSER:" -f yellow
        write-host "        Chrome        Firefox      Opera" -f green
        write-host "        Brave         Opera        Vevaldi" -f green
        "";
        write-host "    TOOLS:" -f yellow
        write-host "        Dropbox       Google Drive    Teamviewer" -f green
        write-host "        7-zip         Winrar          Greenshot" -f green
        write-host "        ShareX        Gimp            Visual studio++" -f green
        "";
        write-host "    MEDIA PLAYER:" -f yellow
        write-host "        Spotify       VLC           Itunes" -f green
        write-host "        Winamp        Foobar2000    K-Lite" -f green
        write-host "        MPC-HC        Popcorntime         " -f green
        "";
        write-host "    Development:" -f yellow
        write-host "        Notepad++       vscode           atom" -f green
        write-host "        Vim             Eclipse          PyCharm" -f green
        write-host "        PuTTY           Superputty       TeraTerm" -f green
        write-host "        Filezilla       WinSCP           mRemoteNG" -f green
        write-host "        Wireshark       git              Github Desktop" -f green
        "";
        write-host "    Social:" -f yellow
        write-host "        Webex           Zoom           Microsoft Teams" -f green
        write-host "        Discord         Twitch         Ubisoft-Connect" -f green
        write-host "        Steam" -f green
        "";
        Write-host "    ** List multiple programs seperated by , (comma) - spaces are allowed." -f yellow;
        "";
        Write-host "`t`tType the programs you would like to be installed on this system" -nonewline; 
        $requested_apps = (Read-Host " ").Split(",") | Foreach-object { $_ -replace ' ',''}
        foreach ($requested_app in $requested_apps) {

        if("cancel" -eq "$requested_app"){Write-Output "Quitting.."}
        elseif("Firefox" -match "$requested_app"){Write-host "`t`t`t`t- adding firefox.." -f yellow; Start-Sleep -s 1; echo 'choco install firefox -y' >> $script}
        elseif("Chrome" -match "$requested_app"){Write-host "`t`t`t`t- adding Chrome.." -f yellow; Start-Sleep -s 1; echo 'choco install googlechrome -y' >> $script;} 
        elseif("Brave" -match "$requested_app"){Write-host "`t`t`t`t- adding Brave.." -f yellow; Start-Sleep -s 1; echo 'choco install Brave -y ' >> $script;} 
        elseif("Opera" -match "$requested_app"){Write-host "`t`t`t`t- adding Opera.." -f yellow; Start-Sleep -s 1; echo 'choco install opera -y' >> $script;} 
        elseif("Vivaldi" -match "$requested_app"){Write-host "`t`t`t`t- adding Vivaldi.." -f yellow; Start-Sleep -s 1; echo 'choco install Vivaldi -y' >> $script;} 

        elseif("Dropbox" -match "$requested_app"){Write-host "`t`t`t`t- adding Dropbox.." -f yellow; Start-Sleep -s 1; echo 'choco install dropbox -y' >> $script;} 
        elseif("Google Drive" -match "$requested_app"){Write-host "`t`t`t`t- adding Google Drive.." -f yellow; Start-Sleep -s 1; echo 'choco install googledrive -y' >> $script;} 
        elseif("TeamViewer" -match "$requested_app"){Write-host "`t`t`t`t- adding TeamViewer.." -f yellow; Start-Sleep -s 1;echo 'choco install TeamViewer -y' >> $script;} 
        elseif("7-zip" -match "$requested_app"){Write-host "`t`t`t`t- adding 7-Zip.." -f yellow; Start-Sleep -s 1; echo 'choco install 7Zip -y' >> $script;} 
        elseif("winrar" -match "$requested_app"){Write-host "`t`t`t`t- adding Winrar.." -f yellow; Start-Sleep -s 1; echo 'choco install winrar -y' >> $script;} 
        elseif("Greenshot" -match "$requested_app"){Write-host "`t`t`t`t- adding Greenshot.." -f yellow; Start-Sleep -s 1; echo 'choco install Greenshot -y' >> $script;} 
        elseif("ShareX" -match "$requested_app"){Write-host "`t`t`t`t- adding Sharex.." -f yellow; Start-Sleep -s 1; echo 'choco install Sharex -y' >> $script;} 
        elseif("Gimp" -match "$requested_app"){Write-host "`t`t`t`t- adding Gimp.." -f yellow; Start-Sleep -s 1; echo 'choco install Gimp -y' >> $script;} 
        elseif("Visual studio++" -match "$requested_app"){Write-host "`t`t`t`t- adding Visual studio++.." -f yellow; Start-Sleep -s 1; echo 'choco install vcredist140 -y' >> $script;} 
        
        elseif("spotify" -match "$requested_app"){Write-host "`t`t`t`t- adding spotify.." -f yellow; Start-Sleep -s 1; echo 'choco install spotify -y' >> $script;}  
        elseif("VLC" -match "$requested_app"){Write-host "`t`t`t`t- adding VLC.." -f yellow; Start-Sleep -s 1; echo 'choco install VLC -y' >> $script;}  
        elseif("itunes" -match "$requested_app"){Write-host "`t`t`t`t- adding itunes.." -f yellow; Start-Sleep -s 1; echo 'choco install itunes -y' >> $script;}  
        elseif("Winamp" -match "$requested_app"){Write-host "`t`t`t`t- adding Winamp.." -f yellow; Start-Sleep -s 1; echo 'choco install Winamp -y' >> $script;}  
        elseif("foobar2000" -match "$requested_app"){Write-host "`t`t`t`t- adding foobar2000.." -f yellow; Start-Sleep -s 1; echo 'choco install foobar2000 -y' >> $script;}  
        elseif("K-lite" -match "$requested_app"){Write-host "`t`t`t`t- adding K-Lite.." -f yellow; Start-Sleep -s 1; echo 'choco install k-litecodecpackfull -y' >> $script;}  
        elseif("MPC-HC" -match "$requested_app"){Write-host "`t`t`t`t- adding MPC-HC.." -f yellow; Start-Sleep -s 1; echo 'choco install MPC-HC -y' >> $script;}  
        elseif("popcorn" -match "$requested_app"){Write-host "`t`t`t`t- adding Popcorntime.." -f yellow; Start-Sleep -s 1; echo 'choco install popcorntime -y' >> $script;}  
        
        elseif("notepad++" -match "$requested_app"){Write-host "`t`t`t`t- adding Notepad++.." -f yellow; Start-Sleep -s 1; echo 'choco install notepadplusplus -y' >> $script;}  
        elseif("vscode" -match "$requested_app"){Write-host "`t`t`t`t- adding vscode.." -f yellow; Start-Sleep -s 1; echo 'choco install vscode -y' >> $script;}  
        elseif("atom" -match "$requested_app"){Write-host "`t`t`t`t- adding atom.." -f yellow; Start-Sleep -s 1; echo 'choco install atom -y' >> $script;}  
        elseif("vim" -match "$requested_app"){Write-host "`t`t`t`t- adding vim.." -f yellow; Start-Sleep -s 1; echo 'choco install vim -y' >> $script;} 
        elseif("Eclipse" -match "$requested_app"){Write-host "`t`t`t`t- adding Eclipse.." -f yellow; Start-Sleep -s 1; echo 'choco install Eclipse -y' >> $script;} 
        elseif("PyCharm" -match "$requested_app"){Write-host "`t`t`t`t- adding PyCharm.." -f yellow; Start-Sleep -s 1; echo 'choco install PyCharm -y' >> $script;} 
        elseif("putty" -match "$requested_app"){Write-host "`t`t`t`t- adding putty.." -f yellow; Start-Sleep -s 1; echo 'choco install PyCharm -y' >> $script;} 
        elseif("superputty" -match "$requested_app"){Write-host "`t`t`t`t- adding superputty.." -f yellow; Start-Sleep -s 1; echo 'choco install superputty -y' >> $script;} 
        elseif("teraterm" -match "$requested_app"){Write-host "`t`t`t`t- adding teraterm.." -f yellow; Start-Sleep -s 1; echo 'choco install teraterm -y' >> $script;} 
        elseif("Filezilla" -match "$requested_app"){Write-host "`t`t`t`t- adding Filezilla.." -f yellow; Start-Sleep -s 1; echo 'choco install Filezilla -y' >> $script;} 
        elseif("WinSCP" -match "$requested_app"){Write-host "`t`t`t`t- adding WinSCP.." -f yellow; Start-Sleep -s 1; echo 'choco install WinSCP -y' >> $script;} 
        elseif("mremoteng" -match "$requested_app"){Write-host "`t`t`t`t- adding MRemoteNG.." -f yellow; Start-Sleep -s 1; echo 'choco install mremoteng -y' >> $script;} 
        elseif("wireshark" -match "$requested_app"){Write-host "`t`t`t`t- adding Wireshark.." -f yellow; Start-Sleep -s 1; echo 'choco install wireshark -y' >> $script;} 
        elseif("git" -match "$requested_app"){Write-host "`t`t`t`t- adding git.." -f yellow; Start-Sleep -s 1; echo 'choco install git.install -y' >> $script;}
        elseif("GithubDesktop" -match "$requested_app"){Write-host "`t`t`t`t- adding Github Desktop.." -f yellow; Start-Sleep -s 1; echo 'choco install github-desktop -y' >> $script;}

        elseif("Microsoft Teams" -match "$requested_app"){Write-host "`t`t`t`t- adding Microsoft Teams.." -f yellow; Start-Sleep -s 1; echo 'choco install microsoft-teams -y' >> $script;} 
        elseif("Zoom" -match "$requested_app"){Write-host "`t`t`t`t- adding Zoom.." -f yellow; Start-Sleep -s 1; echo 'choco install Zoom -y' >> $script;} 
        elseif("Webex" -match "$requested_app"){Write-host "`t`t`t`t- adding Webex.." -f yellow; Start-Sleep -s 1; echo 'choco install webex-teams -y' >> $script;}
        elseif("Discord" -match "$requested_app"){Write-host "`t`t`t`t- adding Discord.." -f yellow; Start-Sleep -s 1; echo 'choco install Discord -y' >> $script;}
        elseif("Twitch" -match "$requested_app"){Write-host "`t`t`t`t- adding Twitch.." -f yellow; Start-Sleep -s 1; echo 'choco install Twitch -y' >> $script;}
        elseif("Steam" -match "$requested_app"){Write-host "`t`t`t`t- adding Steam.." -f yellow; Start-Sleep -s 1; echo 'choco install Steam -y' >> $script;}
        elseif("Ubisoft Connect" -match "$requested_app"){Write-host "`t`t`t`t- adding Ubisoft Connect.." -f yellow; Start-Sleep -s 1; echo 'choco install ubisoft-connect -y' >> $script;}}
        Write-host "`t`t`t`t- Alle applikationer er nu tilføjet til scriptet!..`n";
        Start-Sleep -s 3
         }
            
        
        N { Write-Host "            NO. Skipping this step." -f Red } 
        }} While ($answer -notin "y", "n") 
        

    Do {
        Write-Host "`t`t`t- Vil du fjerne ikonerne fra startmenuen? (y/n)" -f yellow -nonewline; ;
        $answer = Read-Host " " 
        Switch ($answer) { 
            Y {Write-Host "`t`t`t`t- Startmenuen bliver unpinned.";echo (Invoke-WebRequest -Uri "https://geany.org/p/rE93R/raw/").Content >> $script; Start-Sleep -s 1}
            N { Write-Host "NEJ. dette modul bliver skippet" -f Red } 
        }} While ($answer -notin "y", "n") 
     
     
    Do {
        Write-Host "`t`t`t- Vil du fjerne ikonerne fra taskbaren? (y/n)" -f yellow -nonewline; ;
        $answer = Read-Host " " 
        Switch ($answer) { 
            Y {Write-Host "`t`t`t`t- taskbaren bliver unpinned."; echo (Invoke-WebRequest -Uri "https://geany.org/p/p1ipE/raw/").Content >> $script; Start-Sleep -s 1}
            N { Write-Host "NEJ. dette modul bliver skippet" -f Red } 
        }} While ($answer -notin "y", "n") 


        write-host "`t`teksekverer ansible script:"
        write-host "`t`twsl ansible-playbook /mnt/c/ProgramData/Ansible/scripts/createdirdownloadexe.yml"
        Start-Sleep -s 5
        wsl ansible-playbook /mnt/c/ProgramData/Ansible/scripts/createdirdownloadexe.yml
        Start-Sleep -s 5
        } #klient funcktion slut

function Serverautomatisering{
#Downloader script
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/Andreas6920/svendeprove/main/powershellscripts/serverautomatisering.ps1" -OutFile $script

#CSV fil
Do {
    
    Write-Host "`t`t`tEr dette et Proof of Concept? (y/n)" -nonewline;
    $answer = Read-Host " " 
        Switch ($Answer) { 
           Y {
                Write-host "`t`t`t`tBruger-generator påbegyndes..." -f green; Start-Sleep -S 2
                #Downloader template
                    If (!(Test-Path "HKLM:\SOFTWARE\Microsoft\Internet Explorer\Main")) {
                    New-Item -Path "HKLM:\SOFTWARE\Microsoft\Internet Explorer\Main" -Force | Out-Null}
                    Set-ItemProperty -Path  "HKLM:\SOFTWARE\Microsoft\Internet Explorer\Main" -Name "DisableFirstRunCustomize" -Value 1
                    $csv = "$($env:userprofile)\Desktop\bruger.csv"
                    if(test-path $csv){Remove-item $csv -Force}
                    Invoke-WebRequest -uri "https://raw.githubusercontent.com/Andreas6920/svendeprove/main/other%20files/bruger-template.csv" -OutFile $csv
            
                #CSV håndtering
                    $fornavne = (Invoke-WebRequest -uri "https://raw.githubusercontent.com/Andreas6920/svendeprove/main/other%20files/fornavne.txt").content
                    $Efternavne = (Invoke-WebRequest -uri "https://raw.githubusercontent.com/Andreas6920/svendeprove/main/other%20files/efternavne.txt").content
            
                    Write-host "`t`t`t`t- antal" -NoNewline
                    $antal = Read-host " "
                    Write-host "`t`t`t`t- afdeling" -NoNewline
                    $afdeling = Read-host " "
                    Write-host "`t`t`t`t- Tilføjer brugere til CSV fil.."
                    1..$antal | % {
                    #Værdier
                    $fornavn = $fornavne.Split([Environment]::NewLine) | Get-Random
                    $efternavn = $efternavne.Split([Environment]::NewLine) | Get-Random
                    $stilling = "Sygeplejeske", "Læge" | Get-Random
                    $value = $fornavn+";"+$efternavn+";"+$stilling+";"+$afdeling
                    #Tilføj værdier til template
                    
                    Add-Content -Encoding UTF8 -value $value -path $csv
                }
                    # Uploader fil
                    
                    function upload ($filename)
                    {
                    Write-Host "`t`t`t`t- Uploader fil..`t$link"; Start-Sleep -S 3
                    $file = Get-Item $filename;
                    $link = (Invoke-WebRequest -Method PUT -InFile $file.FullName -Uri https://transfer.sh/$($file.Name)).Content
                    ((Get-Content -path $script -Raw) -replace 'https://transfer.sh/kode/brugere.csv', $link ) | Set-Content -Path $script
                    write "`t`t`t`t- Uploaded til filserver:`t$link"; Start-Sleep -s 3;
                    Set-Clipboard -Value $link}
                    Start-Sleep -s 3; upload $csv; Start-Sleep -s 2;
                    Write-host "`t`t`t`t- Konfigurer serverscript.."; Start-Sleep -S 3
                    
                    # Vis CSV
                        Do {
                            Write-Host "`t`t`t`t- Vil du se CSV filen? (y/n)" -nonewline;
                            $Readhost = Read-Host " " 
                                Switch ($ReadHost) { 
                                Y {
                                    Write-Host "`t`t`t`t`t- Åbner CSV fil"
                                    Notepad $csv
                                    Wait-Process -Name "notepad"
                                    Write-Host "`t`t`t`t`t- Sletter lokal fil"
                                    Start-Sleep -S 3
                                    Remove-Item -Path $csv -Force
                                    Write-Host "`t`t`t`t`t- Lokal fil Slettet"
                                    Start-Sleep -S 1
                                } 
                                N {} 
                        } } While($Readhost -notin "y", "n")
                
                } 
            N {
                # Indtast CSV fil direkte link 
                Write-Host "Please enter the link to csv file:" -nonewline;
                $link = Read-Host " " 
                # Downloader CSV fra indtastede link
                Invoke-WebRequest -uri $link -OutFile $csv
                Write-host "customizing script"
                    ((Get-Content -path $script -Raw) -replace 'https://transfer.sh/kode/brugere.csv', "$link" ) | Set-Content -Path $script
                }}}
                While($Answer -notin "y", "n")

        write-host "`t`teksekverer ansible script:"
        write-host "`t`twsl ansible-playbook /mnt/c/ProgramData/Ansible/scripts/createdirdownloadexe.yml"
        Start-Sleep -s 5
        wsl ansible-playbook /mnt/c/ProgramData/Ansible/scripts/createdirdownloadexe.yml --limit DC
        Start-Sleep -s 5
}
    

$intro = 
"
██╗  ██╗███████╗██╗   ██╗ █████╗ ██╗   ██╗████████╗ ██████╗ 
██║  ██║██╔════╝██║   ██║██╔══██╗██║   ██║╚══██╔══╝██╔═══██╗
███████║█████╗  ██║   ██║███████║██║   ██║   ██║   ██║   ██║
██╔══██║██╔══╝  ╚██╗ ██╔╝██╔══██║██║   ██║   ██║   ██║   ██║
██║  ██║███████╗ ╚████╔╝ ██║  ██║╚██████╔╝   ██║   ╚██████╔╝
╚═╝  ╚═╝╚══════╝  ╚═══╝  ╚═╝  ╚═╝ ╚═════╝    ╚═╝    ╚═════╝ 

Version 1.0
Creator: Andreas Mouritsen | https://github.com/Andreas6920/Svendeprove
                                                                                                                                                
"

#Check if admin
$admin_permissions_check = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
$admin_permissions_check = $admin_permissions_check.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
if ($admin_permissions_check) {

do {
    cls
    Write-host $intro -f Yellow 
    Write-host "Please select one of the following options:" -f yellow
    Write-host ""; Write-host "";
    Write-host "        [1] - Klientautomatisering"
    Write-host "        [2] - Serverautomatisering"
    Write-host "        [3] - Netværksautomatisering"
    "";
    Write-host "        [0] - Exit"
    Write-host ""; Write-host "";
    Write-Host "Option: " -f yellow -nonewline; ; ;
    $option = Read-Host
    Switch ($option) { 
        0 {}
        1 { klientautomatisering; }
        2 { Serverautomatisering; }
        3 { Netværksautomatisering; }
        Default { cls; Write-host""; Write-host""; Write-host "INVALID OPTION. TRY AGAIN.." -f red; Write-host""; Write-host""; Start-Sleep 1; cls; Write-host ""; Write-host "" } }
     
    }while ($option -ne 0)}
    
    
    
else {
1..99 | % {
    $Warning_message = "POWERSHELL IS NOT RUNNING AS ADMINISTRATOR. Please close this and run this script as administrator."
    cls; ""; ""; ""; ""; ""; write-host $Warning_message -ForegroundColor White -BackgroundColor Red; ""; ""; ""; ""; ""; Start-Sleep 1; cls
    cls; ""; ""; ""; ""; ""; write-host $Warning_message -ForegroundColor White; ""; ""; ""; ""; ""; Start-Sleep 1; cls
}    
}