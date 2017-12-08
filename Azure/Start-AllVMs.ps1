
function Start-AllAzureVMs () {
    
    [CmdletBinding]
    # Parameter help description
    [Parameter(mandatory=$true)]
    $ResourceGroup

    Get-AzureRmVM -ResourceGroupName $ResourceGroup | ForEach {start-azurermvm -name $_.name -ResourceGroupName $ResourceGroup}
}