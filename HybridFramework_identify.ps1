#Search recursively in the specified path to get all directories 
$dirs_all = Get-ChildItem -Path D:\Research\IoT_Mobile_Project\iot_companion_appset\cordova_apps -exclude *.ps1 
#intiliaze count variable
$hybrid_apps = 0 
#For each directory in cordova_apps directory
foreach ($dir in $dirs_all)
{
	cd $dir
    $file = $dir.Name + '.txt'
	#recurisvely search all directories and find the specified text file; in this case we have extracted Class-Descriptors from dex files into a text file
	$text_file = Get-ChildItem -Path .\ -Filter $file -File -Name
	#The below line of code looks for all the strings specified after pattern
    $SEL = Select-String -Path $text_file -Pattern '/cordova/','/react/','/reactnative/','/reactjs/','/ionic/','/ionicframework/','/flutter/','/nativescript/','/onsen/' -SimpleMatch	
    #Parse the text file to find 'flutter' keyword
    #$SEL = Select-String -Path $text_file -Pattern 'flutter' -SimpleMatch	
	if($SEL -ne $null)
	{
        
		$hybrid_apps++
        Write-Output $dir.Name
	}
	cd..
}
$hybrid_apps




