#!/bin/bash
export JAVA_HOME=/usr/java/jdk-19.0.1
export PATH=$JAVA_HOME/bin:$PATH
export ATLAS_HOME=/soft/gaph/tools/atlas
export PATH=$ATLAS_HOME:$PATH
export MODELSIM_HOME=/usr/intelFPGA/16.1/modelsim_ase
export PATH=$MODELSIM_HOME/bin:$PATH
#export LM_LICENSE
export GNUPLOT_HOME=/usr/gnuplot/gnuplot-5.4.5
export PATH=$/usr/bin:$PATH
/soft/gaph/tools/atlas/linuxcompile
/soft/gaph/tools/atlas/atlas
