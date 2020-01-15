KERNEL_VERSION ?= 4.19.47
KERNEL_EXTRA ?= 

all: build
build:
	docker build -t darkowlzz/ignite-kernel:${KERNEL_VERSION}${KERNEL_EXTRA} \
		--build-arg KERNEL_VERSION=${KERNEL_VERSION} \
		--build-arg KERNEL_EXTRA=${KERNEL_EXTRA} .

push:
	docker push darkowlzz/ignite-kernel:${KERNEL_VERSION}${KERNEL_EXTRA}
