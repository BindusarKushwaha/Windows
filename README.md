# This script creates a new Hyper-V virtual machine with a random name, configures its resources, and starts it.
# The VM will have 8GB of memory, 8 processors, and a 60GB virtual hard disk.
# It will also have a TPM enabled and be connected to an internal NAT network.
# The script mounts a specified ISO file to the VM's DVD drive for installation.

# Usage:
# 1. Ensure Hyper-V is enabled on your system.
# 2. Update the $isoPath and $vhdPath variables as needed.
# 3. Run the script in a PowerShell session with administrative privileges.
