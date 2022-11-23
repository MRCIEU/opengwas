# Using OpenGWAS from R

The main R packages for the OpenGWAS project are:

- [ieugwasr](https://github.com/MRCIEU/ieugwasr)
- [gwasvcf](https://github.com/MRCIEU/gwasvcf)
- [gwasglue](https://github.com/MRCIEU/gwasglue)
- [TwoSampleMR](https://github.com/MRCIEU/TwoSampleMR)

One approach to easily install these packages is to use the docker image that also contains relevant reference data files 

To get an interactive console:

```bash
docker run --rm -it -v $(pwd):/workspace -w /workspace mrcieu/opengwas-r:0.1.6 R
```

To get an RStudio session at http://localhost:8787 

```bash
docker run --rm -p 8787:8787 -e PASSWORD=bioc -w /project/workspace/ -v ${PWD}:/project/workspace/ mrcieu/opengwas-r:0.1.6
```

## Future

- Add extra dependencies that relate to gwasglue2 including data sources and analytical tools.
- Figure out how to support arm64 hardware (e.g. see https://github.com/rstudio/rstudio/issues/8809)
- Organise vignettes for how to use OpenGWAS
- Stop including the LD reference data there, and provide examples of downloading it separately and linking as a volume
