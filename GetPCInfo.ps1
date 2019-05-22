# Get Remote System Information

# Shows hardware and OS details from a list of PC

# Last Edit :Peter Cheung 15 March 2019

$ArrComputers =  get-content "C:\scripts\computers.txt"


foreach ($Computer in $ArrComputers) 
{
    $computerSystem = get-wmiobject Win32_ComputerSystem -Computer $Computer
    $computerBIOS = get-wmiobject Win32_BIOS -Computer $Computer
    $computerOS = get-wmiobject Win32_OperatingSystem -Computer $Computer
    $computerCPU = get-wmiobject Win32_Processor -Computer $Computer
    $computerHDD = Get-WmiObject Win32_LogicalDisk -ComputerName $Computer -Filter drivetype=3
        write-host "System Information for: " $computerSystem.Name -BackgroundColor DarkCyan
        "-------------------------------------------------------"
        "Manufacturer: " + $computerSystem.Manufacturer
        "Model: " + $computerSystem.Model
        "Serial Number: " + $computerBIOS.SerialNumber
        "CPU: " + $computerCPU.Name
"HDD Capacity C: " + "{0:N2}" -f ($computerHDD.Size[0]/1GB) + "GB" 
"HDD Capacity D: " + "{0:N2}" -f ($computerHDD.Size[1]/1GB) + "GB" 
"HDD Space C: " + "{0:P2}" -f ($computerHDD.FreeSpace[0]/$computerHDD.Size[0]) + " Free (" + "{0:N2}" -f ($computerHDD.FreeSpace[0]/1GB) + "GB)"
"HDD Space D: " + "{0:P2}" -f ($computerHDD.FreeSpace[1]/$computerHDD.Size[1]) + " Free (" + "{0:N2}" -f ($computerHDD.FreeSpace[1]/1GB) + "GB)"
        "RAM: " + "{0:N2}" -f ($computerSystem.TotalPhysicalMemory/1GB) + "GB"
        "Operating System: " + $computerOS.caption + ", Service Pack: " + $computerOS.ServicePackMajorVersion
        "User logged In: " + $computerSystem.UserName
        "Last Reboot: " + $computerOS.ConvertToDateTime($computerOS.LastBootUpTime)
        ""
        "-------------------------------------------------------"
}
