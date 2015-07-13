#!/bin/bash

dbHost='localhost'
dbName='sgejobs'
dbUser='sgejobs'
#Esta senha deverá estar no arquivo ~/.pgpass do usuario que ira executar o job
#dbPasswd='sgeJobs#123'

usage () {
	echo 'Usage: loadSgeJobs.sh <lineingFilename>'
	echo '       O script recebe como parâmetro o nome do arquivo de lineing do SGE'
}

if [ $# -ne 1 ]; then
	usage
	exit
fi

lineingName=$1

#lendo todas as linhas do arquivo de lineing
while read line
do
	if [ ${line:0:1} != "#" ]; then
		#identificando cada um dos campos na linha de contabilidade
		qname=`echo $line|awk -F : {'printf $1'}`
		#echo qname=$qname
		hostname=`echo $line|awk -F : {'printf $2'}`
		#echo hostname=$hostname
		group=`echo $line|awk -F : {'printf $3'}`
		#echo group=$group
		owner=`echo $line|awk -F : {'printf $4'}`
		#echo owner=$owner
		job_name=`echo $line|awk -F : {'printf $5'}`
		#echo job_name=$job_name
		job_number=`echo $line|awk -F : {'printf $6'}`
		#echo job_number=$job_number
		account=`echo $line|awk -F : {'printf $7'}`
		#echo account=$account
		priority=`echo $line|awk -F : {'printf $8'}`
		#echo priority=$priority
		submission_time=`echo $line|awk -F : {'printf $9'}`
		submission_time=`date -d @$submission_time  +"%Y-%m-%d %T %z"`
		#echo submission_time=$submission_time
		start_time=`echo $line|awk -F : {'printf $10'}`
		start_time=`date -d @$start_time  +"%Y-%m-%d %T %z"`
		#echo start_time=$start_time
		end_time=`echo $line|awk -F : {'printf $11'}`
		end_time=`date -d @$end_time  +"%Y-%m-%d %T %z"`
		#echo end_time=$end_time
		failed=`echo $line|awk -F : {'printf $12'}`
		#echo failed=$failed
		exit_status=`echo $line|awk -F : {'printf $13'}`
		#echo exit_status=$exit_status
		ru_wallclock=`echo $line|awk -F : {'printf $14'}`
		#echo ru_wallclock=$ru_wallclock
		ru_utime=`echo $line|awk -F : {'printf $15'}`
		#echo ru_utime=$ru_utime
		ru_stime=`echo $line|awk -F : {'printf $16'}`
		#echo ru_stime=$ru_stime
		ru_maxrss=`echo $line|awk -F : {'printf $17'}`
		#echo ru_maxrss=$ru_maxrss
		ru_ixrss=`echo $line|awk -F : {'printf $18'}`
		#echo ru_ixrss=$ru_ixrss
		ru_ismrss=`echo $line|awk -F : {'printf $19'}`
		#echo ru_ismrss=$ru_ismrss
		ru_idrss=`echo $line|awk -F : {'printf $20'}`
		#echo ru_idrss=$ru_idrss
		ru_isrss=`echo $line|awk -F : {'printf $21'}`
		#echo ru_isrss=$ru_isrss
		ru_minflt=`echo $line|awk -F : {'printf $22'}`
		#echo ru_minflt=$ru_minflt
		ru_majflt=`echo $line|awk -F : {'printf $23'}`
		#echo ru_majflt=$ru_majflt
		ru_nswap=`echo $line|awk -F : {'printf $24'}`
		#echo ru_nswap=$ru_nswap
		ru_inblock=`echo $line|awk -F : {'printf $25'}`
		#echo ru_inblock=$ru_inblock
		ru_oublock=`echo $line|awk -F : {'printf $26'}`
		#echo ru_oublock=$ru_oublock
		ru_msgsnd=`echo $line|awk -F : {'printf $27'}`
		#echo ru_msgsnd=$ru_msgsnd
		ru_msgrcv=`echo $line|awk -F : {'printf $28'}`
		#echo ru_msgrcv=$ru_msgrcv
		ru_nsignals=`echo $line|awk -F : {'printf $29'}`
		#echo ru_nsignals=$ru_nsignals
		ru_nvcsw=`echo $line|awk -F : {'printf $30'}`
		#echo ru_nvcsw=$ru_nvcsw
		ru_nivcsw=`echo $line|awk -F : {'printf $31'}`
		#echo ru_nivcsw=$ru_nivcsw
		project=`echo $line|awk -F : {'printf $32'}`
		#echo project=$project
		department=`echo $line|awk -F : {'printf $33'}`
		#echo department=$department
		granted_pe=`echo $line|awk -F : {'printf $34'}`
		#echo granted_pe=$granted_pe
		slots=`echo $line|awk -F : {'printf $35'}`
		#echo slots=$slots
		task_number=`echo $line|awk -F : {'printf $36'}`
		#echo task_number=$task_number
		cpu=`echo $line|awk -F : {'printf $37'}`
		#echo cpu=$cpu
		mem=`echo $line|awk -F : {'printf $38'}`
		#echo mem=$mem
		io=`echo $line|awk -F : {'printf $39'}`
		#echo io=$io
		category=`echo $line|awk -F : {'printf $40'}`
		#echo category=$category
		iow=`echo $line|awk -F : {'printf $41'}`
		#echo iow=$iow
		maxvmem=`echo $line|awk -F : {'printf $43'}`
		#echo maxvmem=$maxvmem
		arid=`echo $line|awk -F : {'printf $44'}`
		#echo arid=$arid

		#gerando a instrucao SQL de insercao
		sqlInsert="Insert into sgeJobs(qname,hostname,\"group\",owner,job_name,job_number,account,priority,"
		sqlInsert="$sqlInsert submission_time,start_time,end_time,failed,exit_status,ru_wallclock,ru_utime,"
		sqlInsert="$sqlInsert ru_stime,ru_maxrss,ru_ixrss,ru_ismrss,ru_idrss,ru_isrss,ru_minflt,ru_majflt,"
		sqlInsert="$sqlInsert ru_nswap,ru_inblock,ru_oublock,ru_msgsnd,ru_msgrcv,ru_nsignals,ru_nvcsw,ru_nivcsw,"
		sqlInsert="$sqlInsert project,department,granted_pe,slots,task_number,cpu,mem,io,category,iow,maxvmem,arid) "
		sqlInsert="$sqlInsert values('$qname','$hostname','$group','$owner','$job_name',$job_number,"
		sqlInsert="$sqlInsert '$account',$priority,TIMESTAMP '$submission_time',TIMESTAMP '$start_time',"
		sqlInsert="$sqlInsert TIMESTAMP '$end_time',$failed,$exit_status,$ru_wallclock,$ru_utime,$ru_stime,"
		sqlInsert="$sqlInsert $ru_maxrss,$ru_ixrss,$ru_ismrss,$ru_idrss,$ru_isrss,$ru_minflt,$ru_majflt,"
		sqlInsert="$sqlInsert $ru_nswap,$ru_inblock,$ru_oublock,$ru_msgsnd,$ru_msgrcv,$ru_nsignals,$ru_nvcsw,$ru_nivcsw,"
		sqlInsert="$sqlInsert '$project','$department','$granted_pe',$slots,$task_number,$cpu,$mem,$io,"
		sqlInsert="$sqlInsert '$category',$iow,$maxvmem,$arid) ";
		#echo $sqlInsert
		
		#executando a insercao no banco
		echo $sqlInsert | psql -d "$dbName" -h "$dbHost" -U "$dbUser" -w 2> /dev/null;
	fi
done < "$lineingName"
