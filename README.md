beavers-cluster
===============

Oregon State University High Performance Cluster Documentation

#### Getting access to the cluster

Skip this step if you already have access. If not, use the lines below to check for access. Your username is your EECS/ENGR username. Inside a terminal window, type

```sh
# ssh into the EECS machine
# this step is required if you are not on OSU's network (e.g., off campus)
ssh -l <username> nome.eecs.oregonstate.edu

# this will open a new ssh session on nome
# from here we ssh into the ENGR cluster submit server
ssh -l <username> submit-em64t-01.hpc.engr.oregonstate.edu

# if you have access, this step should land you on the submit server
```

If you have access, you should see something like this,

```
[pinto@nome03 ~]$ ssh -l pinto submit-em64t-01.hpc.engr.oregonstate.edu
Last login: Fri Apr 11 12:41:39 2014 from nome00.eecs.oregonstate.edu
______________________________________________________________________________
|This system is strictly for use by faculty, students, and staff of          |
|       the College of Engineering, Oregon State University.                 |
|                                                                            |
|    Unauthorized access is prohibited - violators will be prosecuted        |
|                                                                            |
|      Use should be consistent with the OSU Acceptable Use Policy           |
|       as well as College of Engineering policies and guidelines.           |
|  Refer to http://engr.oregonstate.edu/computing/faqs/coe_aup/index.html    |
|____________________________________________________________________________|
|   Quotas are used for home directories, incoming email, and printing.      |
|                    For details, check:                                     |
|       http://engr.oregonstate.edu/computing/faqs/quotas.html               |
|____________________________________________________________________________|
|If you have any problems with this machine, mail support@engr.orst.edu      |
|____________________________________________________________________________|
| PLEASE DO NOT RUN JOBS ON THE SUBMIT HOST (THIS HOST). If you do not know  |
| how to submit jobs to the queue please send mail to support@engr.orst.edu. |
|                                                                            |
| Please remember to source the SGE/MPI environment with:                    |
| for mpich version 1 source /scratch/a1/sge/settings.csh                    |
| for mpich version 2 source /scratch/a1/sge/settings-mpich2.csh             |
| for mpich version 2 with the Intel fortran compiler you will want          |
|   to source /scratch/a1/sge/settings-mpich2i.csh                           |
|____________________________________________________________________________|

Terminal type? [xterm]
 12:52:57 up 97 days, 20:36, 15 users,  load average: 0.32, 0.36, 0.35
 USER     TTY      FROM              LOGIN@   IDLE   JCPU   PCPU WHAT
 doggett  pts/0    matt-1.nacse.org 28Mar14  2days  3.24s  3.24s -tcsh
 msander  pts/3    rocknroll.eecs.o 20Mar14  4:54m  0.29s  0.29s -tcsh
 hexi     pts/5    flip1.engr.orego 02Apr14 23:00m 10.48s  0.08s /bin/csh /usr/local/ap
 mosiert  pts/6    rog342-ksharp-1. Wed15   45:04m  6.11s  0.02s qrsh -q matsci
 alkaee   pts/9    10-197-34-169.sd 08:41    4:11m  0.11s  0.11s -tcsh
 hexi     pts/11   dear112-2.mime.o 04Apr14 25:40m  0.27s  0.27s -tcsh
 guan     pts/16   holycross.eecs.o Thu01   24:54m  0.22s  0.22s -csh
 hilkert  pts/17   treyoda.forestry 10:45    2:06m  0.10s  0.10s -tcsh
 lamm     pts/18   128-193-252-120. Thu23   51:40   0.22s  0.22s -tcsh
 machao   pts/19   aleutian.eecs.or Mon11    2days  0.36s  0.36s -tcsh
 pinto    pts/20   nome00.eecs.oreg 12:41    9:01   0.14s  0.14s -tcsh
 pinto    pts/21   nome03.eecs.oreg 12:52    1.00s  0.10s  0.03s w
 irvine   pts/23   pilotstation.eec Wed09   14:15   0.21s  0.10s bash
 irvine   pts/29   pilotstation.eec Wed10    2days  0.15s  0.01s bash
 hexi     pts/32   flip1.engr.orego 03Apr14 39:35m  8:50   0.08s /bin/csh /usr/local/ap
 ```

---

#### Importing the cluster (SGE) environment

This step will import the environment required to execute cluster commands.

