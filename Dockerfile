FROM nnurphy/jpl-go

### Rust
ENV CARGO_HOME=/opt/cargo RUSTUP_HOME=/opt/rustup RUST_VERSION=1.42.0
ENV PATH=${CARGO_HOME}/bin:$PATH

RUN set -ex \
  # /opt/cargo/registry/index/github.com-*/.cargo-index-lock
  ; curl https://sh.rustup.rs -sSf \
    | sh -s -- --default-toolchain stable -y \
  ; rustup component add rls rust-analysis rust-src clippy rustfmt \
  ; rustup target add x86_64-unknown-linux-musl \
  # gluon_repl gluon_language-server mdbook
  ; cargo install cargo-wasi wasm-pack cargo-prefetch \
  ; cargo prefetch serde serde_yaml serde_json \
      structopt reqwest config chrono lru-cache itertools nom handlebars \
  ; cargo install evcxr_jupyter \
  ; evcxr_jupyter --install \
  #; cargo install -q iron actix actix-web may reqwest rlua \
  ; rm -rf ${CARGO_HOME}/registry/src/*
