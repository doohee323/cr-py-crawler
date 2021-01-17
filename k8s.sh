#!/usr/bin/env bash

shopt -s expand_aliases
alias k='kubectl --kubeconfig ~/.kube/config'

sudo mkdir -p /vagrant/data
sudo chmod -Rf 777 /vagrant/data

cd /vagrant/projects/cr-py-crawler

k delete -f cr-py-crawler_cronJob.yaml
k delete -f cr-py-crawler.yaml
k delete -f cr-py-crawler-pv.yaml

k apply -f cr-py-crawler-pv.yaml
#k get pv
#k get pvc

k apply -f cr-py-crawler.yaml

k apply -f cr-py-crawler_cronJob.yaml

sleep 30

k get all

#curl -d "watch_ids=ioNng23DkIM" -X POST http://localhost:30007/crawl
#curl -d "watch_ids=ioNng23DkIM" -X POST http://localhost:8000/crawl
#curl -d "watch_ids=ioNng23DkIM" -X POST http://localhost:8088/crawl

exit 0

python /code/youtube/server.py -p 8088

k create deployment cr-py-crawler --image=doohee323/cr-py-crawler:latest
#k create deployment cr-py-crawler --image=doohee323/cr-py-crawler:debug3
#k expose rc cr-py-crawler --port=8000 --target-port=8000

#k exec -it pod/cr-py-crawler-95cd4c99b-lz47d bash
#k exec -it deployment.apps/cr-py-crawler bash
#k -v=9 exec -it pod/cr-py-crawler-6cc76cdbc9-2fpfx -- sh
#k exec -it pod/cr-py-crawler-job-1608427500-kv4mx -- sh
#/usr/bin/python3 /code/youtube/cli.py -l /mnt/list.txt

k get deployment cr-py-crawler -o yaml > cr-py-crawler.yaml
#k delete deployment.apps/cr-py-crawler
#docker rmi doohee323/cr-py-crawler:debug1

