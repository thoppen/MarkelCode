<#

    Example script for outputting a CSV file based on input parameters

#>


[CMDletBinding()]Param(
    [Parameter(Mandatory=$False)][String]$Type="Test",                #  Server Type - Server/Workstation
    [Parameter(Mandatory=$False)][Int]$Memory=1                 #  Total Memory (in GB)
)


#  Reset the error counter
$Error.Clear()


#  Write verbose header
Write-Verbose "Create CMDB CSV File"
Write-Verbose "Executed $(Get-Date)"


#  Set the Output Filename
$FileName = "CMDB_Export_$(Get-Date -Format 'yyyyMMdd').csv"
$FilePath = "$Path\$FileName"
Write-Verbose "Output File:  $FilePath"


#  Set the proper export values based on server/workstation
Switch ($Type) {

    "Server"      {
        $Model        = 'VMware Virtual Server Platform';
        $AssetType    = 'Server Environment/Server'
        $RoleInCharge = 'Global Platform Support Services'
    }
    
    "Workstation" {
        $Model        = 'VMware Virtual Workstation Platform'
        $AssetType    = 'Computer/Workstation'
        $RoleInCharge = 'Desktop Services'
    }
    
    Default {
        $Model        = 'VMware Virtual Server Platform'
        $AssetType    = 'Server Environment/Server'
        $RoleInCharge = 'Global Platform Support Services'
    }
}


#  Set the proper export values based on selected environment
Switch ($Environment) {
    "Production"  { $CIStatus = "In Production" }
    "Test"        { $CIStatus = "Development" }
    "Development" { $CIStatus = "Development" }
    Default       { $CIStatus = "In Production" }
}


#  Create the output object record for the CSV export
$Output = [PSCustomObject][Ordered]@{
    'Type'                        = $AssetType
    'Total RAM (GB)'              = $Memory
}


#  Write the output object if verbose
Write-Verbose $Output


#  Output the CSV record
$Output | Export-CSV -Path $FilePath -NoTypeInformation -Append -Force


#  Send the individual CSV file by email, if desired
If ($Email) { 
    $Attachment = "$Path\CMDB_Export_$RequestID`_$(Get-Date -Format 'yyyyMMdd').csv"
    $Output | Export-CSV -Path $Attachment
    $MailServer = 'smtp.markelcorp.com'
    $Sender     = 'DoNotReply@markelcorp.com'
    $Recipients = 'rgoetzinger@mmarkelcorp.com'
    $Subject    = "Server Build #$RequestID"
    $Body       = "Server Build #$RequestID by $RequestUser on $(Get-Date -Format 'yyyy/MM/dd')"
    Send-MailMessage -SmtpServer $MailServer -From $Sender -To $Recipients -Subject $Subject -Body $Body -Attachments $Attachment -BodyAsHtml
    Remove-Item $Attachment -Force | Out-Null
}


#  Exit out with the error count
# Exit $Error.Count
