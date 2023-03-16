$ErrorActionPreference = "Stop"

$publish = "LoadAssemblyBug/bin/Release/net7.0/win-x64/publish"

foreach ($sdk in @("7.0.201", "7.0.202")) {
    Write-Host "Using $sdk"

    Set-Content -Path "global.json" -Value @"
{
    "sdk": {
        "version": "$sdk",
        "allowPrerelease": false,
        "rollForward": "disable"
    }
}
"@

    if (Test-Path -Path $publish) {
        Remove-Item -Path $publish -Recurse -Force 
    }

    dotnet publish LoadAssemblyBug -c Release --self-contained -v:q

    try {
	    Push-Location -Path $publish
	    ./LoadAssemblyBug.exe
    } finally {
	    Pop-Location
    }
}
