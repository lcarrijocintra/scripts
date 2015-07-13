#!/bin/bash


suffix_name=`date|awk {'print $6$2$3"_"$4'}`

/home/lcintra/scripts/listarTempoAcesso.sh /home > /root/listagemArquivos/home_$suffix_name
/home/lcintra/scripts/listarTempoAcesso.sh /projects > /root/listagemArquivos/projects_$suffix_name
