cls
# CSV håndtering 
    Write-host "`t- CSV håndtering:" -f white 
        $csv_location =  "C:\csvfile\adusers.csv"
        Write-host "`t`t- Læser fil.." -f green
        $csv = Import-Csv -Delimiter ";" -Path $csv_location



# Opret OU
    Write-host "`t- Opretter OU struktur.." -f green 
    if(!((Get-ADOrganizationalUnit -Filter *).Name -Match "Departments")){
    Write-host "`t`t- Opretter basemapperne.." -f green 
    New-ADOrganizationalUnit -Name "HEV" -Path "DC=HEV,DC=RM,DC=LOCAL" -ProtectedFromAccidentalDeletion $False
    New-ADOrganizationalUnit -Name "Users" -Path "OU=HEV,DC=HEV,DC=RM,DC=LOCAL" -ProtectedFromAccidentalDeletion $False
    New-ADOrganizationalUnit -Name "Departments" -Path "OU=Users,OU=HEV,DC=HEV,DC=RM,DC=LOCAL" -ProtectedFromAccidentalDeletion $False
    New-ADOrganizationalUnit -Name "Computers" -Path "OU=HEV,DC=HEV,DC=RM,DC=LOCAL" -ProtectedFromAccidentalDeletion $False
    New-ADOrganizationalUnit -Name "Service Accounts" -Path "OU=Users,OU=HEV,DC=HEV,DC=RM,DC=LOCAL" -ProtectedFromAccidentalDeletion $False    
    New-ADOrganizationalUnit -Name "Departmens" -Path "OU=Computers,OU=HEV,DC=HEV,DC=RM,DC=LOCAL" -ProtectedFromAccidentalDeletion $False
    Start-sleep -s 3           }
    Write-host "`t`t- Scanner CSV fil for nye OU'er:" -f green; sleep -s 2
    $csv_department = $csv.Department | Sort | Get-Unique
    foreach($dep in $csv_department){
    if(!(Get-ADOrganizationalUnit -LDAPFilter '(name=$dep)' -SearchBase "OU=Departments,OU=Users,OU=HEV,DC=hev,DC=rm,DC=local" -SearchScope OneLevel))
    {Write-host "`t`t`t- Opretter $dep.." -f green 
    New-ADOrganizationalUnit -Name $dep -Path "OU=Departments,OU=Users,OU=HEV,DC=HEV,DC=RM,DC=LOCAL" -ProtectedFromAccidentalDeletion $False; Sleep -s 1 }
    if(!(Get-ADOrganizationalUnit -LDAPFilter '(name=$dep)' -SearchBase "OU=Departmens,OU=Computers,OU=HEV,DC=hev,DC=rm,DC=local" -SearchScope OneLevel))
    {New-ADOrganizationalUnit -Name $dep -Path "OU=Departmens,OU=Computers,OU=HEV,DC=hev,DC=rm,DC=local" -ProtectedFromAccidentalDeletion $False }}

# Opret AD
    Write-host "`t- Opretter Brugere.." -f green 
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
    $afdeling = $user.Department
    $ou = "OU="+$afdeling+",OU=Departments,OU=Users,OU=HEV,DC=HEV,DC=RM,DC=LOCAL"
    $title = $user.Title

    $eksisterende_bruger = Get-ADUser -Filter {sAMAccountName -eq $Username}
    If ($eksisterende_bruger -eq $Null)
    {Write-host "`t`t`t- Opretter"$fornavn" "$efternavn" til $afdeling afdelingen" -f green
    New-ADUser -Path $ou -Department $afdeling -Title $title -Name $username -UserPrincipalName $username$maildomain -DisplayName $username `
    -GivenName $fornavn -Surname $efternavn -Company $company -Office $office -AccountPassword (ConvertTo-SecureString "Pa55w.rd" -AsPlainText -Force) -PassThru| Enable-ADAccount}
    Else{
    Write-host "`t`t`t- $username findes allerede!" -f yellow
    $count=((Get-ADUser -Filter *).sAMAccountName -cMatch "$part1*").Count+1
    if($count -le 9){$username = $Part1+"0"+$count}
    else{$username = $Part1+$count}
    New-ADUser -Path $ou -Department $afdeling -Title $title -Name $username -UserPrincipalName $username$maildomain -DisplayName $username `
    -GivenName $fornavn -Surname $efternavn -Company $company -Office $office -AccountPassword (ConvertTo-SecureString "Pa55w.rd" -AsPlainText -Force) -PassThru| Enable-ADAccount}
    Write-host "`t`t`t`t- Bruger navngivet $username istedet!" -f green

    }

# Opret sec groups
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




# Opret SMB-Shares
    Write-host "`t- Opretter Security groups:" -f White 

    $Path = "Z:\"
    $Name = "user_shares"
    $SharePath = "$Path$Name\"

    if(!(test-path $SharePath)) {
    New-Item -ItemType Directory -Force -Path $SharePath | out-null
    Write-Host "`t`t- Rodmappe oprettet: $SharePath." -f green}

    New-Item -ItemType Directory -Force -Path $SharePath\General | out-null



    foreach($dep in $csv_department){
    $share_department_specific = "$SharePath$dep"

    # Opret afdelingsmapper
    if(!(test-path $share_department_specific)) {
    Write-host "`t`t`t- Opretter undermappe: $share_department_specific mappe:" -f green
    New-Item -ItemType Directory -Force -Path $share_department_specific | out-null}

    # RETTIGHEDER: Shares
    Write-host "`t`t`t`t- Opsætter Share rettigheder.." -f green; Sleep -s 1
    New-Smbshare -Name $dep  -Description "Delt mappe til afdeling: $dep" `
    -Path $share_department_specific -ea SilentlyContinue | out-null
    Grant-SmbShareAccess -AccountName $dep -Name $dep -AccessRight Change -Force | out-null

    # RETTIGHEDER: NTFS
    Write-host "`t`t`t`t- Opsætter NTFS rettigheder.." -f green
    $ntfs = Get-Acl \\$env:COMPUTERNAME\$dep
    $AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule("$dep","Modify","Allow")
    $ntfs.SetAccessRule($AccessRule)
    $ntfs | Set-Acl $share_department_specific 
    }