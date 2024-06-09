docker rm -f ubuntu centos7 fedora1 fedora2

docker run -d -t --name centos7 pycontribs/centos:7
docker run -d -t --name ubuntu pycontribs/ubuntu:latest
docker run -d -t --name fedora1 pycontribs/fedora
docker run -d -t --name fedora2 pycontribs/fedora

ansible-playbook -i playbook/inventory/prod.yml playbook/site.yml --vault-password-file playbook/.secret.txt 

docker rm -f ubuntu centos7 fedora1 fedora2