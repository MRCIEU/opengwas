FROM rocker/r-ver:4.5.0
WORKDIR /usr/local/src/myscripts
RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
    apt-get install -yyy \
        build-essential \
        libcurl4-openssl-dev \
        libxml2-dev \
        libssl-dev \
        libgmp3-dev \
        cmake \
        libcairo2-dev \
        libxt-dev \
        libharfbuzz-dev \
        libtiff-dev \
        libstdc++6 \
        pandoc \
        sqlite3 \
        wget

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
RUN wget https://s3.amazonaws.com/plink2-assets/alpha6/plink2_linux_avx2_20250420.zip && \
    unzip plink2_linux_avx2_20250420.zip && \
    mv plink2 /bin/ && \
    rm plink2_linux_avx2_20250420.zip

# Get plink1.9
RUN wget https://s3.amazonaws.com/plink1-assets/plink_linux_x86_64_20241022.zip && \
    mkdir plinktemp && mv plink_linux_x86_64_20241022.zip plinktemp && cd plinktemp && \
    unzip plink_linux_x86_64_20241022.zip && \
    mv plink /bin/ && \
    cd ../ && rm -r plinktemp

RUN DEBIAN_FRONTEND=noninteractive apt-get install -yyy \
        libcurl4-gnutls-dev

RUN --mount=type=bind,source=build.r,target=/tmp/build.r \
    Rscript /tmp/build.r