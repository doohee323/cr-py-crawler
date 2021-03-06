# cr-py-crawler

Youtube crawler with scrapy and selenium(for lazy loading elements).

## -. Prep. 
``` 
    pip3 install scrapy
    pip3 install selenium
    pip3 install --upgrade -r requirements.txt
    
    brew cask install chromedriver
``` 

## -. Run crawl with CLI
```
    to test this url, https://www.youtube.com/watch?v=ioNng23DkIM,

    $> cd youtube
    $> crawl youtube -a watch_ids=ioNng23DkIM -o test.json -t json
```

## -. Run crawl with curl
```
    $> cd projects/cr-py-crawler
    $> python3 youtube/youtube/server.py
    Starting httpd server on localhost:8000
    
    $> curl -d "watch_ids=ioNng23DkIM" -X POST http://localhost:8000/crawl
    json files will be made under youtube folder.

    It can be run by CLI for multiple IDs through httpd server.
    $> python3 youtube/youtube/cli.py -l /mnt/list.txt
    It makes json files in the specific path
    $> python3 youtube/youtube/cli.py -l /mnt/list.txt -j /mnt/data
```

## -. docker
```
    $> docker pull doohee323/cr-py-crawler:latest
    $> docker run -d -v `pwd`/youtube:/code/youtube -p 8000:8000 cr-py-crawler
    $> curl -d "watch_ids=ioNng23DkIM" -X POST http://localhost:8000/crawl 
```

## -. k8s in Jenkins
``` 
    sudo mkdir -p /vagrant/data
    sudo chmod -Rf 777 /vagrant/data

    cd /vagrant/projects
    git clone https://github.com/doohee323/cr-py-crawler.git
    cd /vagrant/projects/cr-py-crawler

    k apply -f cr-py-crawler-pv.yaml
    k delete -f cr-py-crawler.yaml

    # Jenkins global settings
        http://dooheehong323:31000/configure
        Global properties > Environment variables > Add
        ORGANIZATION_NAME: doohee323
        YOUR_DOCKERHUB_USERNAME: doohee323
        DOCKER_REGISTRY_URL: http://192.168.1.10:5000

    # make a project in Jenkins
        new item
        name: cr-py-crawler
        type: multibranch Pipeline
        Display Name: cr-py-crawler
        Branch Sources: GitHub
            Credential: Jenkins
                Username: doohee323 # github id
                Password: xxxx
                    https://docs.github.com/en/free-pro-team@latest/github/authenticating-to-github/creating-a-personal-access-token
                ID: GitHub
                Description: GitHub
    
        Repository HTTPS URL: https://github.com/doohee323/cr-py-crawler.git

    # Run the project

    ## checking the result 
        k get all | grep cr-py-crawler
```

## Debugging spider.py 
``` 
Script path: ~/cr-k8s-vagrant/projects/cr-py-crawler/venv/bin/scrapy
Parameters: crawl youtube -a watch_ids=ioNng23DkIM -o any_name.json -t json
Sworking Dir: ~/cr-k8s-vagrant/projects/cr-py-crawler/youtube
```