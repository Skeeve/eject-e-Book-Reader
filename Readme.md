# Eject e-Book Reader

This small AppleScript will try to find a connected e-Book reader.
It will display the found reader and ask whether or not to eject.
MacOS specific files will be deleted from the reader befor it is
ejected.

Please note: The script was created with PocketBook Readers in
mind.
It may or may not work with other readers.

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

## How it works

As this script was created mainly for PocketBook e-Book Readers,
it checks for the existance of files found on a PocketBook
Reader:

1. autorun.inf
2. system/<some icon name>

A PocketBook Reader has an autorun.inf file which will contain
the name of the reader (`label=…`) and the path to an icon
file for the reader (`icon=…`).
When this information is found and the device it's found on
is an ejectable device, the script application will ask
whether or not to eject the device.

## Icons used

The icon was created using GIMP and two icons from the Noun Project:

* Eject by Icon Lauk from the Noun Project
* ebook by ProSymbols from the Noun Project
