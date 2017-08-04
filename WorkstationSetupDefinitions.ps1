




Write-Host ---------------------------------------------------------------------------
Write-Host --------------------------- Definition ------------- Loading --------------
Write-Host ---------------------------------------------------------------------------


function Get_The_Machine_Ready()
{
    #install Chocolatey
    #iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))

    #ensure that the top level directories for apps and configs are on disk
    cd c:\

    $directoriesToCreate = "dev-apps", "dev-scripts", "dev-source", "dev-demos", "dev-temp"
    $directoriesToCreate | % { Write-Host "Creating $_"}
    $directoriesToCreate | % { New-Item -ItemType Directory -Name $_ -ErrorAction Continue }
    


}


function Git_Install_and_Setup
{
    Write-Host "Installing Git"
    choco -y install git

    Write-host "Configuring Git"
    git config --global user.name "Frison Alexander"
    git config --global user.email "fri.b.alex@gmail.com"

    #TODO: grab ssh key from github account
    #      github for windows looks like a better way

}



function Vim_and_Plugins_Install{

    cd c:\dev-apps
    mkdir Vim
    cd Vim

    git clone https://github.com/frialex/vim_custom.git


    #Fetch Neovim AND vim cream .. sometimes neovim acts strange on a networked file

}



#install Visual studio, plugins, and fonts (Fira Code)



function AutoHotkey_and_Scripts_Install
{
    #TODO: Need a solid link to ahkscript to get autohotkey executable

    cd c:\dev-apps
    mkdir keyboard
    cd keyboard

    $ahkScriptRoot = "$pwd/ahk/ModeBasedInput"
    write-host "cloning ahk config into $pwd"
    git clone https://github.com/frialex/ahk.git
   

    $outputzipFilePath = "$pwd/ahk.zip"
    write-host "Download ahk.zip into $outputzipFilePath"
    Invoke-WebRequest "https://autohotkey.com/download/ahk.zip" -OutFile ahk.zip

    $zipExtractionPath = "$pwd/vendor"
    write-host "Extracting ahk.zip into $zipExtractionPath"
    Add-Type -AssemblyName "System.IO.Compression.FileSystem"
    [IO.Compression.ZipFile]::ExtractToDirectory($outputzipFilePath, $zipExtractionPath)


    $ahkDotExe = "$zipExtractionPath/AutoHotkeyU64.exe"
    $script    = "$ahkScriptRoot/main.ahk"
    write-host "Running ahk with custom script (With &)"

    #have to cd in to dir with scripts so ahk can find the scripts dependencies
    cd $ahkScriptRoot

    & $ahkDotExe $script

}


function Powershell_setup
{
    #create a profile

    #bring down custom modules

    #install powershell community extensions
    
}



function Change_Capital_To_ControlKey
{
    #:)
    #https://superuser.com/a/997448/148077

    Write-Host "Changing Capital Key to Control"

    $hexified = "00,00,00,00,00,00,00,00,02,00,00,00,1d,00,3a,00,00,00,00,00".Split(',') | % { "0x$_"};

    $kbLayout = 'HKLM:\System\CurrentControlSet\Control\Keyboard Layout';

    New-ItemProperty -Path $kbLayout -Name "Scancode Map" -PropertyType Binary -Value ([byte[]]$hexified);
}



