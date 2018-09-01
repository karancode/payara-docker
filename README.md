# Dockerizing Payara 
Docker Images for payara base & payara wrapper!


## Payara Base
Base image which fetched payara server-full zip. Prepares the server directory(unzip) & other required directories.
Also sets some obvious envrioment vars.

 
## Payara Wrapper
Image prepared on the top of `Payara Base` image.
Creates all required payara configurations.
Deploys test application war (primeface-showcase) & keeps entrypoint as `start-domain`.


### Run
```
docker pull dockt/payarawrapper:1.1
docker run -d -p 4848:4848 -p 8080:8080 dockt/payarawrapper:2.0
```


### Version
Run the newest tag available on docker registry for both `Payara Base` & `Payara Wrapper` images.


### Docker Registry
* [Dockt](https://hub.docker.com/u/dockt/) - The docker hub registry
* [PayaraBase](https://hub.docker.com/r/dockt/payarabase/) - The PayaraBase Image
* [PayaraWrapper](https://hub.docker.com/r/dockt/payarawrapper/) - The PayaraWrapper Image


### Authors
* **Karan Thanvi**

*Last Update date : 2018-07-20*

