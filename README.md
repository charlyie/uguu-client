# Uguu-client
Uguu-compatible command line bash client
This client is able to send local files fo [Uguu](https://github.com/nokonoko/Uguu) compatible client like [this fork](https://github.com/charlyie/Uguu).
Uguu is a simple lightweight temporary file uploading and sharing platform where files get deleted after X amount of time.

## Features

- Easy server file uploading, no registration required


## Requirements

Requires packages `curl` and `jq` installed on the Operating System.

## Install

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
ushare myfile.zip
```
The app returns the URL provided by the API.


## Change Uguu's endpoint 

By default, the client uses the main API client : https://uguu.se/, but this url can be changed by editing the .sh file :
```bash
# Editable variables
ENDPOINT="https://uguu.se"
```


## Credits

Uguu client was developed by [Charles Bourgeaux](https://github.com/charlyie)
Uguu is based on [Pomf](http://github.com/pomf/pomf).

## License

Uguu is free software, and is released under the terms of the MIT license. See
`LICENSE`.
