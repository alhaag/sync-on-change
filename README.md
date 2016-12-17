# sync-on-change

Sinconiza modificações de arquivos localmente ou para um servidor remoto.

Observa um diretório (recursivamente) para alterações de arquivos e diretórios e realiza o sincronismo dessas modificações no destino.

Para evitar executar o comando várias vezes quando uma sequência de acontecimentos ocorre, o script aguarda um segundo após a alterações. Se mais mudanças acontecem, o tempo limite é estendido por um segundo novamente.

## Dependências

 * bash
 * inotifywait (do pacote inotify-tools package).

Para instalar no Ubuntu:
```
$ sudo apt-get install inotify-tools
```

Caso a quantidade de arquivos watch files do sistema exceda alterar limite:
```
$ sudo sysctl fs.inotify.max_user_watches=<quantidade_desejada>
```

## Instalação
```
$ make install
```

## Desinstalação
```
$ make uninstall
```

## Como utilizar
```
$ sync-on-change <source> <target>
$ sync-on-change /var/www/html/project/ root@192.168.0.254:/var/www/html/project
```

Para obter ajuda:
```
$ man sync-on-change
```

## Contribuição

Contribuições de melhoria e correções serão bem vindas. Para isso pode ser realizado um commit sobre um fork do projeto.

## TODO:

Opção para realizar o ssh-copy-id e liberar a transferência sem precisar informar senha várias vezes quando o destino for um servidor remoto.

Validar parâmetros de entrada.
