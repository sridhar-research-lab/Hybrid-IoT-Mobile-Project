#Search recursively in the specified path to get all directories 
$dirs_all = Get-ChildItem -Path D:\Research\IoT_Mobile_Project\iot_companion_appset\cordova_apps -exclude *.ps1,*.txt,*.html


foreach($dir in $dirs_all)
{
    cd $dir
    mkdir scripts
    $scripts = Get-ChildItem -Path . -Filter scripts.txt -File -Name          
    
    foreach($line in Get-Content $scripts) 
    {
        cp assets\$line scripts
    }
    
    cd..
}

