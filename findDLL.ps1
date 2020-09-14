#Search recursively in the specified path to get all directories 
$dirs_all = Get-ChildItem -Path D:\Research\IoT_Mobile_Project\iot_companion_appset\iot_companion_apps_set14\iot_companion_apps_set14_unpacked -exclude *.ps1,*.txt

foreach ($dir in $dirs_all)
{
	cd $dir
    $dll_files = Get-ChildItem -Path .\ -Filter *.dll -Recurse -File -Name
    if($dll_files -ne $null)
    {
        Write-Output $dir.Name
    }
}