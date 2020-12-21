FROM nnurphy/jpl-go

### Rust
ENV RUST_VERSION=1.47.0
ENV CARGO_HOME=/opt/cargo RUSTUP_HOME=/opt/rustup
ENV PATH=${CARGO_HOME}/bin:$PATH

RUN set -ex \
  # /opt/cargo/registry/index/github.com-*/.cargo-index-lock
  ; curl https://sh.rustup.rs -sSf \
    | sh -s -- --default-toolchain stable -y \
  ; rustup component add rust-analysis rust-src clippy rustfmt \
  ; rustup target add x86_64-unknown-linux-musl \
  ; cargo install cargo-wasi wasm-pack cargo-prefetch \
  ; cargo prefetch serde serde_yaml serde_json fern \
      reqwest actix actix-web diesel nom handlebars \
      structopt config chrono lru-cache itertools \
  ; cargo install evcxr_jupyter \
  ; evcxr_jupyter --install \
  ; rm -rf ${CARGO_HOME}/registry/src/*

RUN set -ex \
  ; curl -L https://github.com/rust-analyzer/rust-analyzer/releases/latest/download/rust-analyzer-linux \
        -o /usr/local/bin/rust-analyzer \
  ; chmod +x /usr/local/bin/rust-analyzer

