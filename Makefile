install:
	@sudo chmod a+rx sync-on-change.sh && \
	sudo cp sync-on-change.sh /usr/local/bin/sync-on-change && \
	echo "Instalado em /usr/local/bin/sync-on-change" && \
	sudo cp man /usr/local/man/man8/sync-on-change.8
uninstall:
	@sudo rm /usr/local/bin/sync-on-change && \
	sudo rm /usr/local/man/man8/sync-on-change.8