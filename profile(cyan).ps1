Clear-Host
$esc = "`e"


$sh = @(
    "$esc[38;2;0;255;255m",  
    "$esc[38;2;0;255;255m",  
    "$esc[38;2;0;255;255m",  
    "$esc[38;2;0;255;255m",  
    "$esc[38;2;0;255;255m",   
    "$esc[38;2;0;255;255m"    
)

# System Intel
$os = "Microsoft Windows 11"   
$user = $env:USERNAME
$cpu = (Get-CimInstance Win32_Processor).Name.Split('@').Trim()
$ram = "$([math]::Round((Get-CimInstance Win32_ComputerSystem).TotalPhysicalMemory / 1GB, 0)) GB"
$uptime = (Get-Date) - (Get-CimInstance Win32_OperatingSystem).LastBootUpTime
$uptimeStr = "{0}d {1}h {2}m" -f $uptime.Days, $uptime.Hours, $uptime.Minutes

# ASCII Art
$logo = @(
' /$$   /$$ /$$     /$$ /$$$$$$$  /$$$$$$$$ /$$$$$$$ ',
'| $$  | $$|  $$   /$$/| $$__  $$| $$_____/| $$__  $$',
'| $$  | $$ \  $$ /$$/ | $$  \ $$| $$      | $$  \ $$',
'| $$$$$$$$  \  $$$$/  | $$$$$$$/| $$$$$   | $$$$$$$/',
'| $$__  $$   \  $$/   | $$____/ | $$__/   | $$__  $$',
'| $$  | $$    | $$    | $$      | $$      | $$  \ $$',
'| $$  | $$    | $$    | $$      | $$$$$$$$| $$  | $$',
'|__/  |__/    |__/    |__/      |________/|__/  |__/'
'ABHIJEETH V N'
)


$acc = "$esc[38;2;0;255;255m"
$info = @(
    "$esc[1;37m$user$esc[0m@$esc[1;37m$($env:COMPUTERNAME)$esc[0m", 
    "${acc}-------------------------$esc[0m",
    "${acc}OS:      $esc[0m$os",
    "${acc}CPU:     $esc[0m$cpu",
    "${acc}RAM:     $esc[0m$ram",
    "${acc}UPTIME:  $esc[0m$uptimeStr"
)

$termWidth = $Host.UI.RawUI.WindowSize.Width

Write-Host ""
if ($termWidth -gt 85) {
    for ($i=0; $i -lt $logo.Length; $i++) {
        $color = $sh[$i % $sh.Length]
        $lineInfo = if ($i -lt $info.Length) { $info[$i] } else { "" }
        Write-Host "  $color$($logo[$i].PadRight(55)) $lineInfo$esc[0m"
    }
} else {
    for ($i=0; $i -lt $logo.Length; $i++) {
        Write-Host "  $($sh[$i % $sh.Length])$($logo[$i])$esc[0m"
    }
    Write-Host ""
    foreach ($line in $info) { Write-Host "  $line" }
}

if (Get-Module -Name PSReadLine) {
    $customColors = @{
        "Command"   = "$esc[38;2;0;255;255m"   # Neon Cyan
        "Parameter" = "$esc[38;2;150;150;150m" # Clean, low-contrast slate gray for flags
        "String"    = "$esc[38;2;120;120;120m" # Darker gray for strings
        "Variable"  = "$esc[38;2;0;255;255m"   # Neon Cyan for variables
        "Number"    = "$esc[38;2;255;255;255m" # White for numbers
        "Member"    = "$esc[38;2;255;255;255m" # White for members
    }
    Set-PSReadLineOption -Color $customColors
    Set-PSReadLineOption -Colors @{ InlinePrediction = "$esc[38;5;237m" } 
}
# -------------------------------------------------------------

function LEET { & "c:/workflow/custom/scripts/abc.ps1" }
function RY { & $profile }
oh-my-posh init pwsh --config "C:\Users\xrp1q\amro.omp.json" | Invoke-Expression

function laz {
    $env:NVIM_APPNAME="nvim-lazy"
    nvim
    Remove-Item Env:NVIM_APPNAME -ErrorAction SilentlyContinue
}
