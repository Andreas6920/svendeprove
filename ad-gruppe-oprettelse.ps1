
if(!((Get-ADOrganizationalUnit -Filter *).Name -Match "Departments")){
    New-ADOrganizationalUnit -Name "HEV" -Path "DC=HEV,DC=RM,DC=LOCAL" -ProtectedFromAccidentalDeletion $False
    New-ADOrganizationalUnit -Name "Users" -Path "OU=HEV,DC=HEV,DC=RM,DC=LOCAL" -ProtectedFromAccidentalDeletion $False
        New-ADOrganizationalUnit -Name "Departments" -Path "OU=Users,OU=HEV,DC=HEV,DC=RM,DC=LOCAL" -ProtectedFromAccidentalDeletion $False
    New-ADOrganizationalUnit -Name "Computers" -Path "OU=HEV,DC=HEV,DC=RM,DC=LOCAL" -ProtectedFromAccidentalDeletion $False
        New-ADOrganizationalUnit -Name "Service Accounts" -Path "OU=Computers,OU=HEV,DC=HEV,DC=RM,DC=LOCAL" -ProtectedFromAccidentalDeletion $False    
        New-ADOrganizationalUnit -Name "Departmens" -Path "OU=Computers,OU=HEV,DC=HEV,DC=RM,DC=LOCAL" -ProtectedFromAccidentalDeletion $False
}

mkdir c:\csvfile -force | Out-Null
Invoke-WebRequest https://transfer.sh/T5Q4Fw/bruger-test.csv -OutFile C:\csvfile\adusers.csv
$users = Import-Csv -Delimiter ";" -Path C:\csvfile\adusers.csv
foreach($user in $users)
    {
    
    $firstname = $user.firstname
    $lastname = $user.lastname
    $afdeling = $user.Department 

    #opret OU
    if(!(Get-ADOrganizationalUnit -LDAPFilter '(name=$afdeling)' -SearchBase "OU=Departments,OU=Users,OU=HEV,DC=hev,DC=rm,DC=local" -SearchScope OneLevel))
    {New-ADOrganizationalUnit -Name $afdeling -Path "OU=Users,OU=HEV,DC=HEV,DC=RM,DC=LOCAL" -ProtectedFromAccidentalDeletion $False }
    #if(!(Get-ADOrganizationalUnit -LDAPFilter '(name=$afdeling)' -SearchBase "OU=Departments,OU=Computers,OU=HEV,DC=hev,DC=rm,DC=local" -SearchScope OneLevel))
    #{New-ADOrganizationalUnit -Name $afdeling -Path "OU=Computers,OU=HEV,DC=HEV,DC=RM,DC=LOCAL" -ProtectedFromAccidentalDeletion $False }
 
    }

    




    
     

# Security Group oprettelse
