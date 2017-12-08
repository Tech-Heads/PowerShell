function Start-AllAzureVMs () {
    
    [CmdletBinding]
    # Parameter help description
    [Parameter(mandatory=$true)]
    $ResourceGroup

    Get-AzureRmVM -ResourceGroupName $ResourceGroup | ForEach {stop-azurermvm -name $_.name -ResourceGroupName $ResourceGroup}

# Get-AzureRmVM -ResourceGroupName R2Lab | ForEach {stop-azurermvm -name $_.name -ResourceGroupName R2Lab}