```sh
[pinto@submit-em64t-01 ~]$ hostname
submit-em64t-01.hpc.engr.oregonstate.edu
# we are on the submit server

# location holding the environment settings
[pinto@submit-em64t-01 ~]$ ll /scratch/a1/sge/settings*
-rw-r--r--. 1 root root 1007 Dec 19  2012 /scratch/a1/sge/settings.csh
-rw-r--r--. 1 root root 1009 Dec 19  2012 /scratch/a1/sge/settings-mpich2.csh
-rw-r--r--. 1 root root 1011 Dec 19  2012 /scratch/a1/sge/settings-mpich2i.csh
-rw-r--r--. 1 root root  971 Mar 12 09:02 /scratch/a1/sge/settings-mpich2i.sh
-rw-r--r--. 1 root root  969 Mar 12 09:01 /scratch/a1/sge/settings-mpich2.sh
-rw-r--r--. 1 root root  907 Dec 19  2012 /scratch/a1/sge/settings.sh

# Check which shell you're using
[pinto@submit-em64t-01 ~]$ ps
  PID TTY          TIME CMD
 2428 pts/21   00:00:00 tcsh
 4521 pts/21   00:00:00 ps

# I prefer bash (which loads my own environment through .bashrc)
# import settings.csh if you're using tcsh
[pinto@submit-em64t-01 ~]$ bash
Sourcing python /nfs/stak/students/p/pinto/devel/python_env/py3/bin/activate
(py3)bash-4.1$ ps
  PID TTY          TIME CMD
 2428 pts/21   00:00:00 tcsh
 4629 pts/21   00:00:00 bash
 4649 pts/21   00:00:00 ps

# now import the settings for bash
(py3)bash-4.1$ source /scratch/a1/sge/settings.sh

# test if cluster commands work
(py3)bash-4.1$ qstat | head
job-ID  prior   name       user         state submit/start at     queue                          jclass                         slots ja-task-ID
------------------------------------------------------------------------------------------------------------------------------------------------
6883283 0.50500 btpstK20   lettkema     r     03/12/2014 02:35:36 share@compute-4-4.hpc.engr.ore                                    1
6937457 0.50500 boots4     lettkema     r     03/17/2014 19:23:03 share@compute-3-12.hpc.engr.or                                    1
7016240 0.53227 PrInR2     alexg        r     03/26/2014 15:55:29 matsci@compute-5-4.hpc.engr.or                                    4
7016247 0.53227 PrInR9     alexg        r     03/26/2014 15:55:29 share3@compute-8-12r.hpc.engr.                                    4
7016250 0.53227 PrInR12    alexg        r     03/26/2014 15:55:29 matsci@compute-5-6.hpc.engr.or                                    4
7088233 0.50500 Peng       leip         r     04/01/2014 21:49:53 eecs@compute-0-2.hpc.engr.oreg                                    1
7091722 0.55045 I6TH2      desousal     r     04/02/2014 17:49:36 matsci@compute-5-4.hpc.engr.or                                    6
7092204 0.50500 s70        orr          r     04/02/2014 21:51:36 share4@compute-6-26r.hpc.engr.                                    1
```
---

#### Basic cluster commands (qstat)

* List all queues I have access to
```sh
(py3)bash-4.1$ qstat -g c -U pinto
CLUSTER QUEUE                   CQLOAD   USED    RES  AVAIL  TOTAL aoACDS  cdsuE
--------------------------------------------------------------------------------
all.q                             -NA-      0      0      0      0      0      0
ce                                0.52     12      0      4     16      0      0
eecs                              0.33     36      0     72    108      0      0
eecs2                             0.32     46      0     98    144      0      0
em64t                             0.29     11      0     33     44      0      0
share                             0.11      2      0     70     72      0      0
share2                            0.12     17      0    215    232      0      0
share3                            0.02      4      0    228    232      0      0
share4                            0.10      2      0    126    128      0      0
```

* List all jobs for user "emmott"
```
(py3)bash-4.1$ qstat -u emmott | head
job-ID  prior   name       user         state submit/start at     queue                          jclass                         slots ja-task-ID
------------------------------------------------------------------------------------------------------------------------------------------------
7170266 0.50500 ye.1006.ga emmott       r     04/11/2014 08:45:27 eecs2@compute-2-11.hpc.engr.or                                    1
7170309 0.50500 ye.1007.ga emmott       r     04/11/2014 08:52:08 eecs2@compute-2-7.hpc.engr.ore                                    1
7170310 0.50500 ye.1008.ga emmott       r     04/11/2014 08:52:08 eecs@compute-0-7.hpc.engr.oreg                                    1
7170353 0.50500 ye.1009.ga emmott       r     04/11/2014 08:59:42 eecs2@compute-2-12.hpc.engr.or                                    1
7170354 0.50500 ye.1010.ga emmott       r     04/11/2014 09:02:42 eecs2@compute-2-4.hpc.engr.ore                                    1
7170355 0.50500 ye.1011.ga emmott       r     04/11/2014 09:02:42 eecs@compute-0-3.hpc.engr.oreg                                    1
7170356 0.50500 ye.1012.ga emmott       r     04/11/2014 09:03:12 eecs2@compute-2-7.hpc.engr.ore                                    1
7170357 0.50500 ye.1013.ga emmott       r     04/11/2014 09:05:42 eecs@compute-0-8.hpc.engr.oreg                                    1
```

* The qstat tool can do much, much more. Read its documentation.
```
(py3)bash-4.1$ qstat -help
```

---

#### Submitting a job (qsub)

To submit a job, you need a submit script which is any executable script. The script contains all the configuration settings for the job. For example, the job name, which queue it should go to, where the output is, etc. Read the qsub documentation for details.

Here we show two examples. A simple bash script and a more complex python script. The submit scripts are located under ```examples/submit_easy.sh``` and ```examples/submit_notsoeasy.sh```. 


