#!/bin/bash
# Configure a misconfigured DNS zone
sudo tee /etc/bind/named.conf.local <<EOF
zone "vulnerable.local" {
    type master;
    file "/etc/bind/zones/vulnerable.local.db";
    allow-transfer { any; }; # Misconfiguration: allows zone transfer to anyone
};
EOF

# Create the zone file
sudo mkdir -p /etc/bind/zones
sudo tee /etc/bind/zones/vulnerable.local.db <<EOF
\$TTL    604800
@       IN      SOA     ns.vulnerable.local. admin.vulnerable.local. (
                              2         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@       IN      NS      ns.vulnerable.local.
ns      IN      A       192.168.1.100
www     IN      A       192.168.1.101
mail    IN      A       192.168.1.102
EOF

# Update named.conf.options for basic operation
sudo tee /etc/bind/named.conf.options <<EOF
options {
    directory "/var/cache/bind";
    recursion yes;
    allow-query { any; }; # Allow queries from any source
    forwarders {
        8.8.8.8; 8.8.4.4;
    };
    dnssec-validation no;
};
EOF

# Restart the DNS service to apply changes
sudo systemctl restart bind9
echo "DNS server configured with a vulnerable zone."
