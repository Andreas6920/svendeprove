cls
## Needed to be fixed list:
### OU genopretning.
### Spørg gruppen - Hvor skal shares placeres? evt. iSCSI fra filserver.
### Share - Personlige mapper skal stadig oprettes til brugerne.
### Security - Lav hash genkendelse
### Security - Krypter fil

# Download csv

    If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Internet Explorer\Main")) {
            New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Internet Explorer\Main" -Force | Out-Null}
            Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Internet Explorer\Main" -Name "DisableFirstRunCustomize" -Type DWord -Value 1

    Write-host "`t- Downloader CSV fil:" -f white 
        $csv_link = "https://transfer.sh/kode/brugere.csv"
        $csv_location =  "C:\csvfile\adusers.csv"
        Write-host "`t`t- Klargøre mappe til fil.." -f green
        mkdir (Split-Path $csv_location -Parent) -Force | Out-Null
        Write-host "`t`t- Downloader filen til mappen.." -f green
        Invoke-WebRequest $csv_link -OutFile $csv_location ; sleep -s 2
        
        
        $csv = Import-Csv -Delimiter ";" -Path $csv_location


# Opret OU
    Write-host "`t- Opretter OU struktur:" -f White 
        if(!((Get-ADOrganizationalUnit -Filter *).Name -Match "Departments")){
            Write-host "`t`t- Opretter basemapperne.." -f green 
            New-ADOrganizationalUnit -Name "HEV" -Path "DC=HEV,DC=RM,DC=LOCAL" -ProtectedFromAccidentalDeletion $False
                New-ADOrganizationalUnit -Name "Users" -Path "OU=HEV,DC=HEV,DC=RM,DC=LOCAL" -ProtectedFromAccidentalDeletion $False
                    New-ADOrganizationalUnit -Name "Departments" -Path "OU=Users,OU=HEV,DC=HEV,DC=RM,DC=LOCAL" -ProtectedFromAccidentalDeletion $False
                    New-ADOrganizationalUnit -Name "Service Accounts" -Path "OU=Users,OU=HEV,DC=HEV,DC=RM,DC=LOCAL" -ProtectedFromAccidentalDeletion $False    
                New-ADOrganizationalUnit -Name "Computers" -Path "OU=HEV,DC=HEV,DC=RM,DC=LOCAL" -ProtectedFromAccidentalDeletion $False
                    New-ADOrganizationalUnit -Name "Departmens" -Path "OU=Computers,OU=HEV,DC=HEV,DC=RM,DC=LOCAL" -ProtectedFromAccidentalDeletion $False
                Start-sleep -s 3           }
        Write-host "`t`t- Scanner CSV fil for nye OU'er:" -f green; sleep -s 2
            $ou_userdep = 'OU=Departments,OU=Users,OU=HEV,DC=hev,DC=rm,DC=local'
            $ou_computerdep = 'OU=Departments,OU=Computers,OU=HEV,DC=hev,DC=rm,DC=local'
            $csv_department = $csv.Department | Sort | Get-Unique
            foreach($dep in $csv_department){
            if(!((Get-ADOrganizationalUnit -LDAPFilter '(name=$dep)' -SearchBase $ou_userdep  -SearchScope OneLevel).Name))
                {Write-host "`t`t`t- Opretter $dep.." -f green 
                New-ADOrganizationalUnit -Name $dep -Path "OU=Departments,OU=Users,OU=HEV,DC=HEV,DC=RM,DC=LOCAL" -ProtectedFromAccidentalDeletion $False; Sleep -s 1
                New-ADOrganizationalUnit -Name $dep -Path "OU=Departmens,OU=Computers,OU=HEV,DC=hev,DC=rm,DC=local" -ProtectedFromAccidentalDeletion $False }}
                Start-sleep -s 5


# Opret AD-Brugere
    Write-host "`t- Opretter Brugere:" -f white 
        #Statiske variabler
        $maildomain = "@hev.rm.dk"
        $number = 1
        $company = "Hospitalsenheden vest"
        $office = "Gødstrup Sygehus"

        foreach($user in $csv)
            {
            #brugernavn
            $fornavn = $user.firstname
            $efternavn = $user.lastname
            $part1 = $fornavn.Substring(0,3).toUpper().replace("Æ","A").replace("Ø","O").replace("Å","A")+$efternavn.Substring(0,3).toUpper().replace("Æ","A").replace("Ø","O").replace("Å","A")
            #ou build
            $username = $Part1+"0"+$number
            $Name = "$fornavn $efternavn"
            $afdeling = $user.Department
            $ou = "OU="+$afdeling+",OU=Departments,OU=Users,OU=HEV,DC=HEV,DC=RM,DC=LOCAL"
            $title = $user.Title

            $eksisterende_bruger = Get-ADUser -Filter {sAMAccountName -eq $Username}
            If ($eksisterende_bruger -ne $Null)
                {Write-host "`t`t`t- $username findes allerede!" -f yellow
                $count=((Get-ADUser -Filter *).sAMAccountName -cMatch "$part1*").Count+1
                if($count -le 9){$username = $Part1+"0"+$count}
                else{$username = $Part1+$count}
                Write-host "`t`t`t`t- Bruger navngivet $username istedet!" -f green
                }
        
            Write-host "`t`t`t- Opretter"$fornavn" "$efternavn" til $afdeling afdelingen" -f green
                New-ADUser -Path $ou -Department $afdeling -Name $Name -Title $title  -UserPrincipalName $username$maildomain -DisplayName $username `
                -GivenName $fornavn -Surname $efternavn -Company $company -Office $office -AccountPassword (ConvertTo-SecureString "Pa55w.rd" -AsPlainText -Force -ErrorAction Ignore) -PassThru| Enable-ADAccount} 
            
            Start-sleep -s 5


# Opret security groups
    Write-host "`t- Opretter Security groups:" -f White 

        $secfoldername = "SecurityGroups"
        $sec_root =(Get-ADDomain).DistinguishedName
        $sec_dest = "OU=$secfoldername,OU=HEV,DC=hev,DC=rm,DC=local"

        # create security group OU and adding department to it
        if (!(get-ADOrganizationalUnit -Filter {Name -eq $secfoldername})){
            New-ADOrganizationalUnit -Name $secfoldername -Path "OU=HEV,DC=hev,DC=rm,DC=local" -ProtectedFromAccidentalDeletion $False}
    

        $afdelinger = (get-aduser -filter * -property department).department | Sort-Object -Unique
        foreach ($afdeling in $afdelinger){
        $SecGroupName = "Sec_"+$afdeling.Replace(" ","")
        if (!(Get-ADGroup -Filter {Name -eq $SecGroupName})){
            Write-host "`t`t- $SecGroupName oprettet.." -f green
        New-ADGroup -Name $SecGroupName -SamAccountName $afdeling -GroupCategory Security -GroupScope Global -DisplayName $afdeling -Path "$sec_dest"
        Write-host "`t`t`t- Tilføjer alle fra $afdeling til $SecGroupName.." -f Green
        Get-ADUser -Filter 'Department -eq $afdeling' | ForEach-Object {Add-ADGroupMember -Identity $afdeling -Members $_ }
            }}
        
        Start-sleep -s 5
        
        