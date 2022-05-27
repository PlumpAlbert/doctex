# vim:ft=dockerfile:ts=4:et
FROM alpine:latest
# install essential packages
RUN apk update && apk add --no-cache \
    git \
    perl-lwp-protocol-https \
    curl \
    fontconfig
# copy files into container
COPY texlive.profile /tmp/tex-installer/texlive.profile
COPY times/ /usr/share/fonts/times/
COPY latexmkrc /root/.latexmkrc
# Obtain texlive installer
RUN wget -qO- "https://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz" \
    | tar xvz -C /tmp \
    && mv /tmp/install-tl*/* /tmp/tex-installer
RUN /tmp/tex-installer/install-tl -no-gui -profile /tmp/tex-installer/texlive.profile
RUN tlmgr paper a4 \
    && tlmgr install latexmk

# make times new roman visible for latex
RUN cp "/usr/local/texlive/texmf-var/fonts/conf/texlive-fontconfig.conf" /etc/fonts/conf.d/09-texlive.conf \
    && fc-cache -fsv \
    && git clone 'https://github.com/plumpalbert/latex-texmf' /root/texmf \
    && cp -r /root/texmf/* /usr/local/texlive/texmf-local

ENV PATH=/usr/local/texlive/bin/x86_64-linux:$PATH
ENV SRC_DIR=/work/src
ENV BUILD_DIR=/work/build
ENV AUX_DIR=${BUILD_DIR}
ENV LOG_DIR=/work/log

RUN mkdir -p "${SRC_DIR}" \
    && mkdir -p "${BUILD_DIR}" \
    && mkdir -p "${LOG_DIR}"

COPY compile.sh /usr/local/bin/compile
RUN chmod 755 /usr/local/bin/compile
WORKDIR ${SRC_DIR}
CMD [ "/usr/local/bin/compile" ]
