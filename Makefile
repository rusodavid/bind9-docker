all: build

build:
	@docker build --tag=squid .
