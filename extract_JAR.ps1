#Search recursively in the specified path to get all directories 
$jars_all = Get-ChildItem -Path D:\Research\IoT_Mobile_Project\iot_companion_appset\iot_companion_apps_set14\iot_companion_apps_set14_APKs\JARs\webview -exclude *.ps1 

foreach($jar in $jars_all)
{
    jadx.bat $jar
}