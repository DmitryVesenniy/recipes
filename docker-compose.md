version: "3.7"

services:
  powergate:
    # network_mode: host # запускаем на сети машины, в этом случае порты пробрасывать не нужно
    ports:
      - 8889:8889
      - 8888:8888
      - 6060:6060
      - 5002:5002
      - 6002:6002
      - 7000:7000
    depends_on:
      - ipfs
      - lotus
    environment:
      - POWD_DEVNET=true
      - POWD_LOTUSHOST=/ip4/0.0.0.0/tcp/7777 #/dns4/lotus/tcp/7777
      - POWD_IPFSAPIADDR=/dns4/ipfs/tcp/5001 # /ip4/0.0.0.0/tcp/5001
    restart: unless-stopped

  ipfs:
    ports:
      - 5001:5001
      - 8080:8080

  lotus:
    image: textile/lotus-devnet:v1.5.2
    ports:
      - 7777:7777
    environment:
      - TEXLOTUSDEVNET_SPEED=300
      - TEXLOTUSDEVNET_BIGSECTORS=${BIGSECTORS}
      - TEXLOTUSDEVNET_IPFSADDR=/dns4/ipfs/tcp/5001
