# Emotet infection check tool.
#

Write-Host "`r`n#### This is Emotet Infection Check tool 'EmoHori v0.1' ####`r`n"


$RunKey=(Get-Item -Path "Registry::HKCU\Software\Microsoft\Windows\CurrentVersion\Run");
$RunKey.GetValueNames() | ForEach-Object{

	$RegData=$RunKey.GetValue($_);
	Write-Host "Check -> " $RegData;

	# Check exist and contain %LocalAppdata%
	if((Test-Path $RegData) -and ($RegData.IndexOf($env:LocalAppdata) -ge 0) ){

		#Get behind ApppData
		$DataPath=$RegData.Substring($RegData.IndexOf($env:LocalAppdata)+$env:LocalAppdata.Length+1, $RegData.length-$RegData.IndexOf($env:LocalAppdata)-$env:LocalAppdata.Length-1);
		#Check folder and filename include system32 folder
		if( ((Get-ChildItem  -File -Path C:\Windows\system32\ -Filter ((Split-Path $DataPath -Parent)+"*") -Name) -gt 0) -and ((Get-ChildItem  -File -Path C:\Windows\system32\ -Filter ([System.IO.Path]::GetFileNameWithoutExtension($RegData)+"*") -Name ) -gt 0) ) {
			Write-Host "This RegistryKey is Emotet !`r`n" 
		} else { 
			Write-Host "Not Emotet`r`n"
		}
	} else {
		Write-Host "Not Emotet`r`n"
	}
};