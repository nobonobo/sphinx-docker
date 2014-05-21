.PHONY: build localbuild run stop clean

TAG=local/sphinx-texlive2013
USER=$(shell echo $$USER)
GITHUBUSER=

build: stop _build clean
localbuild: stop _localbuild clean

_localbuild:
	make -C base
	make -C texlive
	docker build --rm -t $(TAG) .

_build: ./Dockerfile
	if ! docker images | grep nobonobo/sphinx-texlive2013 ; then docker pull nobonobo/sphinx-texlive2013; fi
	docker build --rm -t $(TAG) .

run: stop _run

_run:
	docker run -d -p 22 -v $$HOME:/mnt/home $(TAG) $(OPT)

./Dockerfile: ./Dockerfile.local
	@if [ "$(GITHUBUSER)" = "" ]; then echo 'need make option GITHUBUSER=****'; exit 1; fi
	cat Dockerfile.local | sed 's/$${GITHUBUSER}/$(GITHUBUSER)/g' | sed 's/$${USER}/$(USER)/g' > Dockerfile

stop:
	@running="$$(docker ps | grep $(TAG) | awk '{print $$1}')" \
	bash -c 'if [ -n "$$running" ]; then docker kill $$running; fi'
	@containers="$$(docker ps -a | grep $(TAG) | awk '{print $$1}')" \
	bash -c 'if [ -n "$$containers" ]; then docker rm $$containers; fi'

clean:
	@exited="$$(docker ps -a | grep Exit | awk '{print $$1}')" \
	bash -c 'if [ -n "$$exited" ]; then docker rm $$exited; fi'
	@images="$$(docker images | grep "<none>" | awk '{print $$3}')" \
	bash -c 'if [ -n "$$images" ]; then docker rmi $$images; fi'

ssh:
	ssh -p $$(docker port $$(docker ps | grep $(TAG) | cut -f1 -d" ") 22 | cut -d: -f2) $$USER@localhost
