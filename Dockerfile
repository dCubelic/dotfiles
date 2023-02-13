# build command:
# docker build -t ctf --ssh default .
FROM ubuntu:20.04

ENV LC_ALL=en_US.UTF-8                                   \
    TERM=xterm-256color                                  \
    LDFLAGS="-rdynamic"                                  \
    MAKEFLAGS="-j8"                                      \
    PATH=/usr/local/go/bin:/usr/bin/rust/cargo/bin:$PATH \
    RUSTUP_HOME=/usr/bin/rust/rustup                     \
    CARGO_HOME=/usr/bin/rust/cargo

# various tools and essentials
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC apt-get -y install tzdata
RUN apt-get -y install curl fzf ripgrep tree git xclip python3 python3-pip \
    nodejs npm ninja-build gettext libtool libtool-bin autoconf automake   \
    cmake g++ pkg-config zip unzip sudo libevent-dev byacc ncurses-dev     \
    ltrace strace gdb zsh wget checksec

# rust
RUN curl --proto '=https' --tlsv1.2 https://sh.rustup.rs -sSf \
    | sh -s -- --default-toolchain stable --profile default --no-modify-path -y

# neovim
RUN git clone --depth=1 --branch=release-0.8 https://github.com/neovim/neovim.git /tmp/neovim && \
    cd /tmp/neovim                                                                            && \
    make CMAKE_BUILD_TYPE=Release                                                             && \
    sudo make install                                                                         && \
    cd / && rm -rf /tmp/neovim

# tmux
RUN git clone --depth=1 https://github.com/tmux/tmux /tmp/tmux && \
    cd /tmp/tmux                                               && \
    sh ./autogen.sh                                            && \
    ./configure                                                && \
    make                                                       && \
    make install                                               && \
    cd /                                                       && \
    rm -rf /tmp/tmux

# bat, exa, ripgrep and fd
RUN cargo install bat exa fd-find ripgrep && \
    rm -rf /usr/bin/rust/cargo/registry

# python3 flake8 and update conan
RUN python3 -m pip install --upgrade pip conan flake8 python-lsp-server tqdm
RUN ln -s /usr/bin/python3 /usr/bin/python

# add ctf user
RUN useradd -ms /bin/zsh ctf

# Add the SSH public keys of github server to the known hosts
RUN mkdir -p -m 0700 /root/.ssh && ssh-keyscan github.com >> /root/.ssh/known_hosts

# stego
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y exiftool binwalk foremost pngtools \
    pngcheck stegosuite hexedit outguess sonic-visualiser \
    forensics-all netcat

# crypto
RUN pip install pyCryptoDome z3-solver

# setup dotfiles
RUN rm -rf /home/ctf/dotfiles
RUN --mount=type=ssh git clone --depth=1 'git@github.com:dCubelic/dotfiles.git' /home/ctf/dotfiles
RUN mkdir /home/ctf/.config
RUN chown -R ctf:ctf /home/ctf/dotfiles /home/ctf/.config

USER ctf
WORKDIR /home/ctf/

RUN ./dotfiles/install.sh

# pwntools
RUN pip install --upgrade pwntools

# gdb-peda
RUN git clone https://github.com/longld/peda.git ~/peda && \
    echo "source ~/peda/peda.py" >> ~/.gdbinit

WORKDIR /home/ctf/ctfs

ENTRYPOINT zsh
