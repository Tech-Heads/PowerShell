#
#.synopsis "Starts all Azure VM's in the provided ResourceGroup
#.description I use this script to start all VMs in my Azure Lab resourcegroup.Being able to start and stop all VM's when needed keeps lab costs down.
#.example   Get-AzureRmVM -ResourceGroupName R2Lab | ForEach {start-azurermvm -name $_.name -ResourceGroupName R2Lab}
#requires -modules AzureRM 
function Start-AllAzureVMs () {
    
    [CmdletBinding]
    # Parameter help description
    [Parameter(mandatory=$true)]
    $ResourceGroup

    Get-AzureRmVM -ResourceGroupName $ResourceGroup | ForEach {stop-azurermvm -name $_.name -ResourceGroupName $ResourceGroup}
