# OliveTin Installation Script

This script will install OliveTin with the default configuration.  This can be edited by changing the `/etc/OliveTin/config.yaml` file.

## Usage

```sh
sudo ./install.sh "https://github.com/OliveTin/OliveTin/releases/download/2022-04-07/OliveTin-2022-04-07-linux-amd64.tar.gz"
```

## Additional Info

This script assumes that the URL will not change for downloading the latest version but should work if it is adjusted as it renames the file to a static value.

## Managing Service

To manage service use the folowing commands.  Configuration changes will require service restart.

Restart:

```sh
sudo systemctl restart OliveTin
```

Stop:

```sh
sudo systemctl stop OliveTin
```

Start:

```sh
sudo systemctl start OliveTin
```
