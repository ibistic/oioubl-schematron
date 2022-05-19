$version = Get-Content .\version.json -Raw | ConvertFrom-Json | Select-Object -ExpandProperty PackageVersion
Write-Host ("Nuget package version: $version")
Write-Output "NUGET_PACKAGE_VERSION=$version" | Out-File -FilePath $Env:GITHUB_ENV -Encoding utf-8 -Append

