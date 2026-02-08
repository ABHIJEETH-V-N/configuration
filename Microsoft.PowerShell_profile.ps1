Clear-Host
$esc = "`e"

# Crimson Red Gradient (From Bright Scarlet to Deep Wine)
$sh = @(
    "$esc[38;2;220;20;60m",   # Bright Scarlet (Top - Visibility)
    "$esc[38;2;220;20;60m",   # Crimson
    "$esc[38;2;220;20;60m",     # Standard Red
    "$esc[38;2;220;20;60m",     # Blood Red
    "$esc[38;2;220;20;60m",     # Dark Maroon
    "$esc[38;2;220;20;60m"       # Deep Wine (Bottom)
)

# System Intel
$os = (Get-CimInstance Win32_OperatingSystem).Caption
$user = $env:USERNAME
$cpu = (Get-CimInstance Win32_Processor).Name.Split('@')[0].Trim()
$ram = "$([math]::Round((Get-CimInstance Win32_ComputerSystem).TotalPhysicalMemory / 1GB, 0)) GB"
$uptime = (Get-Date) - (Get-CimInstance Win32_OperatingSystem).LastBootUpTime
$uptimeStr = "{0}d {1}h {2}m" -f $uptime.Days, $uptime.Hours, $uptime.Minutes


# ASCII Art - Single Quotes to protect $ signs
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

# Information Labels - Crimson Accent
$acc = "$esc[38;2;220;20;60m"
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
        # PadRight(55) keeps the columns locked
        Write-Host "  $color$($logo[$i].PadRight(55)) $lineInfo$esc[0m"
    }
} else {
    for ($i=0; $i -lt $logo.Length; $i++) {
        Write-Host "  $($sh[$i % $sh.Length])$($logo[$i])$esc[0m"
    }
    Write-Host ""
    foreach ($line in $info) { Write-Host "  $line" }
}

function LEET { & "c:/workflow/custom/scripts/abc.ps1" }
function RY {& $profile}
oh-my-posh init pwsh --config "C:\Users\xrp1q\amro.omp.json" | Invoke-Expression
