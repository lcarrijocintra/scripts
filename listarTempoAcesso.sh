#!/bin/bash

if [ -f "$1" ] || [ -d "$1" ]; then 
  cd "$1"
  for i in *;do
      	if [ -d "$i" ]; then
		/home/lcintra/scripts/listarTempoAcesso.sh "$i";
	elif [ -f "$i" ] && [ -s "$i" ]; then
		stats=`stat "$i"`;
		#stats=`echo $stats|awk -F "'" {'print $2'}`;
		#echo $stats;
		#obtendo filename
		#fileName=`echo $stats|awk {'print $2'}`;
		#fileName=${fileName/\`/};
		#fileName=${fileName/\'/};

		#obtendo tamanho de arquivos
		fileSize=`echo $stats|awk -F ":" {'print $3'}`;
		fileSize=${fileSize/Blocks/};
		
		#obtendo dono do arquivos
		fileUser=`echo $stats|awk -F ":" {'print $10'}`;
		fileUser=${fileUser/Gid/}
		fileUser=${fileUser// /}
		
		
		#obtendo ultimo acesso ao  arquivo
		accessTime=`echo $stats|awk -F ":" {'print $12'}`;
		accessTime=`echo $accessTime|awk {'print $1'}`;
	
		filePath=`pwd`;	
		echo ${filePath// /#}"/"${i// /#} $fileSize $fileUser $accessTime;
		
	fi
  done
fi
