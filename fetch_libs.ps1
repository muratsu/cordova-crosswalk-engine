$ARM_DOWNLOAD="https://download.01.org/crosswalk/releases/crosswalk/android/stable/10.39.235.15/arm/crosswalk-webview-10.39.235.15-arm.zip";
$X86_DOWNLOAD ="https://download.01.org/crosswalk/releases/crosswalk/android/stable/10.39.235.15/x86/crosswalk-webview-10.39.235.15-x86.zip";

Function Download ($file)
{
    Write-Host("Fetching $file...");
    ((new-object net.webclient).DownloadFile($file, "library.zip"));
    $helper = New-Object -ComObject Shell.Application;
    $files = $helper.NameSpace((Get-Item -Path ".\" -Verbose).FullName + "\library.zip").Items();
    $path = (Get-Item -Path ".\" -Verbose).FullName + "\libs\xwalk_core_library\";
    Write-Host("Installing $file into xwalk_core_library...");
    $helper.NameSpace($path).CopyHere($files, 0x14);
    Remove-Item("library.zip");
}

Download($X86_DOWNLOAD);
Download($ARM_DOWNLOAD);
