#!/bin/sh
### Set the job name (for your reference)
#PBS -N train-SemBERT
### Set the project name, your department code by default
#PBS -P mausam.inlp.cs
#### Request your resources, just change the numbers
#PBS -lselect=1:ncpus=1:ngpus=1:centos=skylake
### Specify "wallclock time" required for this job, hhh:mm:ss
#PBS -l walltime=6:00:00
### force priority
#PBS -q high

echo "==============================="
echo $PBS_JOBID
cat $PBS_NODEFILE
echo "==============================="
cd $PBS_O_WORKDIR
echo $PBS_O_WORKDIR
module () {
        eval `/usr/share/Modules/$MODULE_VERSION/bin/modulecmd bash $*`
}

module load apps/pytorch/1.6.0/gpu/anaconda3
module load apps/anaconda/3EnvCreation
source activate base
export PYTHONPATH=$HOME/.local/lib/python3.6/site-packages:$PYTHONPATH
cd /scratch/maths/btech/mt1180045/SemBERT
pwd
export MPLBACKEND=agg

python run_classifier_snli_online_tagging.py \
--data_dir new_dialog_data/outdomain/only_circa \
--task_name snli \
--train_batch_size 6 \
--max_seq_length 128 \
--bert_model snli_sembert_model/ \
--learning_rate 2e-5 \
--num_train_epochs 2 \
--do_train \
--do_eval \
--do_predict \
--do_lower_case \
--max_num_aspect 3 \
--output_dir new_models/outdomain/only_circa_FT \
--tagger_path srl_model/