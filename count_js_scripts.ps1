#Search recursively in the specified path to get all directories 
$dirs_all = Get-ChildItem -Path D:\Research\IoT_Mobile_Project\iot_companion_appset\cordova_apps -exclude *.ps1,*.txt,*.html

$total_scripts = 0
foreach($dir in $dirs_all)
{
    cd $dir    
    $scripts = Get-ChildItem -Path $dir\scripts          
    $total_scripts += $scripts.Count   
    cd..
}

Write-Output $total_scripts
