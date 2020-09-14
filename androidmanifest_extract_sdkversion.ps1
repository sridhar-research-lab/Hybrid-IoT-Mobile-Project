#Search recursively in the specified path to get all directories 
$dirs_all = Get-ChildItem -Path D:\Research\IoT_Mobile_Project\IoT_Apks_InitialSet_Classes -exclude *.ps1,*.txt,*.html

$android_SDKs = @{}

:nextDir foreach($dir in $dirs_all)
{
    cd $dir
	$AndroidManifest_file = Get-ChildItem -Path $dir -Filter AndroidManifest.xml -File -Name
    $sdk_version_string = Select-String -Path $AndroidManifest_file -Pattern 'android:compileSdkVersion=".."' 
    
    if($sdk_version_string -ne $null)
    {
        $sdk_version_string_array = @()
        $sdk_version_string_array = $sdk_version_string -split " "
        #$sdk_version_buildnumber = $sdk_version_string | foreach {$_.Matches.Value}
        
        foreach($string in $sdk_version_string_array)
        {
            if($string -match 'platformBuildVersionCode=".."')
            {
                continue nextDir
            }
        }    
            
        $sdk_version_buildnumber = $sdk_version_string | foreach {$_.Matches.Value}
        $sdk_version = $sdk_version_buildnumber -split '"'
        $sdk_version = $sdk_version[1]

        if($android_SDKs[$sdk_version] -eq $null)
        {
            $android_SDKs.add($sdk_version, 1)
        }
        else
        {
            $android_SDKs[$sdk_version]= $android_SDKs[$sdk_version]+1
        }        
        
    }    
}

$android_SDKs.GetEnumerator() | sort -Property name

