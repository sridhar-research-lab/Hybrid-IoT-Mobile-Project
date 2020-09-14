#Search recursively in the specified path to get all directories 
$dirs_all = Get-ChildItem -Path D:\Research\IoT_Mobile_Project\iot_companion_appset\iot_companion_apps_set1\iot_companion_apps_set1_unpacked -exclude *.ps1,*.txt,*.html
#For each directory in cordova_apps directory
foreach($dir in $dirs_all)
{
    cd $dir
    #Get file apktool.yml from the app directory. apktool.yml is created when APK is extracted using apktool
	$apktool_file = Get-ChildItem -Path $dir -Filter apktool.yml -File -Name
    
    if($apktool_file -ne $null)
    {
        #From apktool.yml extract the line containing the following string pattern
        $sdk_version_string = Select-String -Path $apktool_file -Pattern "targetSdkVersion:....."
    }
    

    if($sdk_version_string -ne $null)
    {
        #Extract just the SDK version number from the entire matching string
        $sdk_version_buildnumber = $sdk_version_string | foreach {$_.Matches.Value} 
        $sdk_version_quotes = $sdk_version_buildnumber -split " "
        $sdk_version_quotes = $sdk_version_quotes -split "'"
        $sdk_version = $sdk_version_quotes[2]

        #Check for a specific SDK version
        if($sdk_version -eq "23")
            {
                $dir.Name >> "sdk23_2.txt"
            }        
    }
}



