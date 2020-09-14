#Search recursively in the specified path to get all directories 
$dirs_all = Get-ChildItem -Path D:\Research\IoT_Mobile_Project\iot_companion_appset\cordova_apps -exclude *.ps1,*.txt,*.html
#For each directory in cordova_apps directory
foreach($dir in $dirs_all)
{
	$SEL = $null
    #Get all html files of an app. HTML files have been consolidated in a single folder for each app
	$html_files = Get-ChildItem -Path $dir\assets -Filter *.html -Recurse -File -Name
	foreach($html_file in $html_files)
	{
		$SEL = Select-String -Path $dir\assets\$html_file -Pattern "Content-Security-Policy" 
		if($SEL -ne $null)
			{
				$dir.name + '\assets\' + $html_file >> 'csp.txt'				
			}
		$SEL = $null
	}	
}

