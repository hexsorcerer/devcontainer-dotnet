$files = @{
    "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf" = "$($env:USERPROFILE)\AppData\Local\Microsoft\Windows\Fonts\MesloLGS NF Regular.ttf";
    "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf" = "$($env:USERPROFILE)\AppData\Local\Microsoft\Windows\Fonts\MesloLGS NF Bold.ttf";
    "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf" = "$($env:USERPROFILE)\AppData\Local\Microsoft\Windows\Fonts\MesloLGS NF Italic.ttf";
    "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf" = "$($env:USERPROFILE)\AppData\Local\Microsoft\Windows\Fonts\MesloLGS NF Bold Italic.ttf";
}

$registryPath = "HKCU:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts"

foreach ($file in $files.GetEnumerator()) {
    if (-not (Test-Path -Path $file.Value -PathType Leaf)) {
        try {
            Invoke-WebRequest -Uri $file.Key -OutFile $file.Value
            Write-Host "The file [$($file.Value)] has been created."
        }
        catch {
            throw $_.Exception.Message
        }
    }
    else {
        Write-Host "The file [$($file.Value)] is already available."
    }

    if (-not (Test-Path $registryPath)) {
        try {
            New-Item -Path $registryPath -Force | Out-Null
        }
        catch {
            throw $_.Exception.Message
        }
    }

    try {
        $filename = Get-ChildItem $file.Value
        New-ItemProperty -Path $registryPath -Name "$($filename.BaseName) (TrueType)" -Value $file.Value -PropertyType String -Force
        Write-Host "[$($file.Value)] was added to the registry."
    }
    catch {
        throw $_.Exception.Message
    }
}
