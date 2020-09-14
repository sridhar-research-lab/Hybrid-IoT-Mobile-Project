#Search recursively in the specified path to get all directories 
$dirs_all = Get-ChildItem -Path D:\Research\IoT_Mobile_Project\IoT_Apks_InitialSet_Classes 

#run dexdump on all dex files in each directory 
foreach ($dir in $dirs_all)
{
	cd $dir
	#recurisvely search all directories and find dex files
	$dex_files = Get-ChildItem -Path .\ -Filter *.dex -Recurse -File -Name
	$filename = $dir.name + ".txt"
	#run dexdump on each dexfile
	foreach ($file in $dex_files)
	{
		dexdump $file | findstr "Class descriptor" >> $filename
	}	
	cd..
}


