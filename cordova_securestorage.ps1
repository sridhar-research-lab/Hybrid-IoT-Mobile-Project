#Search recursively in the specified path to get all directories 
$dirs_all = Get-ChildItem -Path D:\Research\IoT_Mobile_Project\iot_companion_appset\cordova_apps -exclude *.ps1,*.txt,*.html,*.csv
#For each directory in cordova_apps directory
foreach($dir in $dirs_all)
{
    #Get all JS files from app directory (JS files are consolidated in scripts directory for each app)
	$js_files = Get-ChildItem -Path $dir\scripts -File -Name
    #Parse each JS file
    foreach($js_file in $js_files)
    {
        #Use pattern matching (window.openDatabase, cordova,plugins.SecureStorage, etc.)
        $secure_storage = Select-String -Path $dir\scripts\$js_file -SimpleMatch  -Pattern "cordova.plugins.SecureStorage"
        if($secure_storage -ne $null)
        {
            #Write name of directory and JS file where secure storage is initialized
            $dir.Name + " " + $js_file >> D:\Research\IoT_Mobile_Project\iot_companion_appset\securestorage.txt
        }
    }   
    
}