j!/bin/bash -ex

mkdir -p build
chmod 777 build
mkdir -p huafetcher-builder-buildozer
chmod 777 huafetcher-builder-buildozer
docker rmi huafetcher-builder || true
docker build -t huafetcher-builder .
docker run -it \
  --platform linux/amd64 \
  -v $PWD/huafetcher-builder-buildozer:/home/buildozer \
  -v $PWD/build/:/build \
  huafetcher-builder \
  bash -c 'set -eux \
    ; export PATH=/home/buildozer/.local/bin:$PATH \
    ; cd /home/buildozer \
    ; if [ -e huafetcher ] \
    ; then \
        cd huafetcher \
    ;   git config pull.rebase true \
    ;   git pull \
    ; else \
        git clone --recurse-submodules https://codeberg.org/isaaclo123/huafetcher.git \
    ;   cd huafetcher \
    ;   touch huami_token/__init__.py \
    ; fi \
    ; buildozer -v android debug \
    ; cp /home/buildozer/huafetcher/bin/*.apk /build/ \
  '


# ;   git checkout master \
# ;   git reset --hard \
# ;   git config pull.rebase true \
# ;   git pull \
