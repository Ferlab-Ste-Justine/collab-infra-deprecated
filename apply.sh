docker run -v $(pwd)/infra:/opt/terraform \
           -v $(pwd)/hosts:/opt/inventory \
           -v $HOME/.ssh/id_rsa:/opt/keys/id_rsa \
           -v $HOME/.ssh/known_hosts:/root/.ssh/known_hosts \
           -e "ANSIBLE_USER=ubuntu" \
           magnitus/remote-terraform:1.0.0 terraform_apply