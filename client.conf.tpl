[Interface]
PrivateKey = ${client_private_key}
Address = ${client_address}/32
DNS = 1.1.1.1

[Peer]
PublicKey = ${server_public_key}
Endpoint = ${server_endpoint}
AllowedIPs = ${client_address}/32
