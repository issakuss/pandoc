VERSION = 2.18

all:
	make build
	make push
	make create
	make manipush

# Execute on ARM64 computer (Apple Silicon)
pusharm:
	docker build -t issakuss/pandoc-arm64:$(VERSION) -f Dockerfile-arm64 .
	docker push issakuss/pandoc-arm64:$(VERSION)

# Execute on AMD64 computer (Intel)
pushamd:
	docker build -t issakuss/pandoc-amd64:$(VERSION) -f Dockerfile-amd64 .
	docker push issakuss/pandoc-amd64:$(VERSION)

create:
	docker manifest create issakuss/pandoc:$(VERSION) \
		issakuss/pandoc-amd64:$(VERSION) \
		issakuss/pandoc-arm64:$(VERSION)

push:
	docker manifest push issakuss/pandoc:$(VERSION)