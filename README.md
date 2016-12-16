# sync-on-change

Sinconiza modifica��es de arquivos localmente ou para um servidor remoto.

Observa um diret�rio (recursivamente) para altera��es de arquivos e diret�rios e realiza o sincronismo dessas modifica��es no destino.

Para evitar executar o comando v�rias vezes quando uma sequ�ncia de acontecimentos, o script aguarda um segundo ap�s a altera��o. Se mais mudan�as acontecem, o tempo limite � estendido por um segundo novamente.

## Depend�ncias

 * bash
 * inotifywait (do pacote inotify-tools package).

Para instalar no Ubuntu:
```
$ sudo apt-get install inotify-tools
```

Caso a quantidade de arquvos watch files do sistema exceda alterar limite:
```
$ sudo sysctl fs.inotify.max_user_watches=500000
```

## Instala��o
```
$ make install
```

## Como utilizar
```
$ onchange <source> <target>
$ onchange /var/www/html/project/ root@192.168.0.254:/var/www/html/project
```

Para obter ajuda:
```
$ man sync-on-change
```

## Contribui��o

Contribui��es de melhoria sempre ser�o bem vindas. Para isso pode ser realizado um commit sobre um fork do projeto.

## TODO:

Op��o para realizar o ssh-copy-id automaticamente.

Validar par�metros de entrada.

Escrever o manual man
