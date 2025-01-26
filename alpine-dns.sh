#!/bin/sh

# Technitium DNS Server install and configure
setup_technitium() {
    echo "Installing Technitium DNS Server..."
    apk add aspnetcore8-runtime
    wget https://download.technitium.com/dns/DnsServerPortable.tar.gz
    mkdir -p /opt/technitium/dns
    tar -zxf DnsServerPortable.tar.gz -C /opt/technitium/dns

    # Service configuration
    cat <<'EOF' >/etc/init.d/technitium
#!/sbin/openrc-run

name=$RC_SVCNAME
description="Technitium DNS Server"
supervisor="supervise-daemon"
command="/usr/bin/dotnet"
command_args="/opt/technitium/dns/DnsServerApp.dll /etc/dns"
supervise_daemon_args="-d /opt/technitium/dns"
EOF

    chmod +x /etc/init.d/technitium
    rc-update add technitium default

    # Service start
    read -p "Would you like to start the Technitium DNS Server now? (y/n): " start_service
    if [ "$start_service" = "y" ]; then
        rc-service technitium start
    fi
}

# QEMU Guest Agent install and configure
setup_vm_pm() {
    echo "Installing QEMU Guest Agent..."
    apk add qemu-guest-agent
    rc-update add qemu-guest-agent default

    # Service start
    read -p "Would you like to start the QEMU Guest Agent now? (y/n): " start_service
    if [ "$start_service" = "y" ]; then
        rc-service qemu-guest-agent start
    fi
}

# Full (VM-PM + Technitium)
setup_full() {
    setup_vm_pm
    setup_technitium
}

# Main menu
case "$1" in
technitium)
    setup_technitium
    ;;
vm-pm)
    setup_vm_pm
    ;;
full)
    setup_full
    ;;
*)
    echo "Usage: $0 {technitium|vm-pm|full}"
    exit 1
    ;;
esac

exit 0
