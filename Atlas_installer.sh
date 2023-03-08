#!/bin/bash

# extracting the java package
tar -xzvf jdk-19_linux-x64_bin.tar.gz 

# placing java package in the right location
sudo mkdir /usr/java
sudo cp -r jdk-19.0.2 /usr/java/

# placing atlas files in the right location
sudo cp -r soft /

# writing the environment variables for java and atlas
export JAVA_HOME=/usr/java/jdk-19.0.2
export PATH=$JAVA_HOME/bin:$PATH
export ATLAS_HOME=/soft/gaph/tools/atlas
export PATH=$ATLAS_HOME:$PATH

# compiling atlas
/soft/gaph/tools/atlas/linuxcompile
