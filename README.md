# sync-on-change

Sinconiza modificações de arquivos localmente ou para um servidor remoto.

Observa um diretório (recursivamente) para alterações de arquivos e diretórios e realiza o sincronismo dessas modificações no destino.

Para evitar executar o comando várias vezes quando uma sequência de acontecimentos, o script aguarda um segundo após a alteração. Se mais mudanças acontecem, o tempo limite é estendido por um segundo novamente.

## Dependências

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

## Instalação
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

## Contribuição

Contribuições de melhoria sempre serão bem vindas. Para isso pode ser realizado um commit sobre um fork do projeto.

## TODO:

Opção para realizar o ssh-copy-id automaticamente.

Validar parâmetros de entrada.

Escrever o manual man
