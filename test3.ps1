$FileList = Get-ChildItem -Path "names.txt"

Function use_it($name) {
    $Count = ($FileList | Select-String -Pattern $name).length
    return $Count -gt 0
}

$folder = '\\nicaqnap\nica_datastation_1\fukaicheng_data_1'
echo $folder
Get-ChildItem $folder |
ForEach-Object {
    $disk = $_.Name
    $subfolder = $folder + '\\' + $disk
    Get-ChildItem $subfolder |
    Where-Object { use_it($_.Name) } |
    ForEach-Object {
        echo $_.Name
    }
    # $Subject = $_.Name
    # $Path = $subfolder + '\\' + $Subject +'\\preproc'
    # $Filter1 = '*3T_*fMRI*.zip'
    # Get-ChildItem $Path |
    # Where-Object { $_.Name -like $Filter1 } |   
    # ForEach-Object {
    #     $filename1 = $_.Name
    #     $Path2 = $Path + '\\' + $filename1
    #     $filename2 = $filename1 -replace '_preproc.zip',''
    #     $temp = $Subject + '_'
    #     $filename2 = $filename2 -replace $temp,''
    #     $Filter2 = '*/MNINonLinear/Results/*/Movement_RelativeRMS_mean.txt'
    #     $OutPath = 'H:\test2' + '\\' + $disk + '\\' + $Subject + '\\' + $filename2
    #     $exists = Test-Path -Path $OutPath
    #     if ($exists -eq $false) {
    #         $null = New-Item -Path $OutPath -ItemType Directory -Force
    #     }
    #     $zip = [System.IO.Compression.ZipFile]::OpenRead($Path2)
    #     $zip.Entries | 
    #     Where-Object { $_.FullName -like $Filter2 } |
    #     ForEach-Object { 
    #         # extract the selected items from the ZIP archive
    #         # and copy them to the out folder
    #         $FileName = $_.Name
    #         [System.IO.Compression.ZipFileExtensions]::ExtractToFile($_, "$OutPath/$fileName", $true)
    #     }
    #     $zip.Dispose()
    # }
}

