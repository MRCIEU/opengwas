# source package repos for aarch64
options(
  repos = c(
    universe = "https://mrcieu.r-universe.dev/",
    CRAN = "https://p3m.dev/cran/2025-04-30"
  ),
  pkg.sysreqs_db_update_timeout = as.difftime(59, units = "secs")
)

# Set the Bioconductor version to prevent defaulting to a newer version:
Sys.setenv("R_BIOC_VERSION" = "3.21")

if (R.Version()$arch == "x86_64") {
  # Linux binary package repos for x86_64
  options(
    repos = c(
      universe = "https://mrcieu.r-universe.dev/bin/linux/noble/4.5/",
      CRAN = "https://p3m.dev/cran/__linux__/noble/2025-04-30",
      BioCsoft = "https://packagemanager.posit.co/bioconductor/__linux__/noble/2025-04-29"
    ),
    BIOCONDUCTOR_CONFIG_FILE = "https://packagemanager.posit.co/bioconductor/2025-04-29/config.yaml",
    HTTPUserAgent = sprintf(
      'R/%s R (%s)',
      getRversion(),
      paste(
        getRversion(),
        R.version['platform'],
        R.version['arch'],
        R.version['os']
      )
    )
  )
}

# install prebuilt binary pak from their repo
install.packages(
  c("pak"),
  repos = sprintf(
    "https://r-lib.github.io/p/pak/stable/%s/%s/%s",
    .Platform$pkgType,
    R.Version()$os,
    R.Version()$arch
  )
)

pak::pkg_install("gwasvcf", dependencies = TRUE)

# install TwoSampleMR and hard and soft deps
pak::pkg_install("TwoSampleMR", dependencies = TRUE)
pak::pkg_install(c("coloc", "susieR", "gwasglue", "jrs95/geni.plots"), dependencies = TRUE)

# mr.raps suggests packages from BioConductor
pak::pkg_install(c("bumphunter", "TxDb.Hsapiens.UCSC.hg38.knownGene"))

remove.packages("pak")