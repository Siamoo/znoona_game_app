# Restart adb server
adb kill-server
adb start-server

# Find a wireless device (IP:port usually starts with 192.* or 10.* on local networks)
$device = adb devices -l | Select-String -Pattern "192\.|10\."

if ($device) {
    $ipPort = ($device.ToString() -split "\s+")[0]
    Write-Host "Found Galaxy A22 at $ipPort"
    adb connect $ipPort
    adb devices
} else {
    Write-Host "No wireless device found. Make sure phone is paired and Wireless debugging is ON."
}
