FROM bioconductor/bioconductor_docker:RELEASE_3_16

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        sqlite3 && \
    apt-get autoremove -y && \
    apt-get autoclean -y

WORKDIR /project

# Get reference datasets
RUN wget http://fileserve.mrcieu.ac.uk/vcf/annotations.vcf.gz.rsidx; \
    wget http://fileserve.mrcieu.ac.uk/ld/1kg.v3.tgz; \
    mkdir -p data/reference/ld ; \
    mv annotations.vcf.gz.rsidx data/reference/ ; \
    mv 1kg.v3.tgz data/reference/ld/ ; \
    cd data/reference/ld/ && tar xzvf 1kg.v3.tgz && rm 1kg.v3.tgz && cd -

# Get bcftools
ENV BCFTOOLS_VERSION 1.16
RUN wget https://github.com/samtools/bcftools/releases/download/${BCFTOOLS_VERSION}/bcftools-${BCFTOOLS_VERSION}.tar.bz2 && \
    tar -xf bcftools-${BCFTOOLS_VERSION}.tar.bz2 && \
    cd bcftools-${BCFTOOLS_VERSION} && \
    make && \
    mv bcftools /bin/ && \
    cd ../ && \
    rm -r bcftools-${BCFTOOLS_VERSION} bcftools-${BCFTOOLS_VERSION}.tar.bz2

# Get plink2
RUN wget https://s3.amazonaws.com/plink2-assets/alpha3/plink2_linux_x86_64_20220814.zip && \
    unzip plink2_linux_x86_64_20220814.zip && \
    mv plink2 /bin/ && \
    rm plink2_linux_x86_64_20220814.zip

# Get plink1.9
RUN wget https://s3.amazonaws.com/plink1-assets/plink_linux_x86_64_20220402.zip && \
    mkdir plinktemp && mv plink_linux_x86_64_20220402.zip plinktemp && cd plinktemp && \
    unzip plink_linux_x86_64_20220402.zip && \
    mv plink /bin/ && \
    cd ../ && rm -r plinktemp

# Install R packages
ENV RENV_VERSION 0.16.0
RUN R -e "options(repos = c(CRAN = 'https://packagemanager.posit.co/cran/__linux__/jammy/latest')); \
    install.packages('pak'); \
    pak::pkg_install(c('tidyverse', 'remotes', 'renv', 'coloc', 'susieR', \
        'rmarkdown', 'knitr', 'commonmark', 'markdown')); \
    pak::pkg_install('mrcieu/ieugwasr'); \
    pak::pkg_install('mrcieu/TwoSampleMR'); \
    pak::pkg_install('remlapmot/gwasvcf@fixes-11-2022')"
