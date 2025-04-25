FROM ghcr.io/r-universe-org/base-image

COPY . /rotemplate
RUN R -e 'install.packages("remotes"); remotes::install_local("/rotemplate")'
