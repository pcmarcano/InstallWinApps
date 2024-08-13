<# # Get the list of installed packages
$packages = Get-AppxPackage

# Extract the package names
$packageNames = $packages.Name

# Define the file path where the package names will be saved
$filePath = "$env:USERPROFILE\Documents\InstallWinApps\PackageNames.txt"

# Write the package names to the file
$packageNames | Out-File -FilePath $filePath #>

# ExportPackageNames.ps1

# Define the registry paths to check for installed applications
$registryPaths = @(
    "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*",
    "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*",
    "HKCU:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*"
)

# Initialize an array to hold the package names
$packageNames = @()

# Loop through each registry path and get the DisplayName of installed applications
foreach ($path in $registryPaths) {
    $apps = Get-ItemProperty -Path $path -ErrorAction SilentlyContinue
    foreach ($app in $apps) {
        if ($app.DisplayName) {
            $packageNames += $app.DisplayName
        }
    }
}

# Define the file path where the package names will be saved
$filePath = "$env:USERPROFILE\Documents\InstallWinApps\PackageNames.txt"

# Write the package names to the file
$packageNames | Out-File -FilePath $filePath

Write-Output "Package names have been written to $filePath"
