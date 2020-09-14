#Search recursively in the specified path to get all directories 
$dirs_all = Get-ChildItem -Path D:\Research\IoT_Mobile_Project\iot_companion_appset\iot_companion_apps_set2\iot_companion_apps_set2_APKs\JARs\webview -Exclude *.ps1,*.jar,*.txt
Write-Output $dirs_all.Count
foreach($dir in $dirs_all)
{
    cd $dir
    $java_files =  Get-ChildItem -Path . -Recurse -Filter *.java
    Write-Output $java_files.Count
    foreach ($java_file in $java_files)
        {
	        $SEL_jsenabled = Select-String -Path $java_file -Pattern 'setJavaScriptEnabled' -SimpleMatch
            $SEL_fileenabled = Select-String -Path $java_file -Pattern 'setAllowFileAccess' -SimpleMatch
            $SEL_fileURLenabled = Select-String -Path $java_file -Pattern 'setAllowFileAccessFromFileURLs' -SimpleMatch
            $SEL_loadUrl = Select-String -Path $java_file -Pattern 'loadUrl' -SimpleMatch 
            

            if($SEL_jsenabled -ne $null)
	        {
                #$SEL_jsenabled = $SEL_jsenabled.ToString().Split(":")[3]                
                $dir.Name + ',' + $SEL_jsenabled >> D:\Research\IoT_Mobile_Project\iot_companion_appset\iot_companion_apps_set2\iot_companion_apps_set2_APKs\JARs\webview\jsenabled.txt
	        }
            if($SEL_fileenabled -ne $null)
	        {
		        #$SEL_fileenabled = $SEL_fileenabled.ToString().Split(" ")[8]
                $dir.Name + ',' + $SEL_fileenabled >> D:\Research\IoT_Mobile_Project\iot_companion_appset\iot_companion_apps_set2\iot_companion_apps_set2_APKs\JARs\webview\fileenabled.txt
	        }
            if($SEL_fileURLenabled -ne $null)
	        {
		        #$SEL_fileURLenabled = $SEL_fileURLenabled.ToString().Split(" ")[8]
                $dir.Name + ',' + $SEL_fileURLenabled >> D:\Research\IoT_Mobile_Project\iot_companion_appset\iot_companion_apps_set2\iot_companion_apps_set2_APKs\JARs\webview\fileurlenabled.txt
	        }
            if($SEL_loadUrl -ne $null)
	        {
                #Write-Output $SEL_loadUrl                
                #$SEL_loadUrl = $SEL_loadUrl.ToString().Split(":")[3].Trim()
		        $dir.Name + ',' + $SEL_loadUrl >> D:\Research\IoT_Mobile_Project\iot_companion_appset\iot_companion_apps_set2\iot_companion_apps_set2_APKs\JARs\webview\loadurl.txt
	        }

        }
    cd ..  
}



