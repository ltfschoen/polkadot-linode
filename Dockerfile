FROM phusion/baseimage:0.10.1
LABEL maintainer "chevdor@gmail.com"

ARG PROFILE=release
ARG POLKADOT_VERSION=v0.2.1

RUN mkdir -p polkadot && \
  apt-get update && \
  apt-get upgrade -y && \
  apt-get install -y cmake pkg-config libssl-dev git && \
  apt-get clean && \
  mkdir -p /root/.local/share/Polkadot && \
  ln -s /root/.local/share/Polkadot /data

RUN curl https://sh.rustup.rs -sSf | sh -s -- -y && \
  echo 'PATH="$/root/.cargo/bin:$PATH";' >> ~/.bash_profile && \
  . ~/.bash_profile && . /root/.cargo/env && \
  rustup update nightly && \
  rustup target add wasm32-unknown-unknown --toolchain nightly && \
  rustup update stable && rustup default stable && \
  cargo install --git https://github.com/alexcrichton/wasm-gc --force && \
  cargo install --git https://github.com/pepyakin/wasm-export-table.git --force && \
  git clone https://github.com/paritytech/polkadot.git && \
  cd polkadot && \
  git remote add upstream https://github.com/paritytech/polkadot && \
  git fetch upstream ${POLKADOT_VERSION}:${POLKADOT_VERSION} && \
  git checkout ${POLKADOT_VERSION} && \
  ./build.sh && \
  cargo build --$PROFILE && \
  mv target/$PROFILE/polkadot /usr/local/bin && \
  cargo clean && \
  rm -rf /tmp/*

WORKDIR /polkadot
EXPOSE 30333 30344 9933 9944

CMD ["/bin/sh", "polkadot"]
