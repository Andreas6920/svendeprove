cls
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process -Force



# Opret OU
 # New-ADOrganizationalUnit -Name Users -Path OU=UK,DC=aplast3d,DC=com -ProtectedFromAccidentalDeletion $False
 New-ADOrganizationalUnit -Name "HEV" -Path "DC=HEV,DC=RM,DC=LOCAL" -ProtectedFromAccidentalDeletion $False
 New-ADOrganizationalUnit -Name "Users" -Path "OU=HEV,DC=HEV,DC=RM,DC=LOCAL" -ProtectedFromAccidentalDeletion $False
 New-ADOrganizationalUnit -Name "Departments" -Path "OU=Users,OU=HEV,DC=HEV,DC=RM,DC=LOCAL" -ProtectedFromAccidentalDeletion $False
    New-ADOrganizationalUnit -Name "Hospitalsledelsen" -Path "OU=Departments,OU=Users,OU=HEV,DC=HEV,DC=RM,DC=LOCAL" -ProtectedFromAccidentalDeletion $False
    New-ADOrganizationalUnit -Name "Staben" -Path "OU=Departments,OU=Users,OU=HEV,DC=HEV,DC=RM,DC=LOCAL" -ProtectedFromAccidentalDeletion $False
    New-ADOrganizationalUnit -Name "Akut" -Path "OU=Departments,OU=Users,OU=HEV,DC=HEV,DC=RM,DC=LOCAL" -ProtectedFromAccidentalDeletion $False



# Bruger Oprettelse
    $ou = (invoke-webrequest -uri "https://raw.githubusercontent.com/Andreas6920/svendeprove/main/afdelinger.txt").content
        
    #Bruger oprettelse
    $fornavne = (Invoke-WebRequest -uri "https://raw.githubusercontent.com/Andreas6920/svendeprove/main/fornavne.txt").content
    $Efternavne = (Invoke-WebRequest -uri "https://raw.githubusercontent.com/Andreas6920/svendeprove/main/efternavne.txt").content

    Write-host "antal" -NoNewline
    $antal = Read-host " "

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
    
        if(!(get-aduser -Filter 'Name -like "$part1*"')){$part2="0"+$part2}
        else {$part2=1+(get-aduser -Filter 'Name -like "$part1*"').Name.Count;}
        if($part2 -lt 10){$part2="0"+$part2}
        $username = $part1+$part2

        New-ADUser `
        -Path OU=Users,OU=UK,DC=aplast3d,DC=com `
        -Office Gødstrup Sygehus `
        -Department Warehouse `
        -Title Stock Worker `
        -Name JUME `
        -UserPrincipalName $email `
        -DisplayName $navn `
        -GivenName $fornavn `
        -Surname $efternavn `
        -AccountPassword (ConvertTo-SecureString "Pa55w.rd" -AsPlainText -Force) -PassThru| Enable-ADAccount
        
        Write-host `t`t`t"BRUGER: "$firstname $lastname "oprettes.." -f yellow

        #Change password at logon
        #Set-ADUser -Identity <samAccountName> -ChangePasswordAtLogon $true

                }






    
     

# Security Group oprettelse
