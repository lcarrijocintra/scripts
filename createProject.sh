#!/bin/bash

usage () {
        echo 'Usage: createProjects.sh  <projectName> [owner] [group]'
        echo '       O script recebe como parâmetr(s) o nome do projeto, o usuario que sera dono do mesmo e o grupo 
		     de controle de acesso aos dados do projeto. Se o usuario nao for fornecido, usa-se o root. Se
		     o grupo de controle de acesso nao for fornecido, usa-se o grupo nogroup'
}

if [ $# -lt 1 ]; then
        usage
        exit
fi

project=$1
owner="root"
group="nogroup"
BaseDir="/projects"

if [ $# -eq 2 ]; then
	owner=$2
fi
if [ $# -gt 2 ]; then
	group=$3
fi

if [ -e $BaseDir/$project ]; then
	echo "Projeto já existente!"
	exit
fi

#criando o projeto
mkdir $BaseDir/$project
mkdir -p $BaseDir/$project/data/raw.data
mkdir -p $BaseDir/$project/data/raw.data.gz
mkdir -p $BaseDir/$project/docs
mkdir -p $BaseDir/$project/bin
mkdir -p $BaseDir/$project/results

#setando owner e group
chown -R $owner $BaseDir/$project

chgrp -R $group $BaseDir/$project

#atribuindo permissoes padrao
chmod 750 $BaseDir/$project
chmod -R 770 $BaseDir/$project/*
chmod -R 750 $BaseDir/$project/data/raw*

