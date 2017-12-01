<#
.SYNOPSIS
    Updates primary SMTP to user@exDomain.com from user.exDomain.onmicrosoft.com
.DESCRIPTION
    This is used at clients with Office 365 with Azure AD Connect but no on prem exchange for managing exchange atributes.
    By default, all new users will have the .onmicrosoft domain as primary domain.  
    The only way to change that is to update the users ProxyAddress attribute. 
    This script automates that process and can be used to update all users after the initial Azure AD connect sync, or as new users are added. 
    If the users ProxyAdress is already correct, the user will be skipped. 
Requires -version 2.0
Requires -Modules ActiveDirectory
Requires -RunAsAdministrator 
.PARAMETER $SelectedOU
    Enter the OU holding the users you want to update .  
    Be careful with where this applies. Do not apply to domain root.
    EX.OU=SBSUsers,OU=Users,OU=MyBusiness,DC=face2face,DC=local
.PARAMETER $Domain
    Enter the domain name you want set as Primary for the user. 
    Ex. MyDomain 
.REQUIRES
  .NOTES
  Version:        1.0
  Author:         Randy Lobb
  Creation Date:  11/21/17
  ADDITIONAL REQUIREMENTS:None 
#>

function update-365PrimaryDomain 
{
    # 
    # EX. 
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
            $user.samaccountname + "'s ProxyAddress has been updated to " + $newemail | Out-File c:\smtpupdateLOG.txt -Append
        }
    }
}
