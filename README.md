# docker-pyspark-custom

This docker projet boostrap standalone and featurefull spark environment to develop ML.

## Quickstart

```
 CONTAINER_ID=$(docker run -d -ti -p 8888:8888 agileops/fastds-tutorial)
 docker logs $CONTAINER_ID -f



```


Note : For compatibilities/accessibilities/simplicites against hardware and env. requirements, tensoflow and pytorch are configured without AVX and Cuda.



## Suggested datasets

To download theses datasets use the following command after cloning this repos.

```
./prepare.sh
```

Contrats octroyés 2009-ajd. 270 mo
https://ouvert.canada.ca/data/fr/dataset/53753f06-8b28-42d7-89f7-04cd014323b0

Vélo. Comptage sur les pristes cyclables
http://donnees.ville.montreal.qc.ca/dataset/velos-comptage
