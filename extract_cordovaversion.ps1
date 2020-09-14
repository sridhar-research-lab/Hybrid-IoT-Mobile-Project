#Search recursively in the specified path to get all directories 
$dirs_all = Get-ChildItem -Path D:\Research\IoT_Mobile_Project\iot_companion_appset\cordova_apps -exclude *.ps1,*.txt,*.html
#For each directory in cordova_apps directory
foreach($dir in $dirs_all)
{
    #Get cordova.js, i.e., cordova's main library file from the app folder
	$cordova_file = Get-ChildItem -Path $dir\assets -Filter cordova.js -Recurse -File -Name
    #Extract the line with the following string pattern to get the cordova version
    $cordova_version = Select-String -Path $dir\assets\$cordova_file -Pattern "var PLATFORM_VERSION_BUILD_LABEL"
    #Write the cordova version to a text file; do this for all apps
    $cordova_version >> 'cordova_version.txt'
}

