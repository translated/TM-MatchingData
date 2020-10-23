# TM-MatchingData
This repository contains the software to run the translation memory (TM) clustering service developed during the CEF Data MarketPlace project.

The goal of the tool is to identify the translation units (TU) that are "similar" to a given seed TM. The idea is to allow a user to create a focussed TM on a particular topic.  This is obtained by running a software able to learn the peculiarities of the seed data and use them to rank and isolate the most similar TUs in the large TM.

## The tool
The tool includes the TAUS Matching Data software. It is a search technique that uses an example data set (the seed) to search a data repository (the large TM), calculate matching scores on segment-level and return high-fidelity matched data. For each TU in the seed, the best matching data in the large TM is identified, on a segment-level basis similarity. Then, the selected data are ranked based on an enhanced scoring schema. The top k TUs are identified as the most similar to the seed.

The tool is accessible by an API that allows a user to process one or multiple TUs at the time. More details about the API specifications are available below.


## Installation and Usage

The Docker image of the code is available here  (around 3GB) 


Once the Docker image has been downloaded, it has to be added to your docker environment
```bash
$ docker load < image.clustering_service.tar.gz
```

To start the service, run the following command:
```bash
$ docker run --rm -it --publish 8080:8080 clustering_service
```

The process prints different information, when it prints the message
```bash
web service ready at port 8080
```
this means it is ready to accept requests.

Requests can be issued at the following URLs:
* http://localhost:8080/clustering_service.php
* http://${PUBLIC-IP}:8080/clustering_service.php


### Example

TBD


## API specifications

[The API specs of the clustering Service are available here](https:)

## Web GUI (Graphical User Interface)

To test the tool, a web graphical interface is made available in the Docker. It consists of a simple web page, where the seed and the large TMs can be uploaded and processed by the tool returning the list of the selected TUs. The GUI allows the user to provide an email address to which the output of the tool is sent. 

## Credits

FBK and TAUS developed the Clustering Service:
* TAUS for the development of the Matching Data algorithm;
* FBK for the web service, interface with TAUS Matching Data, web GUI and integration.


## Contacts

Please email cattoni AT fbk DOT eu

