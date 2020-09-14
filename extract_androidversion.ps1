#Search recursively in the specified path to get all directories 
$dirs_all = Get-ChildItem -Path D:\Research\IoT_Mobile_Project\iot_companion_appset\cordova_apps -exclude *.ps1,*.txt,*.html,*.csv

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
        $sdk_version = [string]$sdk_version_quotes[2]        
    }
    #Create object to write to CSV
    $testObject = [pscustomobject]@{'App Name' = $dir.name; 'Android SDK' = $sdk_version}
    #Write to CSV
    $testObject | Export-Csv -Append -Path D:\Research\IoT_Mobile_Project\iot_companion_appset\cordova_androidsdk.csv
}

#$android_SDKs.GetEnumerator() | sort -Property name

