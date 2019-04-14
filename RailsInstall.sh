#!/bin/sh

blue="\033[0;34m"
green="\033[0;32m"
red="\033[0;31m"

if [ $SHELL = "/usr/bin/bash" ]; then
	myshell="~/.bashrc"
fi
if [ $SHELL = "/usr/bin/zsh" ]; then
	myshell="~/.zshrc"
fi

while true; do

echo "
$blue 
============================================================\033[0m
        Digite o número do componente a ser instalado: \033[0m



          $green  1 \033[0m ➜ $blue RVM + Rails \033[0m $green  2 \033[0m ➜ $blue Git \033[0m
          $green  3 \033[0m ➜ $blue NVM \033[0m         $green  4 \033[0m ➜ $blue Nodejs 11 \033[0m
          $green  5 \033[0m ➜ $blue PostgreSql \033[0m  $green  6 \033[0m ➜ $blue Visual Code \033[0m



          00 ➜ Instalar no PC  |    0 ➜ Sair  
$blue 
================= Criado por Wilfison Batista =============  \033[0m"

echo -n "$green ➜\033[0m "

read opcao

#verificar se foi digitada uma opcao
if [ -z $opcao ]; then
	echo "✗  ERRO: digite uma opcao válida!"
	exit
fi

case $opcao in

	1)
		echo -n "Qual versão do ruby você irá ultilizar? "
		read rubyversion

    rubyInstall=""

		if [ -z $rubyversion ]; then
			rubyInstall="rvm install 2.5.1"
    else
		  rubyInstall="rvm install $rubyversion"   
		fi

		echo "$green Instalando componentes necessários! \033[0m" &&
		sudo apt install -y build-essential curl autoconf bison libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm-dev libpq-dev ruby-dev &&
		echo "$green Instalando GPG2 \033[0m" &&
		sudo apt-get install gnupg2 -y &&
    echo "$green Instalando RVM \033[0m" &&
		gpg2 --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB &&
		\curl -sSL https://get.rvm.io &&
		echo "$green Instalando Ruby \033[0m" &&
		$rubyInstall &&
		echo "$green Instalando o Rails \033[0m" &&
		sudo gem install rails &&
		echo "$green Configurando bundle... \033[0m" &&
		sudo gem install bundle &&
		echo "$green Finalizando... \033[0m" &&
		sudo chown -R $(whoami) /var/lib/gems &&
    clear &&
		echo "$green Ruby On Rails instalado com sucesso! \033[0m";;

	2)
		echo "$green Instalando componentes necessários! \033[0m" &&
		sudo apt-get install -y build-essential &&
		echo "$green Instalando SSH \033[0m" &&
		sudo apt install ssh -y &&
		echo "$green Instalando o GIT \033[0m" &&
		sudo apt install git -y &&
    clear &&
		echo "$green Git instalado com sucesso \033[0m"
		echo "$green Agora use os seguintes comandos para configurar seu Git \033[0m"
		echo "$blue git config --global user.name 'seu_nome_de_usuário' \033[0m"
		echo "$blue git config --global user.email seu_email_aqui \033[0m";;

	3)
		echo "$green Instalando componentes necessários! \033[0m" &&
		sudo apt install build-essential checkinstall libssl-dev &&
		echo "$green Baixando o código fonte! \033[0m" &&
		curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash &&
		echo "$green Atualizando as variáveis! \033[0m" &&
		source $myshell &&
		command -v nvm &&
    clear &&
		echo "$green NVM  instalado com sucesso na versão: \033[0m" &&
		nvm --version;;
		
	4)
		echo "$green Instalando componentes necessários! \033[0m" &&
		sudo apt-get install -y build-essential &&
		echo "$green Baixando instalador \033[0m" &&
		curl -sL https://deb.nodesource.com/setup_11.x | sudo -E bash - &&
		echo "$green Instalando... \033[0m" &&
		sudo apt-get install nodejs -y &&
		mkdir ~/.npm-global &&
		npm config set prefix '~/.npm-global' &&
		echo "$green Mudando o diretório global do NPM para a home \033[0m"
		export PATH="~/.npm-global/bin:$PATH" >> ~/.profile &&
		source ~/.profile &&
    clear &&
		echo "$green Node instalado com sucesso! Você pode usar o NPM sem sudo \033[0m";;

  5)
    echo "$green Instalando PostgreSql \033[0m" &&
		sudo apt install postgresql postgresql-contrib libpq-dev -y &&
    clear &&
		echo "$green PostgreSql instalado com sucesso! \033[0m";;

	6)
		echo "$green Instalando chave de acesso! \033[0m" &&
		curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg &&
		sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg &&
		sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list' &&
		echo "$green Atualizando lista de apps \033[0m" &&
		sudo apt update &&
		echo "$green Instalando Visual Studio Code \033[0m" &&
		sudo apt install code -y &&
    clear &&
		echo "$green Visual Code instalado com sucesso \033[0m";;

	0)
		echo "\033[0; Saindo... \033[0m"
		exit;;

	00)
		echo "$green Baixando instalador... \033[0m" &&
		wget https://github.com/Wilfison/RailsInstall/archive/master.zip -O /tmp/RailsInstall.zip &&
		unzip /tmp/RailsInstall.zip -d /tmp &&      
		mkdir ~/.local/share/RailsInstall &&
		cp /tmp/RailsInstall-master/RailsInstall.sh ~/.local/share/RailsInstall &&
		cp /tmp/RailsInstall-master/RailsInstall.desktop ~/.local/share/applications &&
		sudo ln -sf ~/.local/share/RailsInstall/RailsInstall.sh /usr/bin/irails &&
		clear &&
		echo "$green 'Rails Install' instalado com sucesso \033[0m" &&
		echo -e "Agora procure por 'Rails Install' no seu menu de Aplicativos ou execute 'irails' no seu terminal";; 

	*)
		echo "$red ERRO: Digite somente o número de uma das opções acima! \033[0m"
		echo ;;
esac
done
