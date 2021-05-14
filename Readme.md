# Eject e-Book Reader

This small AppleScript will try to find a connected e-Book reader.
It will display the found reader and ask whether or not to eject.
MacOS specific files will be deleted from the reader befor it is
ejected.

## Installation

Simply check out the repository and run

`./install`

to install `eject e-Book Reader` int `/Applications`.

To just build the application script run

`./install build`

To build and create a zip file run

`./install zip`

## Security

Upon first run, the script does not have full disk access, which
is required to delete files.
Please grant full disk access if you want to use the script.

## Icons used

The icon was created using GIMP and two icons from the Noun Project:

* Eject by Icon Lauk from the Noun Project
* ebook by ProSymbols from the Noun Project
