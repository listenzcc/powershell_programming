$folder = 'Microsoft.PowerShell.Core\FileSystem::\\nicaqnap\nica_datastation_1\fukaicheng_data_1\diskb\761957\preproc'

echo $folder

$file = (ls $folder -filter '*REST1*.zip')[0]
$full = $folder + '\\' + $file
echo $full 
echo --------------------------------------

# requires -Version 5.0

# change $Path to a ZIP file that exists on your system!
# $Path = "$Home\Desktop\Test.zip"
$Path = $full.replace('Microsoft.PowerShell.Core\FileSystem::', '')

# change extension filter to a file extension that exists
# inside your ZIP file
# $Filter = 'rfMRI_REST2_LR.nii.gz'
$Filter = '*/MNINonLinear/Results/rfMRI_REST1_RL/Movement_RelativeRMS.txt'
# $Filter = '*/MNINonLinear/Results/rfMRI_REST1_RL/rfMRI_REST1_RL.nii.gz'
# change output path to a folder where you want the extracted
# files to appear
$OutPath = 'C:\Users\liste\Documents\powershell_programming'

# ensure the output folder exists
$exists = Test-Path -Path $OutPath
if ($exists -eq $false) {
    $null = New-Item -Path $OutPath -ItemType Directory -Force
}

# load ZIP methods
Add-Type -AssemblyName System.IO.Compression.FileSystem

# open ZIP archive for reading
$zip = [System.IO.Compression.ZipFile]::OpenRead($Path)

echo $zip.Entries

echo $zip.Entries |
Where-Object { $_.FullName -like $Filter } 
# find all files in ZIP that match the filter (i.e. file extension)
$zip.Entries | 
Where-Object { $_.FullName -like $Filter } |
ForEach-Object { 
    # extract the selected items from the ZIP archive
    # and copy them to the out folder
    $FileName = $_.Name
    [System.IO.Compression.ZipFileExtensions]::ExtractToFile($_, "$OutPath/$fileName", $true)
}

# close ZIP file
$zip.Dispose()

# open out folder
explorer $OutPath 