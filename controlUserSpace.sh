#!/bin/bash

#Script utilizado para controlar o tamanho maximo da area de usuarios na maquina urano
#A politica implementada pelo script pode ser lida na mensagem de uso abaixo

#inicializando os valores default


min=2097152    #2G
max=214748364800  #200G
dias=7


#imprime mensagem de uso caso os parametros nao sejam fornecidos corretamente
if [ $# -eq 1 ] || [ $# -eq 2 ] || [ $# -gt 3 ]; then
	echo
	echo "Uso: `basename $0` <min> <max> <dias> 1>&2 "
	echo
	echo "Este script ira verificar o escapo ocupado pela area de um usuario e garantir que "
	echo "o mesmo atenda a seguinte politica:"
	echo "- Os usuarios podem manter por tempo indeterminado uma quantidade de dados inferior a <min>"
	echo "- Os usuarios podem manter por no maximo <dias> uma quantidade de dados entre <min> e <max>"
	echo "   Caso isto ocorra, arquivos com mais de <dias> de criacao sao apagados"
	echo "- Os usuarios nao podem manter uma quantidade de dados maior que <max>. Caso isto ocorra, "
	echo "	todos os arquivos do usuario sao removidos imediatamente"
	echo
	echo "Os valores de <min> e <max> devem ser dados em KBytes."

	exit 0
fi

if [ $# -eq 3 ]; then  #usuario forneceu os parametros para sobresvecrer os valores default

	if [ $1 -gt $2 ]; then  #o minimo eh maior que o maximo ERRO!!!
		echo "A menor quantidade de dados no diretorio nao pode ser superior a maior quantidade aceita."
		exit 1
	fi;

	#sobrescrevendo os valores
	min=$1
	max=$2
	dias=$3
fi 

#para cada um dos diretorios em /home e /home/externo
for i in `ls -d /home/{*,externo/*} | grep -v externo$`;do 
	tam=`du -s $i|awk '{print $1}'`; #tamanho em KB do diretorio em analise

	if [ -z $tam ];then #caso a variavel tam nao tenha sido inicializada, inicializa-se com 0
		tam=0;
	fi
	
	if [ $tam -gt $max ]; then   #dados armazenados superam o tamanho maximo permitido e serao apagados imediatamente
		echo rm -f $i/*
	fi;

	if [ $tam -gt $min ] && [ $tam -lt $max ]; then   #dados armazenados superam o tamanho minimo permitido. Arquivos com mais de <dias> serao apagados
		find $i -mtime +$dias -type f ! -name '.*' | xargs echo 

	fi;
done

exit 0
	
done;
	 
