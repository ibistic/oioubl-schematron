$version = Get-Content .\version.json -Raw | ConvertFrom-Json | Select-Object -ExpandProperty PackageVersion
Write-Host ("Nuget package version: $version")
Write-Host ("##vso[task.setvariable variable=PackageVersion;]$version")

