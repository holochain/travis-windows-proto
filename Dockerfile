FROM mcr.microsoft.com/windows/servercore

RUN curl -sSf https://build.travis-ci.com/files/rustup-init.sh | sh -s -- --default-toolchain=$TRAVIS_RUST_VERSION -y

RUN rustc --version

RUN rustup --version

RUN cargo --version