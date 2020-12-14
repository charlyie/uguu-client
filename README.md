# Uguu-client

[![GitHub license](https://img.shields.io/github/license/charlyie/uguu-client.svg)](https://github.com/charlyie/uguu-client/blob/master/LICENSE) [![GitHub release](https://img.shields.io/github/v/tag/charlyie/uguu-client.svg)](https://GitHub.com/charlyie/uguu-client/releases/) [![GitHub issues](https://img.shields.io/github/issues/charlyie/uguu-client.svg)](https://GitHub.com/charlyie/uguu-client/issues/)

Uguu-compatible command line bash client
This client is able to send local files fo [Uguu](https://github.com/nokonoko/Uguu) compatible client like [this fork](https://github.com/charlyie/Uguu).

![Uguu Bash Client](https://i.ibb.co/HzKm41p/cli-screenshot.jpg)

Uguu is a simple lightweight temporary file uploading and sharing platform where files get deleted after X amount of time.

## Features

- Easy server file uploading, no registration required
- Custom Endpoint Management


## Requirements

Requires packages `curl` and `jq` installed on the Operating System.

## Install

### Quick method (for Debian/Ubuntu)

```bash
$ apt-get install jq curl -y -q;wget -q https://raw.githubusercontent.com/charlyie/uguu-client/main/ushare.sh -O /usr/sbin/ushare;chmod +x /usr/sbin/ushare;ushare -v
```



### Git method

First you must get a copy of the uguu-clent code.  To do so, clone this git repo.

```bash
git clone https://github.com/charlyie/uguu-client.git
```


Run the following commands :
```bash
cd uguu-client/
chmod +x ushare.sh
cp ushare.sh /usr/bin/ushare
```



## Usage

```bash
$ ushare myfile.sql.gz 
[Uguu] Starting transferring file myfile.sql.gz (426M)...
######################################################################## 100.0%
[Uguu] Link to share : https://s.aice.am/unbgthXcGe0p.sql.gz
```
The app returns the URL provided by the API.



## Change Uguu's endpoint 

By default, the client uses the main API client : https://uguu.se/. This endpoint can be changed by using the `--endpoint` argument, like : 
```bash
$ ushare --endpoint "https://share.maecia.com"
[Uguu] Configuration saved in /etc/ushare.conf
```



### Check Configuration

An overrided configuration is stored in `/etc/ushare.conf`. The configuration loaded can be verified by using the `--info`argument, like :

```bash
$ ushare --info
Configuration loaded:
> App Name :             Uguu
> Version :              1.1.0
> Configuration File :   /etc/ushare.conf
> Endpoint :             https://share.maecia.com
```

### 

## Changelog

- **1.1.0 (build 14122020)** :
  - Added custom configuration file
  - Added method to set/get endpoint
  - New Installation method
  - Code cleaning
- **1.0.0 (build 04122020)** : 
  - initial release



## Credits

Uguu client was developed by [Charles Bourgeaux](https://github.com/charlyie)
Uguu is based on [Pomf](http://github.com/pomf/pomf).



## License

Uguu is free software, and is released under the terms of the MIT license. See
`LICENSE`.