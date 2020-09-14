#Search recursively in the specified path to get all directories 
$dirs_all = Get-ChildItem -Path D:\Research\IoT_Mobile_Project\iot_companion_appset\cordova_apps -exclude *.ps1,*.txt,*.html
#For each directory in cordova_apps directory
foreach($dir in $dirs_all)
{
    cd $dir
    
    #Get content of config.xml to extract whitelist parameters
    [xml]$config_xml = Get-Content -Path $dir\res\xml\config.xml
    
    $access_origin = [string]$config_xml.widget.access.origin
    
    $allow_intent = [string]$config_xml.widget.'allow-intent'.href
 
    $allow_navigation = [string]$config_xml.widget.'allow-navigation'.href
    
    #Create object to write to CSV
    $testObject = [pscustomobject]@{'App Name' = $dir.name; 'Access Origin' = $access_origin; 'Allow-Intent' = $allow_intent; 'Allow-Navigation' = $allow_navigation}
    #Write to CSV
    $testObject | Export-Csv -Append -Path D:\Research\IoT_Mobile_Project\iot_companion_appset\cordova_apps\whitelist.csv
    cd ..
}
