
Import-Module ActiveDirectory


function update-365PrimaryDomain 
{
    # Enter the OU holding the users you want to update 
    # EX. OU=SBSUsers,OU=Users,OU=MyBusiness,DC=face2face,DC=local
    Parameter(
        Mandatory = $true, 
        ValueFromPipeline = $true, 
        ValueFromPipelineByPropertyName = $true)
    [string]
    $SelectedOU

    # Enter domain name
    Parameter(Mandatory = $true)
    [string]
    $domain

    $users = Get-ADUser -SearchBase "$SelectedOU" -Filter *
    foreach ($user in $users) {
        $email = $user.samaccountname + "@" + $domain + ".com"
        $newemail = "SMTP:" + $email
        if(get-aduser.proxyAddresses -eq $newemail){
            continue}
        else {
            Set-ADUser $user -Add @{proxyAddresses = ($newemail)}
        }
    }
}
