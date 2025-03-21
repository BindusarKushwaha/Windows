# This script creates a new Hyper-V virtual machine with a random name, configures its resources, and starts it.
# The VM will have 8GB of memory, 8 processors, and a 60GB virtual hard disk.
# It will also have a TPM enabled and be connected to an internal NAT network.
# The script mounts a specified ISO file to the VM's DVD drive for installation.

# Usage:
# 1. Ensure Hyper-V is enabled on your system.
# 2. Update the $isoPath and $vhdPath variables as needed.
# 3. Run the script in a PowerShell session with administrative privileges.


﻿# Define VM parameters
# Function to generate a random VM name

function Get-RandomVMName {
    $adjectives = @("Quick", "Bright", "Silent", "Brave", "Clever", "Swift", "Mighty", "Noble", "Bold", "Wise")
    $nouns = @("Eagle", "Lion", "Tiger", "Falcon", "Wolf", "Bear", "Hawk", "Panther", "Dragon", "Phoenix")
    $randomAdjective = Get-Random -InputObject $adjectives
    $randomNoun = Get-Random -InputObject $nouns
    return "W11$randomAdjective$randomNoun"
}

$vmName = Get-RandomVMName
$vmMemory = 8GB
$vmProcessorCount = 8
$isoPath = "C:\Hyper-V\Win11_24H2_English_x64.iso"
$vhdPath = "C:\Hyper-V\$vmName.vhdx"
$virtualNetwork = "InternalNAT"

# Create a new VM
New-VM -Name $vmName -MemoryStartupBytes $vmMemory -Generation 2 -NewVHDPath $vhdPath -NewVHDSizeBytes 60GB

# Set the number of processors
Set-VMProcessor -VMName $vmName -Count $vmProcessorCount

# Configure a key protector for the VM
Set-VMKeyProtector -VMName $vmName -NewLocalKeyProtector

# Enable TPM
Enable-VMTPM -VMName $vmName

# Add DVD drive and mount ISO
Add-VMDvdDrive -VMName $vmName -Path $isoPath

# Connect the VM to the specified virtual network
Add-VMNetworkAdapter -VMName $vmName -SwitchName $virtualNetwork

# Start the VM
Start-VM -Name $vmName