#!/bin/bash - 
#===============================================================================
#
#          FILE: slurm_command.sh
# 
USAGE=" ./slurm_command.sh  "
# 
#   DESCRIPTION:  
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Tang (Tang), chao.tang.1@gmail.com
#  ORGANIZATION: le2p
#       CREATED: 02/18/16 06:34:55 CET
#      REVISION:  ---
#===============================================================================

#set -o nounset                             # Treat unset variables as an error
shopt -s extglob 							# "shopt -u extglob" to turn it off
source ~/Shell/functions.sh      			# TANG's shell functions.sh

#=================================================== 


sacctmgr list

Man pages exist for all SLURM daemons, commands, and API functions. The command option --help also provides a brief summary of options. Note that the command options are all case insensitive.

sacct is used to report job or job step accounting information about active or completed jobs.

salloc is used to allocate resources for a job in real time. Typically this is used to allocate resources and spawn a shell. The shell is then used to execute srun commands to launch parallel tasks.

sattach is used to attach standard input, output, and error plus signal capabilities to a currently running job or job step. One can attach to and detach from jobs multiple times.

sbatch is used to submit a job script for later execution. The script will typically contain one or more srun commands to launch parallel tasks.

sbcast is used to transfer a file from local disk to local disk on the nodes allocated to a job. This can be used to effectively use diskless compute nodes or provide improved performance relative to a shared file system.

scancel is used to cancel a pending or running job or job step. It can also be used to send an arbitrary signal to all processes associated with a running job or job step.

scontrol is the administrative tool used to view and/or modify SLURM state. Note that many scontrol commands can only be executed as user root.

sinfo reports the state of partitions and nodes managed by SLURM. It has a wide variety of filtering, sorting, and formatting options.

smap reports state information for jobs, partitions, and nodes managed by SLURM, but graphically displays the information to reflect network topology.

squeue reports the state of jobs or job steps. It has a wide variety of filtering, sorting, and formatting options. By default, it reports the running jobs in priority order and then the pending jobs in priority order.

srun is used to submit a job for execution or initiate job steps in real time. srun has a wide variety of options to specify resource requirements, including: minimum and maximum node count, processor count, specific nodes to use or not use, and specific node characteristics (so much memory, disk space, certain required features, etc.). A job can contain multiple job steps executing sequentially or in parallel on independent or shared nodes within the job's node allocation.

smap reports state information for jobs, partitions, and nodes managed by SLURM, but graphically displays the information to reflect network topology.

strigger is used to set, get or view event triggers. Event triggers include things such as nodes going down or jobs approaching their time limit.

sview is a graphical user interface to get and update state information for jobs, partitions, and nodes managed by SLURM.

'

#=================================================== 

#submit jobB depend on jobA
sbatch --dependency=afterok:<jobID_A> jobB.sh

# submit 
sbatch job.slurm

#kill a job
scancel 999999

#view status of queues:
squeue -u ctang/squeue | grep ctang

#Check current job by id
sacct -j 999999

