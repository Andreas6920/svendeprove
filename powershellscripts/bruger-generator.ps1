
# Bruger Oprettelse
        
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
        $navn = "$fornavn $efternavn"
        #Username
        $part1 = $fornavn.Substring(0,3).toLower().replace("æ","a").replace("ø","o").replace("å","a")+$efternavn.Substring(0,3).toLower().replace("æ","a").replace("ø","o").replace("å","a")
        $part2 = 1
        #email
        $part4 = "@god.rm.dk"
        $email = $part1+$part2+$part4

        Write-host $fornavn";"$efternavn";;"$afdeling""


        }