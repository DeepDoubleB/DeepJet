#!/bin/bash
 
#SBATCH --partition=all
#SBATCH --constraint=P100
#SBATCH --no-requeue 
#SBATCH --time=5:00:00           # Maximum time request
#SBATCH --nodes=1                       # Number of nodes
#SBATCH --workdir   /home/%u/data/DL4/DeepJet/run/
#SBATCH --job-name  DDXtest
#SBATCH --output    run-%j.out  # File to which STDOUT will be written
#SBATCH --error     run-%j.out  # File to which STDERR will be written
#SBATCH --mail-type FAIL, END                 # Type of email notification- BEGIN,END,FAIL,ALL
#SBATCH --mail-user test@desy.de  # Email to which notifications will be sent

INDIR=testhere
cd ~/data/DL4/DeepJet
pwd -P
rm -r $INDIR   
mkdir $INDIR   
source gpu_env.sh

convertFromRoot.py -i lists/list_94x_test.txt -o $INDIR/dctrain -c TrainData_DeepDoubleB_reference
python Train/Train.py -i $INDIR/dctrain/dataCollection.dc -o $INDIR/training --batch 4096 --epochs 5 --resume  -m
cp -r $INDIR/training $INDIR/training_nodec
python Train/Train.py -i $INDIR/dctrain/dataCollection.dc -o $INDIR/training --batch 4096 --epochs 5 --resume --decor -m

convertFromRoot.py -i lists/list_94x_test.txt -o $INDIR/dctest --testdatafor $INDIR/training/trainsamples.dc
#rm -r $INDIR/res*
python Train/Eval.py -i $INDIR/dctest/dataCollection.dc -t $INDIR/dctrain/dataCollection.dc -d $INDIR/training -o $INDIR/res
python Train/Eval.py -i $INDIR/dctest/dataCollection.dc -t $INDIR/dctrain/dataCollection.dc -d $INDIR/training -o $INDIR/res_dec


