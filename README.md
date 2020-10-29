# TM-MatchingData
This repository contains the software to run the translation memory (TM) clustering service developed within the [CEF Data MarketPlace project](https://www.datamarketplace.eu). A service based on this tool is offered by the TAUS Data MarketPlace platform.

The goal of the tool is to identify the translation units (TUs) that are "similar" to a given seed TM. The idea is to allow a user to create a focussed TM on a particular topic.  This is obtained by running a software able to learn the peculiarities of the seed data and use them to rank and isolate the most similar TUs in a large TM.

## The tool
The tool includes the [TAUS Matching Data software](https://md.taus.net/). It is a search technique that uses an example data set (the seed) to search a data repository (the large TM), calculate matching scores at the segment level and return high-fidelity matched data. For each TU in the seed, the best matching data in the large TM is identified, on a similarity segment-level basis similarity. Then, the selected TUs are ranked based on an enhanced scoring schema. The top k TUs are identified as the most similar to the seed.

The tool is accessible by an API. More details about the API specifications are available below.


## Installation and Usage

The Docker image of the code is available [here](https://drive.google.com/file/d/1CIYSDx-Nb0GpYKKB-WIPEnEiXa5v9nfb/view?usp=sharing) (around 230 MB)

No specific hardware or software is required (only the optional "email" functionality requires an email sending service running on the host)

Once the Docker image has been downloaded, it has to be added to your docker environment
```bash
$ docker load < image.clustering_service.tar.gz
```

To start the service, run the following command:
```bash
$ docker run --net=host --rm -it clustering_service
```

Then wait until the process prints the message
```bash
PHP 7.4.11 Development Server (http://0.0.0.0:8082) started
```
this means it is ready to accept requests.

Requests can be issued at the following URLs:
* http://localhost:8082/clustering_service.php
* http://${PUBLIC-IP}:8082/clustering_service.php


### Example

The request
```bash
curl -X POST -F src=en -F tgt=it -F maincorpus=@$mainCorpusFile -F seedcorpus=@$seedCorpusFile -F maxtus=2 http://localhost:8082/clustering_service.php
```
uploads mainCorpusFile and seedCorpusFile as the files containing respectively the available TUs to be searched and the seed TUs, and with the parameter maxtus=2 specifies that the response should include no more than 2 TUs.
It produces the response:
```bash
{"status": 0,
  "info": "src_sentence_1 \t tgt_sentence_1 \t score_1 \n 
           src_sentence_2 \t tgt_sentence_2 \t score_2 \n "}
```


## API specifications

The web service is exposed as a REST API, where REST is to be interpreted in the weak meaning (the web service here described does not use WSDL/SOAP but is defined directly over the HTTP protocol).

One endpoint is exposed at the level of files containing TUs.

### /clustering_service.php

HTTP Method: POST

Parameters:
* maincorpus (file, mandatory): file of TUs (tab-separated source sentence and target sentence), one for line;
* seedcorpus (file, mandatory):  file of TUs (tab-separated source sentence and target sentence), one for line;
* src (string, mandatory): source language encoded with a two-char ISO 639-1 code;
* tgt (string, mandatory): target language encoded with a two-char ISO 639-1 code;
* maxtus (integer, optional): it sets the maximum number of TUs to be returned in the response; if unspecified, all the found TUs are returned;
* email (string, optional): an email address to which the results are to be sent;

Response:

The service sends a reply in JSON format to either acknowledge the success or to report an error. It include the attributes "status" and "info".

Success: the attribute "status" is 0 and the attribute "info" contains the TUs found by the process.

Failure: the attribute "status" is 1 and the attribute "info" contains the error description.


## Web GUI (Graphical User Interface)

To test the tool, a web graphical interface is made available in the Docker. It consists of a simple web page, where the seed and the large TMs can be uploaded and processed by the tool returning the list of the selected TUs. The GUI allows the user to provide an email address to which the output of the tool is sent. 

## Credits

FBK and TAUS developed the Clustering Service:
* TAUS for the development of the Matching Data algorithm;
* FBK for the web service, interface with TAUS Matching Data, web GUI and integration.


## Contacts

Please email cattoni AT fbk DOT eu

