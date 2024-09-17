Clear-Host
# Get current windows product key
# powershell "(Get-WmiObject -query 'select * from SoftwareLicensingService').OA3xOriginalProductKey"

# Get current windows version
#Get-ComputerInfo | Select-Object WindowsVersion, WindowsBuildLabEx
#[System.Environment]::OSVersion.Version
# Get the OS version information
$osVersion = [System.Environment]::OSVersion.Version

# Extract the major version number
$majorVersion = $osVersion.Major
# Extract the build number
$buildVersion = $osVersion.Build

# Output the major version number (optional)
Write-Host "Windows $majorVersion Build $buildVersion"


# MARK: PreCheck

# Check if winget is installed
function checkWinget {
    if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
        Write-Output "winget is not installed on this system."
        Write-Output "Please install winget and try again."
        return $false
    }
    return $true
}

function checkWindowsUpdate {

    $moduleName = "PSWindowsUpdate"
    $moduleInstalled = Get-InstalledModule -Name $moduleName -ErrorAction SilentlyContinue

    if ($moduleInstalled) {
        $result = $true
        <# Write-Output "PSWindowsUpdate is installed." #>
    }
    else {
        $result = $false
        <# Write-Output "PSWindowsUpdate is not installed." #>
    }

    # Return the result
    return $result
}

# Check if the computer is conected to the internet
function CheckInternetOne {
    # Using Test-Connection to check internet connectivity
    $test = Test-Connection -ComputerName www.google.com -Count 1 -Quiet

    if ($test) {
        return $true
    }
    else {
        return $false
    }
}


function CheckInternetTwo {

    # Using Invoke-WebRequest to check internet connectivity
    try {
        $response = Invoke-WebRequest -Uri http://www.google.com -UseBasicParsing -TimeoutSec 5
        if ($response.StatusCode -eq 200) {
            Write-Host "Connected to the Internet."
            return $true
        }
    }
    catch {
        Write-Host "Not connected to the Internet."
        return $false
    }
}


function installWUM {
<#     param (
        OptionalParameters
    ) #>
    Install-Module -Name PSWindowsUpdate -Force -AllowClobber

}

# 
# ----------------------------------------------------------
# MARK: Main Menu

function menu {
    <#     param (
        OptionalParameters
    ) #>

    # Prompt the user for input
    Write-Host "Please choose an option (1, 2, or 3):"
    Write-Host "0. Update"
    Write-Host "1. Remove"
    Write-Host "2. Install"
    Write-Host "3. Other"
    $choice = Read-Host "Enter your choice"

    <# return $choice #>
    # Process the input
    switch ($choice) {
        "0" {
            <# Write-Host "Uninstall" #>
            menuWinUpdate
        }
        "1" {
            <# Write-Host "Uninstall" #>
            menuRemove
        }
        "2" {
            <# Write-Host "Install." #>
            menuInstall
        }
        "3" {
            <# Write-Host "You chose: patushc" #>
            menuOther
        }
        default {
            Write-Host "Invalid choice. Please enter a number between 1 and 3."
        }
    }

}

# 
# ----------------------------------------------------------
# MARK: Menu Windows Update

function menuWinUpdate {
    Clear-Host
    Write-Host "Windows Update"
    Write-Host "Please choose an option (1, 2, or 3) r: return"
    Write-Host "1. Verify PSWindowsUpdate"
    Write-Host "2. Check for Updates"
    Write-Host "3. Install Updates"
    Write-Host "4. List Installed Updates"
    $choice = Read-Host "Enter your choice"
    switch ($choice) {
        "1" {
            Get-InstalledModule -Name PSWindowsUpdate
            <# menuWinUpdate #>
        }
        "2" {
            Get-WindowsUpdate
            <# menuWinUpdate #>
        }
        "3" {
            Install-WindowsUpdate -AcceptAll -AutoReboot
            <# menuWinUpdate #>
        }
        "4" {
            Get-WindowsUpdate -Install
            <# menuWinUpdate #>
        }
        
        "r" {
            Write-Host "Return"
            Clear-Host
            menu
        }
        default {
            Write-Host "Invalid choice."
            menuWinUpdate
        }
    }
}

# 
# ----------------------------------------------------------
# MARK: Menu Remove
function menuRemove {
    <# param (
        OptionalParameters
    ) #>
    Clear-Host
    Write-Host "Remove"
    Write-Host "Please choose an option (1, 2, or 3) r: return"
    $choice = Read-Host "Enter your choice"
    switch ($choice) {
        "1" {
            Write-Host "Option 1"
            
        }
        "2" {
            Write-Host "Option 2"
            
        }
        "3" {
            Write-Host "Option 3"
            
        }
        "x" {
            Write-Host "Return"
            Clear-Host
            menu
        }
        default {
            Write-Host "Invalid choice."
            menuUninstall
        }
    }
}

function menuInstall {
    <# param (
        OptionalParameters
    ) #>
    Clear-Host
    Write-Host "Install"
    Write-Host "Please choose an option (1, 2, or 3) r: return"
    $choice = Read-Host "Enter your choice"
    switch ($choice) {
        "1" {
            Write-Host "Option 1"
            
        }
        "2" {
            Write-Host "Option 2"
            
        }
        "3" {
            Write-Host "Option 3"
            
        }
        "x" {
            Write-Host "Return"
            Clear-Host
            menu
        }
        default {
            Write-Host "Invalid choice."
            menuInstall
        }
    }
}

