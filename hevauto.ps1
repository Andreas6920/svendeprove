#prepare system
$file = "C:\ProgramData\Ansible-Scripts\script.ps1"; $folder = Split-Path $file
mkdir $folder -ErrorAction Ignore | out-null; New-item $file -Force | Out-Null



function klientautomatisering{
Do {
        Write-Host "`t`t`t- Vil du installere applikationer? (y/n)" -f yellow -nonewline; ;
        $answer = Read-Host " " 
        Switch ($answer) { 
    Y {

echo "Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))" >> $file
echo "Sleep -s 3" >> $file;

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
            elseif("Firefox" -match "$requested_app"){Write-host "`t`t`t`t- adding firefox.." -f yellow; sleep -s 1; echo 'choco install firefox -y' >> $file}
            elseif("Chrome" -match "$requested_app"){Write-host "`t`t`t`t- adding Chrome.." -f yellow; sleep -s 1; echo 'choco install googlechrome -y' >> $file;} 
            elseif("Brave" -match "$requested_app"){Write-host "`t`t`t`t- adding Brave.." -f yellow; sleep -s 1; echo 'choco install Brave -y ' >> $file;} 
            elseif("Opera" -match "$requested_app"){Write-host "`t`t`t`t- adding Opera.." -f yellow; sleep -s 1; echo 'choco install opera -y' >> $file;} 
            elseif("Vivaldi" -match "$requested_app"){Write-host "`t`t`t`t- adding Vivaldi.." -f yellow; sleep -s 1; echo 'choco install Vivaldi -y' >> $file;} 

            elseif("Dropbox" -match "$requested_app"){Write-host "`t`t`t`t- adding Dropbox.." -f yellow; sleep -s 1; echo 'choco install dropbox -y' >> $file;} 
            elseif("Google Drive" -match "$requested_app"){Write-host "`t`t`t`t- adding Google Drive.." -f yellow; sleep -s 1; echo 'choco install googledrive -y' >> $file;} 
            elseif("TeamViewer" -match "$requested_app"){Write-host "`t`t`t`t- adding TeamViewer.." -f yellow; sleep -s 1;echo 'choco install TeamViewer -y' >> $file;} 
            elseif("7-zip" -match "$requested_app"){Write-host "`t`t`t`t- adding 7-Zip.." -f yellow; sleep -s 1; echo 'choco install 7Zip -y' >> $file;} 
            elseif("winrar" -match "$requested_app"){Write-host "`t`t`t`t- adding Winrar.." -f yellow; sleep -s 1; echo 'choco install winrar -y' >> $file;} 
            elseif("Greenshot" -match "$requested_app"){Write-host "`t`t`t`t- adding Greenshot.." -f yellow; sleep -s 1; echo 'choco install Greenshot -y' >> $file;} 
            elseif("ShareX" -match "$requested_app"){Write-host "`t`t`t`t- adding Sharex.." -f yellow; sleep -s 1; echo 'choco install Sharex -y' >> $file;} 
            elseif("Gimp" -match "$requested_app"){Write-host "`t`t`t`t- adding Gimp.." -f yellow; sleep -s 1; echo 'choco install Gimp -y' >> $file;} 
            elseif("Visual studio++" -match "$requested_app"){Write-host "`t`t`t`t- adding Visual studio++.." -f yellow; sleep -s 1; echo 'choco install vcredist140 -y' >> $file;} 
            
            elseif("spotify" -match "$requested_app"){Write-host "`t`t`t`t- adding spotify.." -f yellow; sleep -s 1; echo 'choco install spotify -y' >> $file;}  
            elseif("VLC" -match "$requested_app"){Write-host "`t`t`t`t- adding VLC.." -f yellow; sleep -s 1; echo 'choco install VLC -y' >> $file;}  
            elseif("itunes" -match "$requested_app"){Write-host "`t`t`t`t- adding itunes.." -f yellow; sleep -s 1; echo 'choco install itunes -y' >> $file;}  
            elseif("Winamp" -match "$requested_app"){Write-host "`t`t`t`t- adding Winamp.." -f yellow; sleep -s 1; echo 'choco install Winamp -y' >> $file;}  
            elseif("foobar2000" -match "$requested_app"){Write-host "`t`t`t`t- adding foobar2000.." -f yellow; sleep -s 1; echo 'choco install foobar2000 -y' >> $file;}  
            elseif("K-lite" -match "$requested_app"){Write-host "`t`t`t`t- adding K-Lite.." -f yellow; sleep -s 1; echo 'choco install k-litecodecpackfull -y' >> $file;}  
            elseif("MPC-HC" -match "$requested_app"){Write-host "`t`t`t`t- adding MPC-HC.." -f yellow; sleep -s 1; echo 'choco install MPC-HC -y' >> $file;}  
            elseif("popcorn" -match "$requested_app"){Write-host "`t`t`t`t- adding Popcorntime.." -f yellow; sleep -s 1; echo 'choco install popcorntime -y' >> $file;}  
            
            elseif("notepad++" -match "$requested_app"){Write-host "`t`t`t`t- adding Notepad++.." -f yellow; sleep -s 1; echo 'choco install notepadplusplus -y' >> $file;}  
            elseif("vscode" -match "$requested_app"){Write-host "`t`t`t`t- adding vscode.." -f yellow; sleep -s 1; echo 'choco install vscode -y' >> $file;}  
            elseif("atom" -match "$requested_app"){Write-host "`t`t`t`t- adding atom.." -f yellow; sleep -s 1; echo 'choco install atom -y' >> $file;}  
            elseif("vim" -match "$requested_app"){Write-host "`t`t`t`t- adding vim.." -f yellow; sleep -s 1; echo 'choco install vim -y' >> $file;} 
            elseif("Eclipse" -match "$requested_app"){Write-host "`t`t`t`t- adding Eclipse.." -f yellow; sleep -s 1; echo 'choco install Eclipse -y' >> $file;} 
            elseif("PyCharm" -match "$requested_app"){Write-host "`t`t`t`t- adding PyCharm.." -f yellow; sleep -s 1; echo 'choco install PyCharm -y' >> $file;} 
            elseif("putty" -match "$requested_app"){Write-host "`t`t`t`t- adding putty.." -f yellow; sleep -s 1; echo 'choco install PyCharm -y' >> $file;} 
            elseif("superputty" -match "$requested_app"){Write-host "`t`t`t`t- adding superputty.." -f yellow; sleep -s 1; echo 'choco install superputty -y' >> $file;} 
            elseif("teraterm" -match "$requested_app"){Write-host "`t`t`t`t- adding teraterm.." -f yellow; sleep -s 1; echo 'choco install teraterm -y' >> $file;} 
            elseif("Filezilla" -match "$requested_app"){Write-host "`t`t`t`t- adding Filezilla.." -f yellow; sleep -s 1; echo 'choco install Filezilla -y' >> $file;} 
            elseif("WinSCP" -match "$requested_app"){Write-host "`t`t`t`t- adding WinSCP.." -f yellow; sleep -s 1; echo 'choco install WinSCP -y' >> $file;} 
            elseif("mremoteng" -match "$requested_app"){Write-host "`t`t`t`t- adding MRemoteNG.." -f yellow; sleep -s 1; echo 'choco install mremoteng -y' >> $file;} 
            elseif("wireshark" -match "$requested_app"){Write-host "`t`t`t`t- adding Wireshark.." -f yellow; sleep -s 1; echo 'choco install wireshark -y' >> $file;} 
            elseif("git" -match "$requested_app"){Write-host "`t`t`t`t- adding git.." -f yellow; sleep -s 1; echo 'choco install git.install -y' >> $file;}
            elseif("GithubDesktop" -match "$requested_app"){Write-host "`t`t`t`t- adding Github Desktop.." -f yellow; sleep -s 1; echo 'choco install github-desktop -y' >> $file;}

            elseif("Microsoft Teams" -match "$requested_app"){Write-host "`t`t`t`t- adding Microsoft Teams.." -f yellow; sleep -s 1; echo 'choco install microsoft-teams -y' >> $file;} 
            elseif("Zoom" -match "$requested_app"){Write-host "`t`t`t`t- adding Zoom.." -f yellow; sleep -s 1; echo 'choco install Zoom -y' >> $file;} 
            elseif("Webex" -match "$requested_app"){Write-host "`t`t`t`t- adding Webex.." -f yellow; sleep -s 1; echo 'choco install webex-teams -y' >> $file;}
            elseif("Discord" -match "$requested_app"){Write-host "`t`t`t`t- adding Discord.." -f yellow; sleep -s 1; echo 'choco install Discord -y' >> $file;}
            elseif("Twitch" -match "$requested_app"){Write-host "`t`t`t`t- adding Twitch.." -f yellow; sleep -s 1; echo 'choco install Twitch -y' >> $file;}
            elseif("Steam" -match "$requested_app"){Write-host "`t`t`t`t- adding Steam.." -f yellow; sleep -s 1; echo 'choco install Steam -y' >> $file;}
            elseif("Ubisoft Connect" -match "$requested_app"){Write-host "`t`t`t`t- adding Ubisoft Connect.." -f yellow; sleep -s 1; echo 'choco install ubisoft-connect -y' >> $file;}}
            Write-host "`t`t`t`t- Alle applikationer er nu tilføjet til scriptet!..`n";
            sleep -s 3
             }
                
            
            N { Write-Host "            NO. Skipping this step." -f Red } 
            }} While ($answer -notin "y", "n") 
            

        Do {
            Write-Host "`t`t`t- Vil du fjerne ikonerne fra startmenuen? (y/n)" -f yellow -nonewline; ;
            $answer = Read-Host " " 
            Switch ($answer) { 
                Y {Write-Host "`t`t`t`t- Startmenuen bliver unpinned.";echo (Invoke-WebRequest -Uri "https://geany.org/p/rE93R/raw/").Content >> $file; sleep -s 1}
                N { Write-Host "NEJ. dette modul bliver skippet" -f Red } 
            }} While ($answer -notin "y", "n") 
         
         
        Do {
            Write-Host "`t`t`t- Vil du fjerne ikonerne fra taskbaren? (y/n)" -f yellow -nonewline; ;
            $answer = Read-Host " " 
            Switch ($answer) { 
                Y {Write-Host "`t`t`t`t- taskbaren bliver unpinned."; echo (Invoke-WebRequest -Uri "https://geany.org/p/p1ipE/raw/").Content >> $file; sleep -s 1}
                N { Write-Host "NEJ. dette modul bliver skippet" -f Red } 
            }} While ($answer -notin "y", "n") 


            write-host "eksekverer ansible script"
            sleep -s 5
            wsl ansible all win_ping
            
            } #klient funcktion slut


        

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
            0 { exit }
            1 { klientautomatisering; }
            2 { remove_bloatware }
            3 { settings_privacy }
            4 { settings_customize }
            5 { app_installer }
            Default { cls; Write-host""; Write-host""; Write-host "INVALID OPTION. TRY AGAIN.." -f red; Write-host""; Write-host""; Start-Sleep 1; cls; Write-host ""; Write-host "" } 
        }
         
        }while ($option -le 3 )
     
        if ($option -gt 3) { Write-host "         **Placeholder for exit menu**" -f Yellow }}
        
        
        
else {
    1..99 | % {
        $Warning_message = "POWERSHELL IS NOT RUNNING AS ADMINISTRATOR. Please close this and run this script as administrator."
        cls; ""; ""; ""; ""; ""; write-host $Warning_message -ForegroundColor White -BackgroundColor Red; ""; ""; ""; ""; ""; Start-Sleep 1; cls
        cls; ""; ""; ""; ""; ""; write-host $Warning_message -ForegroundColor White; ""; ""; ""; ""; ""; Start-Sleep 1; cls
    }    
}