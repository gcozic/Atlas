# Atlas installation

Atlas is a Network-on-Chip (NoC) generator including several parameters.
The Documentation is available on https://corfu.pucrs.br/redmine/projects/atlas.
This installation guide is using Ubunu 22.04.


## Repository organisation

- Atlas_installer.sh : Install the java and Atlas packages and compile Atlas
- Atlas_launcher.sh : Launch the application
- soft : here are the Atlas files
- jdk-19_linux-x64_bin.tar.gz : compressed java package

## Installation guide line

First launch the Atlas_installer with :

        sh Atlas_installer.sh

You can now launch the Atlas_laucher with :

        sh Atlas_launcher.sh

The application will open. Two warning windows appears. Juste clic OK to continue. A third window will demand you the path to a web browser. By default, firefox is stored in /snap/bin/firefox.