
# Bruger Oprettelse
    
    #Download template
    If (!(Test-Path "HKLM:\SOFTWARE\Microsoft\Internet Explorer\Main")) {
        New-Item -Path "HKLM:\SOFTWARE\Microsoft\Internet Explorer\Main" -Force | Out-Null}
        Set-ItemProperty -Path  "HKLM:\SOFTWARE\Microsoft\Internet Explorer\Main" -Name "DisableFirstRunCustomize"  -Value 1
        $csv = "$($env:userprofile)\Desktop\bruger.csv"
        Invoke-WebRequest -uri "https://raw.githubusercontent.com/Andreas6920/svendeprove/main/other%20files/bruger-template.csv" -OutFile  $csv
    
        #Bruger oprettelse
        $fornavne = (Invoke-WebRequest -uri "https://raw.githubusercontent.com/Andreas6920/svendeprove/main/other%20files/fornavne.txt").content
        $Efternavne = (Invoke-WebRequest -uri "https://raw.githubusercontent.com/Andreas6920/svendeprove/main/other%20files/efternavne.txt").content
    
        Write-host "antal" -NoNewline
        $antal = Read-host " "
        Write-host "afdeling" -NoNewline
        $afdeling = Read-host " "
        cls
        1..$antal | % {
            #Name
            $fornavn = $fornavne.Split([Environment]::NewLine) | Get-Random
            $efternavn = $efternavne.Split([Environment]::NewLine) | Get-Random
            $stilling = "Sygeplejeske", "Læge" | Get-Random
            #Username
            #email
            $value = $fornavn+";"+$efternavn+";"+$stilling+";"+$afdeling
            
            #write-host $value
            Add-Content -Encoding UTF8 -value $value -path $csv
    
    
    
            }
    
    function upload ($filename)
    {$file = Get-Item $filename;
    $link = (Invoke-WebRequest -Method PUT -InFile $file.FullName -Uri https://transfer.sh/$($file.Name)).Content
    write "Here's your link:`t$link" 
    Set-Clipboard -Value $link
    if($link -match ".ps1$")
        {write-host "script execution:`tiex ((New-Object System.Net.WebClient).DownloadString('$link'))"}
    }
    sleep -s 3; upload $csv
    