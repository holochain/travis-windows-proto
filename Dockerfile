FROM mcr.microsoft.com/windows/servercore AS installer

CMD curl -sSf https://build.travis-ci.com/files/rustup-init.sh | sh -s -- --default-toolchain=$TRAVIS_RUST_VERSION -y

CMD rustc --version

CMD rustup --version

CMD cargo --version