FROM phusion/baseimage:0.10.1
LABEL maintainer "ltfschoen@gmail.com"

ARG PROFILE=release

RUN apt-get update && \
  apt-get upgrade -y && \
  apt-get install -y cmake pkg-config libssl-dev git clang libclang-dev screen && \
  apt-get clean

RUN curl https://sh.rustup.rs -sSf | sh -s -- -y && \
  echo 'PATH="$/root/.cargo/bin:$PATH";' >> ~/.bash_profile && \
  . ~/.bash_profile && . /root/.cargo/env && \
  rustup update nightly && \
  rustup target add wasm32-unknown-unknown --toolchain nightly && \
  rustup update stable && rustup default stable && \
  cargo install --git https://github.com/alexcrichton/wasm-gc --force && \
  cargo install --git https://github.com/pepyakin/wasm-export-table.git --force && \
  mkdir -p alexander && cd alexander && \
  git clone https://github.com/paritytech/polkadot.git && \
  cd polkadot && \
  git remote add upstream https://github.com/paritytech/polkadot && \
  POLKADOT_VERSION=$(git describe --tags `git rev-list --tags --max-count=1`) && \
  echo $POLKADOT_VERSION && \
  git fetch upstream $POLKADOT_VERSION:$POLKADOT_VERSION && \
  git checkout $POLKADOT_VERSION && \
  ./scripts/build.sh && \
  cargo build --$PROFILE && \
  cp target/$PROFILE/polkadot /usr/local/bin && \
  cargo clean && \
  rm -rf /tmp/*

WORKDIR /alexander/polkadot
EXPOSE 30333 30344 9933 9944

CMD ["/bin/sh", "polkadot"]
