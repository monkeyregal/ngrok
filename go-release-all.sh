#!/bin/sh

HOSTARCH=$(go env GOHOSTARCH)
HOSTOS=$(go env GOHOSTOS)

PLATFORMS="darwin/386 darwin/amd64 freebsd/386 freebsd/amd64 freebsd/arm linux/386 linux/amd64 linux/arm windows/386 windows/amd64 openbsd/386 openbsd/amd64"

for PLATFORM in $PLATFORMS; do
    GOOS=${PLATFORM%/*}
    GOARCH=${PLATFORM#*/}
    if [ $HOSTARCH = $GOARCH -a $HOSTOS = $GOOS ]
    then
        GOBIN="bin/${HOSTOS}_${HOSTARCH}"
    else
        GOBIN="bin/"
    fi

    GOOS=${GOOS} GOARCH=${GOARCH} GOBIN=${GOBIN} make clean release-client release-server
done
