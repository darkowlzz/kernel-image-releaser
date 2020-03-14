# Check https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/refs/ for updates
REGISTRY?=darkowlzz
IMAGE_NAME?=${REGISTRY}/ignite-kernel
KERNEL_VERSIONS ?= 4.14.166 4.19.97 5.4.13
GOARCH?=amd64
GOARCH_LIST = amd64 arm64

ifeq ($(GOARCH),amd64)
KERNEL_ARCH=x86
VMLINUX_PATH=vmlinux
endif
ifeq ($(GOARCH),arm64)
ARCH_MAKE_PARAMS="ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu-"
KERNEL_ARCH=arm64
VMLINUX_PATH=arch/arm64/boot/Image
endif

all: build

push:
	docker push darkowlzz/ignite-kernel:4.19.97-arm64

build: $(addprefix build-,$(KERNEL_VERSIONS))
build-%:
	docker build -t $(IMAGE_NAME):$*-${GOARCH} \
		--build-arg KERNEL_VERSION=$* \
		--build-arg ARCH=${KERNEL_ARCH} \
		--build-arg GOARCH=${GOARCH} \
		--build-arg ARCH_MAKE_PARAMS=${ARCH_MAKE_PARAMS} \
		--build-arg VMLINUX_PATH=${VMLINUX_PATH} .
