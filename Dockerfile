FROM ubuntu:19.04

ENV PATH $PATH:/usr/local/texlive/2019/bin/x86_64-linux

RUN apt update \
 && apt install -y \
      perl \
      python-pygments \
      wget \
      xz-utils \
      fonts-noto-cjk \
      fonts-noto-cjk-extra \
      libfontconfig-dev \
      ghostscript \
 && cd /tmp \
 && wget -nv -O install-tl.tar.gz \
      http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz \
 && mkdir install-tl \
 && tar -xzf install-tl.tar.gz -C install-tl --strip-components=1 \
 && cd install-tl/ \
 && printf "%s\n" \
      "selected_scheme scheme-basic" \
      "option_doc 0" \
      "option_src 0" \
      > ./texlive.profile \
 && ./install-tl --profile=./texlive.profile \
 && tlmgr install \
      collection-latexrecommended \
      collection-latexextra \
      collection-fontsrecommended \
      collection-langjapanese \
      latexmk \
      xetex \
 && mkdir -p \
      /usr/local/texlive/texmf-local/fonts/opentype/google/notosanscjk/ \
 && mkdir -p \
      /usr/local/texlive/texmf-local/fonts/opentype/google/notoserifcjk/ \
 && ln -s /usr/share/fonts/opentype/noto/NotoSansCJK-*.ttc \
      /usr/local/texlive/texmf-local/fonts/opentype/google/notosanscjk/ \
 && ln -s /usr/share/fonts/opentype/noto/NotoSerifCJK-*.ttc \
      /usr/local/texlive/texmf-local/fonts/opentype/google/notoserifcjk/ \
 && mktexlsr \
 && cd ../ \
 && rm -rf install-tl.tar.gz install-tl \
 && apt purge -y wget xz-utils libfontconfig-dev \
 && apt autoremove -y \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

RUN mkdir /texsrc

VOLUME /texsrc

WORKDIR /texsrc

CMD ["/bin/bash"]
