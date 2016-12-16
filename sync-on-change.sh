#!/bin/bash
#
# Sinconiza modifica��es de arquivos localmente ou para um servidor remoto.
# Observa um diret�rio (recursivamente) para altera��es de arquivo e execute
# e realiza o sincronismo dessas modifica��es no destino.
# Para evitar executar o comando v�rias vezes quando uma seq��ncia de
# Acontecimentos, o script aguarda um segundo ap�s a altera��o - se
# Mais mudan�as acontecem, o tempo limite � estendido por um segundo novamente.
# Caso a transfer�ncia seja para um servidor remoto pode ser interessante
# liberar o acesso por chave para que n�o seja necess�rio informar a senha a
# cada modifica��o. Ex:
#    $ ssh-copy-id root@<server_ip>
#
# Requisitos:
#    bash e inotifywait (do pacote inotify-tools package). No Ubuntu:
#    $ sudo apt-get install inotify-tools
#
#    Caso a quantidade de arquvos watch files do sistema exceda alterar limite:
#    $ sudo sysctl fs.inotify.max_user_watches=500000
#
# Instala��o:
#    $ chmod a+rx sync-on-change.sh
#    $ sudo cp sync-on-change.sh /usr/local/bin/sync-on-change
#
# Examplo de uso:
#    $ sync-on-change <source> <target>
#    $ sync-on-change /var/www/html/project/ root@192.168.0.254:/var/www/html/project
#
# Author: Andre Luiz Haag <andreluizhaag@gmail.com>
#
# TODO: Op��o para realizar o ssh-copy-id automaticamente.
# TODO: Validar par�metros de entrada.
# ######################################

#
# Global vars
# ######################################
source="."
target="/tmp"

# ######################################
# Loop infinito de verifica��o de modifica��o de arquivos e diret�rios a partir
# de $source. Quando ocorre uma modifica��o a pr�xima fun��o � executada. Ex:
# observeModification echo "alterado!"
#
# Globals:
#   $source Diret�rio a ser observado.
#
# Paramns:
#   null
#
# Return:
#   void
# ######################################
observeModification() {
    EVENTS="CREATE,CLOSE_WRITE,DELETE,MODIFY,MOVED_FROM,MOVED_TO"

    if [ -z "$1" ]; then
        echo "Usage: $0 cmd ..."
        exit -1;
    fi

    inotifywait -e "$EVENTS" -m -r --format '%:e %f' $source | (
        WAITING="";
        while true; do
            LINE="";
            read -t 1 LINE;
            if test -z "$LINE"; then
                if test ! -z "$WAITING"; then
                    echo "CHANGE";
                    WAITING="";
                fi;
            else
                WAITING=1;
            fi;
        done) | (
        while true; do
            read TMP;
            echo $@
            $@
        done
    )
}

# ######################################
# Faz a copia dos arquivos modificados de $source para $target.
# Alguns arquivos e diret�rios est�o marcados para n�o serem sincronizados.
# TODO: lista de excludes configur�vel.
#
# Globals:
#   $source Diret�rio que sofreu a modifica��o.
#   $target Diret�rio de destino para onde os arquivos modificados devem ser
#           copiados.
#
# Paramns:
#   null
#
# Return:
#   void
# ######################################
sync() {
    rsync -e ssh -varz \
        --exclude '.svn' \
        --exclude '.git' \
        --exclude '.vscode' \
        --exclude 'nbproject' \
        --exclude 'tags' \
        $source $target
}

#
# main
# ######################################
source="$1"
target="$2"
observeModification sync