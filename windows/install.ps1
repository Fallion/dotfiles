# Check to see if we are currently running "as Administrator"
if (!(Verify-Elevated)) {
    $newProcess = new-object System.Diagnostics.ProcessStartInfo "PowerShell";
    $newProcess.Arguments = $myInvocation.MyCommand.Definition;
    $newProcess.Verb = "runas";
    [System.Diagnostics.Process]::Start($newProcess);
 
    exit
 }
 
 
 ### Update Help for Modules
 Write-Host "Updating Help..." -ForegroundColor "Yellow"
 Update-Help -Force
 
 
 ### Package Providers
 Write-Host "Installing Package Providers..." -ForegroundColor "Yellow"
 Get-PackageProvider NuGet -Force | Out-Null
 # Chocolatey Provider is not ready yet. Use normal Chocolatey
 Get-PackageProvider Chocolatey -Force
 Set-PackageSource -Name chocolatey -Trusted
 
 
 ### Install PowerShell Modules
#  Write-Host "Installing PowerShell Modules..." -ForegroundColor "Yellow"
#  Install-Module Posh-Git -Scope CurrentUser -Force
#  Install-Module PSWindowsUpdate -Scope CurrentUser -Force 

# $ChocoInstalled = $false
# if (Get-Command choco.exe -ErrorAction SilentlyContinue) {
#     $ChocoInstalled = $true
# }


### Chocolatey
Write-Host "Installing Desktop Utilities..." -ForegroundColor "Yellow"
if (!$ChocoInstalled) {
    iex (new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1')
    Refresh-Environment
    choco feature enable -n=allowGlobalConfirmation
}

# system and cli
choco install curl                --limit-output
choco install git.install         --limit-output -params '"/GitAndUnixToolsOnPath /NoShellIntegration"'
choco install nvm.portable        --limit-output
choco install golang              --limit-output
choco install dart-sdk            --limit-output

# browser
choco install brave  --limit-output

# devs tools
choco install vscode --limit-output
choco install 1password --limit-output
choco install yarn --limit-output
choco install kubernetes-cli --limit-output
choco install slack --limit-output
choco install keybase --limit-output

# misc
choco install steam --limit-output
choco install spotify --limit-output

Refresh-Environment

# nvm set up 
nvm on
$nodeLtsVersion = choco search nodejs-lts --limit-output | ConvertFrom-String -TemplateContent "{Name:package-name}\|{Version:1.11.1}" | Select -ExpandProperty "Version"
nvm install $nodeLtsVersion
nvm use $nodeLtsVersion
Remove-Variable nodeLtsVersion