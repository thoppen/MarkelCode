Param(
    [Parameter(Mandatory=$True)][String]$Type,               # Type
    [Parameter(Mandatory=$True)][String]$ciStatus,           # CI Status 
    [Parameter(Mandatory=$True)][String]$assetTag,           # Asset Tag 
    [Parameter(Mandatory=$True)][String]$manufacturer,       # Manufacturer 
    [Parameter(Mandatory=$True)][String]$model,              # Model 
    [Parameter(Mandatory=$True)][String]$serialNumber,       # Serial Number 
    [Parameter(Mandatory=$True)][String]$networkIdentifier,  # Network Identifier
    [Parameter(Mandatory=$True)][String]$responsiblePerson,  # Responsible Person
    [Parameter(Mandatory=$True)][String]$mainUser,           # Main User
    [Parameter(Mandatory=$True)][String]$deploymentType,     # Deployment Type
    [Parameter(Mandatory=$True)][String]$systemType,         # System Type
    [Parameter(Mandatory=$True)][Int]$numberOfCores,      # Number of Cores 
    [Parameter(Mandatory=$True)][Int]$numberOfCpus,       # Number of CPUs
    [Parameter(Mandatory=$True)][String]$location,           # Location 
    [Parameter(Mandatory=$True)][String]$roleInCharge,       # Role In Charge
    [Parameter(Mandatory=$True)][String]$functionalDomain,   # Functional Domain
    [Parameter(Mandatory=$True)][String]$ipAddress,          # IP Address
    [Parameter(Mandatory=$True)][Int]$totalCdisk,         # Total C Disk (gb) 
    [Parameter(Mandatory=$True)][Int]$totalRam,           # Total RAM (GB) 
    [Parameter(Mandatory=$True)][String]$itGroup,            # IT Group 
    [Parameter(Mandatory=$True)][String]$itSubGroup,         # IT Sub Group
    [Parameter(Mandatory=$True)][String]$nsxZone,            # NSX-Zone
    [Parameter(Mandatory=$True)][Int]$totalDisk,          # Total Disk
    [Parameter(Mandatory=$True)][String]$serverFunction,     # Server Function 
    [Parameter(Mandatory=$True)][String]$hostedBusinessApp   # Hosted Business Application
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
    'Type'                          =  $Type             
	'CI Status'                     =  $ciStatus         
    'Asset Tag'                     =  $assetTag         
    'Manufacturer'                  =  $manufacturer     
    'Model'                         =  $model            
    'Serial Number'                 =  $serialNumber     
    'Network Identifier'            =  $networkIdentifier
    'Responsible Person'            =  $responsiblePerson
    'Main User'                     =  $mainUser         
    'Deployment Type'               =  $deploymentType   
    'System Type'                   =  $systemType       
    'Number of Cores'               =  $numberOfCores    
    'Number of CPUs'                =  $numberOfCpus     
    'Location'                      =  $location         
    'Role In Charge'                =  $roleInCharge     
    'Functional Domain'             =  $functionalDomain 
    'IP Address'                    =  $ipAddress        
    'Total C Disk (gb)'             =  $totalCdisk       
    'Total RAM (GB)'                =  $totalRam         
    'IT Group'                      =  $itGroup          
    'IT Sub Group'                  =  $itSubGroup       
    'NSX-Zone'                      =  $nsxZone          
    'Total Disk'                    =  $totalDisk        
    'Server Function'               =  $serverFunction   
    'Hosted Business Application'   =  $hostedBusinessApp
}

Write-Host $Output

$Output | Export-CSV -Path $FilePath -NoTypeInformation -Append -Force