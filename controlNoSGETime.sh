#!/bin/bash

#desconsiderando processos com owners em excessao
#Para permitir que um usuario execute temporariamente jobs sem o SGE, basta 
#inseri-lo na lista abaixo
function inException() {
  local owner=$1;

  except_users="root postgres bacula httpd ganglia dbus rpc postfix 68"; 

  pertence=0;  #hipotese que o owner nao pertence a lista de excessao
  for i in $except_users; do 
    if [ "$owner" == "$i" ]; then
      pertence=1;
    fi;
  done;
  return $pertence;
}

function excideTime() { #verifica se o processo excedeu 15 minutos
  local time=$1;
  hora=`echo $time|awk -F ':' {'print $1'}`;
  if [ "$hora" != "00" ];then 
    return 1;
  fi

  minutos=`echo $time|awk -F ':' {'print $3'}`
  if [ $minutos -gt 1 ];then 
    return 1;
  fi

  return 0;
}

function descentFromSGE() {
  local pid=$1;
  local pidSGE=$2;
  local ttl=$3;
  if [ $ttl -eq 0 ]; then
     return 0; #nao foi possivel averiguar que o processo descende do sge_execd
  fi
  if [ "$pid" == "$pidSGE" ];then
     return 1; #o pid original descende do sge_execd
  fi
  if [ $pid -eq 1 ]; then
     return 0; #o pid original descende do init, sem passar pelo sge_execd
  fi
  #determinando o pai do pid atual
  ppid=`grep ^$pid /tmp/sgeTimeControl.tmp|awk {'print $2'}`;
  return $(descentFromSGE $ppid $pidSGE);
}

######### O script inicia-se aqui #################
###################################################

#gerando uma listagem de todos os processos
ps -eo pid,ppid,user,time|grep -v PID > /tmp/sgeTimeControl.tmp

pidSGE=`ps  -eo pid,cmd|grep -i sge_execd|grep -v grep|awk {'print $1'}`
logFile="/var/log/killedJobsByControlCPUTime.log"

if [ -z "$pidSGE" ]; then
  date >> $logFile
  echo "Nao foi possivel identificar o PID do processo sge_execd" >> $logFile
  exit 1
fi

while IFS=' ' read pid ppid owner time #deve ter ordem igual ao comando time acima
do
  if ( inException $owner );then     #owner nao esta na excessao
    if ! ( excideTime $time );then     #esta rodando a mais de 15 minutos
      if ( descentFromSGE $pid $pidSGE );then    #nao eh um processo descendente do SGE
	date >> $logFile
	ps -eo pid,ppid,user,time,stime,cmd -q $pid >> $logFile
	#kill -9 $pid  ####processo nao autorizado eliminado
      fi
    fi
  fi
done < /tmp/sgeTimeControl.tmp

#apagado a listagem gerada temporariamente em disco
rm /tmp/sgeTimeControl.tmp
