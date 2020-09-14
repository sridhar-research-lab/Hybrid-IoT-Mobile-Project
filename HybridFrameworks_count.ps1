#Search recursively in the specified path to get all directories 
$dirs_all = Get-ChildItem -Path D:\Research\IoT_Mobile_Project\IoT_Apks_InitialSet_Classes -exclude *.ps1,*.txt

#run dexdump on all dex files in each directory
$cordova_apps = 0 
$react_apps = 0
$cordova =  'D:\Research\IoT_Mobile_Project\IoT_Apks_InitialSet_Classes\cordova.txt'
$react =  'D:\Research\IoT_Mobile_Project\IoT_Apks_InitialSet_Classes\react.txt'

foreach ($dir in $dirs_all)
{
	cd $dir
	#Get the dexdump text file from the top level directory
	$text_file = Get-ChildItem -Path .\ -Filter *.txt -File -Name
	$SEL_cordova = Select-String -Path $text_file -Pattern '/cordova/' -SimpleMatch	
	$SEL_react = Select-String -Path $text_file -Pattern '/react/','/reactnative/','/reactjs/', -SimpleMatch	

	if($SEL_cordova -ne $null)
	{
		$cordova_apps++
		$dir.name >> $cordova
	}
	elseif($SEL_react -ne $null)
	{
		$react_apps++
		$dir.name >> $react
	}
	cd..
}
$cordova_apps
$react_apps

