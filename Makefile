cleanup:
	docker stop hello-world
	docker image rm nginxdemos/hello
	rm -r ./var/downloads/*
	rm -r ./var/torrents/*