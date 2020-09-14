#Search recursively in the specified path to get all directories 
$dirs_all = Get-ChildItem -Path D:\Research\IoT_Mobile_Project\iot_companion_appset\cordova_apps -exclude *.ps1,*.txt,*.html,*.csv


foreach($dir in $dirs_all)
{
	$js_files = Get-ChildItem -Path $dir\scripts -File -Name
    foreach($js_file in $js_files)
    {
        $eval = Select-String -Path $dir\scripts\$js_file -caseSensitive -SimpleMatch  -Pattern "eval("
        if($eval -ne $null)
        {
            $dir.Name + " " + $js_file >> D:\Research\IoT_Mobile_Project\iot_companion_appset\eval.txt
        }
    }
    
    
}