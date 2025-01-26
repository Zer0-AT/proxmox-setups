# alpine-dns.sh: Setup Services Script for Alpine Linux

This script automates the installation and configuration of the following services on Alpine Linux:

1. **Technitium DNS Server**
2. **QEMU Guest Agent**
3. **Full Setup** (Installs both Technitium DNS Server and QEMU Guest Agent)

## Features

- Installs required dependencies.
- Configures services for OpenRC.
- Asks whether to start the services after installation.

## Usage

### 1. Download the Script
Save the script as `alpine-dns.sh`.

### 2. Make the Script Executable
```bash
chmod +x setup_services.sh
```

### 3. Run the Script
```bash
./setup_services.sh {technitium|vm-pm|full}
```

#### Options:
- `technitium`: Installs and configures the Technitium DNS Server.
- `vm-pm`: Installs and configures the QEMU Guest Agent.
- `full`: Runs both `technitium` and `vm-pm` setups.

## Service Details

### Technitium DNS Server
- **Dependencies**: Installs `aspnetcore8-runtime`.
- **Configuration**: Downloads the Technitium DNS Server package and sets it up under `/opt/technitium/dns`.
- **Service Management**: Adds a new OpenRC service named `technitium`.

### QEMU Guest Agent
- **Dependencies**: Installs `qemu-guest-agent`.
- **Service Management**: Adds the `qemu-guest-agent` service to OpenRC.

## Example

1. Install and start the Technitium DNS Server:
   ```bash
   ./setup_services.sh technitium
   ```
   You will be prompted:
   ```
   Should the Technitium DNS Server be started? (y/n):
   ```
   Enter `y` to start the service immediately.

2. Install and start the QEMU Guest Agent:
   ```bash
   ./setup_services.sh vm-pm
   ```
   You will be prompted:
   ```
   Should the QEMU Guest Agent be started? (y/n):
   ```
   Enter `y` to start the service immediately.

3. Perform a full installation:
   ```bash
   ./setup_services.sh full
   ```

## Requirements
- Alpine Linux
- Root privileges to install packages and configure services.

# Notes
- Made for proxmox-ve to made my life easier. More infos [Proxmox Virtual Environment](https://www.proxmox.com/en/products/proxmox-virtual-environment/overview).
- Works in VM 
    - `alpine-dns.sh`
- Works in CT
    - `alpine-dns.sh`
- The Technitium DNS Server package is downloaded from the official [Technitium download page](https://technitium.com/dns/).
- Ensure you have internet access during the installation process.
- Als always: Inspect before downloading and verify after downloading :)


# License
This script is released under the MIT License.

