#!/bin/bash

DATA_DIR=$HOME/devel/data/cluster_test

# name the job
#$ -N test_job

# scheduler uses mem_free to find a suitable node
# h_vmem limits the maximum amount of memory usable by the job
# always upper bound the job's memory usage
#$ -l mem_free=4096m,h_vmem=4096m

# select a queue (use the share queues if you don't have deadlines)
#$ -q share4

# specify where the output (stdout) must go
#$ -o $HOME/devel/data/cluster_test/output2

# combines stdout and stderr (all output goes to the above)
#$ -j y

# now execute whatever command you need
# here we execute some basic shell commands and exit

echo "hello cluster node"
echo "starting at "; date
echo "======================="
env
echo "======================="
uname -a
echo "======================="
echo "goodbye cluster node"
echo "ending at "; date
