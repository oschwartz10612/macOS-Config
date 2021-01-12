# Remote pbcopy
Copy to clipboard over ssh conneciton.

## Install
Copy `pbcopy.plist` to `~/Library/LaunchAgents/pbcopy.plist`

Run `launchctl load ~/Library/LaunchAgents/pbcopy.plist`

## Usage

`cat | nc -q1 localhost 2224`