function menuOther {
    <# param (
        OptionalParameters
    ) #>
    Clear-Host

    Write-Host "Please choose an option (1, 2, or 3) r: return"
    $choice = Read-Host "Enter your choice"
    switch ($choice) {
        "1" {
            Write-Host "Disable the search bar"
            disableSearchBar 
        }
        "2" {
            Write-Host "Disable News and Interests widget"
            disableNI
        }
        "3" {
            Write-Host "Disable the list of applications"
            disableAL
        }
        "4" {
            Write-Host "Disable the list of applications"
            disableAL
        }
        "5" {
            Write-Host "Disable the list of applications"
            disableAL
        }
        "6" {
            Write-Host "Disable the list of applications"
            disableAL
        }
        "" {
            Write-Host "Disable the list of applications"
            disableAL
        }
        "8" {
            Write-Host "Disable the list of applications"
            disableAL
        }
        "9" {
            Write-Host "Disable the list of applications"
            disableAL
        }
        "0" {
            Write-Host "Disable the list of applications"
            disableAL
        }
        "r" {
            Write-Host "Return"
            Clear-Host
            menu
        }
        default {
            Write-Host "Invalid choice."
            menuOther
        }
    }
    
}

# 
# ----------------------------------------------------------
# MARK: create list of installed apps



# 
# ----------------------------------------------------------
# MARK: Other

# MARK: Disable the search bar via PowerShell
function disableSearchBar {
    <# param (
        OptionalParameters
    ) #>
    # Registry path
    $registryPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search"

    # Check if the registry path exists
    if (-not (Test-Path $registryPath)) {
        # Create the registry path if it doesn't exist
        New-Item -Path $registryPath -Force
    }

    # Set the SearchboxTaskbarMode value to 0 (Hide search bar)
    Set-ItemProperty -Path $registryPath -Name "SearchboxTaskbarMode" -Value 0

    Write-Output "Search bar has been hidden. You may need to restart your computer or Explorer for changes to take effect."

    # Or try this other methord
    # Set the registry key to hide the search box
    #Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" -Name "SearchboxTaskbarMode" -Value 0

    # Restart the Explorer process to apply the change
    #Stop-Process -Name explorer -Force
    #Start-Process explorer




}




# MARK: # Disable News and Interests widget via PowerShell
function disableNI {
    <#     param (
        OptionalParameters
    ) #>
    # Registry path
    $registryPath = "HKCU:\Software\Policies\Microsoft\Windows\Explorer"

    # Check if the registry path exists
    if (-not (Test-Path $registryPath)) {
        # Create the registry path if it doesn't exist
        New-Item -Path $registryPath -Force
    }

    # Set the DisableNewsAndInterests value to 1 (Disable widget)
    Set-ItemProperty -Path $registryPath -Name "DisableNewsAndInterests" -Value 1

    Write-Output "News and interests widget has been disabled. You may need to restart your computer or Explorer for changes to take effect."
}

# MARK: # Disable News and Interests widget via PowerShell
function disableAL {
    <#     param (
        OptionalParameters
    ) #>
    # Define registry path
    $registryPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"

    # Disable the list of applications in Start menu
    # 1 = Disable; 0 = Enable
    Set-ItemProperty -Path $registryPath -Name "Start_UseLiveTiles" -Value 0

    # Disable recently added apps
    # Set-ItemProperty -Path $registryPath -Name "Start_ShowRecentlyAddedApps" -Value 0

    # Disable recently opened items in Jump Lists
    # Set-ItemProperty -Path $registryPath -Name "Start_ShowRecentJumpListItems" -Value 0

    Write-Output "Start menu settings have been updated. You may need to restart Explorer or your computer for changes to take effect."

}







# MARK: # RUN

$winGet = checkWinget
$windowsUpdate = checkWindowsUpdate
if ($winGet) {
    Write-Host "WinGet is installed"

    if ($windowsUpdate) {
        Write-Output "PSWindowsUpdate is installed."
    } else {
        Write-Output "PSWindowsUpdate is not installed."
        installWUM
    }

    $isConnected = CheckInternetOne
    if ([System.Boolean]$isConnected) {
        Write-Host "Connected to the Internet."
        menu
    }
    else {
        Write-Host "Not Connected to the Internet."
        Write-Host "Trying another methord"
        $isConnected = CheckInternetTwo
        if ([System.Boolean]$isConnected) {
            Write-Host "Connected to the Internet."
            menu
        }
        else {
            Write-Host "Not Connected to the Internet."
        }
    }
}
<# 

# Function to check if an application is installed
function Is-AppInstalled {
    param (
        [string]$appName
    )

    # Query installed applications
    $installedApps = Get-WmiObject -Query "SELECT * FROM Win32_Product WHERE Name LIKE '%$appName%'"

    # Check if the application is found
    if ($installedApps) {
        Write-Output "$appName is installed."
    } else {
        Write-Output "$appName is not installed."
    }
}

# Example usage
Is-AppInstalled -appName "Google Chrome" #>






<# # Prompt user for application name
$appName = Read-Host "Enter the name of the application to install"

# Install the application using winget
try {
    winget install --name "$appName" --silent
    Write-Output "Installation of $appName has completed."
}
catch {
    Write-Output "An error occurred while trying to install $appName. Please check the application name and try again."
}
 #>







<# $myArray = @("item1", "item2", "item3")
$myArray | Export-Clixml -Path "C:\path\to\savedArray.xml"

$myArray = @("item1", "item2", "item3")

if ($myArray[1] -eq "item2") {
    $myArray | Export-Clixml -Path "C:\path\to\savedArray.xml"
    Write-Host "Array saved because second item is 'item2'"
} else {
    Write-Host "Array not saved. Second item is not 'item2'"
} #>
