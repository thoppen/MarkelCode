Param(
    [Parameter(Mandatory=$False)][String]$Type = "test",               #  Server Type - Server/Workstation
    [Parameter(Mandatory=$False)][Int]$Memory = 1                #  Total Memory (in GB)
)

Write-Host "Type: $Type"
Write-Host "Memory: $Memory"

#  Set the Output Filename
$FileName = "CMDB_Export_$(Get-Date -Format 'yyyyMMdd').csv"
$Path = "D:\Development\Markel\CMDB"
$FilePath = "$Path\$FileName"
Write-Host "Output File:  $FilePath"

#  Create the output object record for the CSV export
$Output = [PSCustomObject][Ordered]@{
    'Type'                        = $Type
    'Total RAM (GB)'              = $Memory
}

Write-Host $Output

$Output | Export-CSV -Path $FilePath -NoTypeInformation -Append -Force