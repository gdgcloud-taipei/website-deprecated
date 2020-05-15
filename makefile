all: help

# ex: make new GDGCloud Taipei meetup 47 -> /src/content/blog/gcpug-taipei-meetup-47/index.md created
## new: Create a new post (ex. make new GDGCloud Taipei meetup 47)
new:
	docker run --rm -v $(PWD):/src klakegg/hugo:0.53 new --kind post-bundle content/blog/$(shell docker run -it --rm vandot/casbab kebab "$(call args,defaultstring)")

## server: A high performance webserver
server:
	docker run --rm --name hugo-server -v $(PWD):/src -p 1313:1313 klakegg/hugo:0.53 server -D -w --bind=0.0.0.0

## cleandocker: Clean hugo-server docker container
cleandocker:
	# Remove retailbase containers
	docker ps -f name=hugo-server -aq | xargs docker rm -f

.PHONY: all help

help:
	@echo "Usage: \n"
	@sed -n 's/^##//p' ${MAKEFILE_LIST} | column -t -s ':' |  sed -e 's/^/ /'
	@echo ""
	@for var in $(helps); do \
		echo $$var; \
	done | column -t -s ':' |  sed -e 's/^/  /'	