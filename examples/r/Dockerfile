FROM bioconductor/bioconductor_docker:devel

WORKDIR /project

# Get reference datasets
RUN wget http://fileserve.mrcieu.ac.uk/vcf/annotations.vcf.gz.rsidx
RUN wget http://fileserve.mrcieu.ac.uk/ld/1kg.v3.tgz
RUN mkdir -p data/reference/ld
RUN mv annotations.vcf.gz.rsidx data/reference/
RUN mv 1kg.v3.tgz data/reference/ld/
RUN cd data/reference/ld/ && tar xzvf 1kg.v3.tgz && rm 1kg.v3.tgz && cd -

# Install renv
ENV RENV_VERSION 0.16.0
RUN R -e "install.packages('remotes')"

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

RUN R -e "remotes::install_github('mrcieu/gwasvcf')"
RUN R -e "remotes::install_github('mrcieu/ieugwasr')"
RUN R -e "remotes::install_github('mrcieu/TwoSampleMR')"
RUN R -e "install.packages('coloc')"
RUN R -e "install.packages('susieR')"

RUN sudo apt update
RUN sudo apt install sqlite3
