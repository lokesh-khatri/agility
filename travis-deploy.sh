#!/usr/bin/env bash

if [ "${TRAVIS_PULL_REQUEST}" != "false" ]; then
    echo "Not deploying pull request."
    exit
fi

echo -e "\nRunning Travis Deployment"
echo "Setting up Git Access"
openssl aes-256-cbc -K ${encrypted_cda326ff967d_key} -iv ${encrypted_cda326ff967d_iv} -in deploy_key.enc -out deploy_key -d
chmod 600 deploy_key

eval `ssh-agent -s`
ssh-add deploy_key

git remote set-url origin "git@github.com:jahed/agility.git"
git config --global user.name ${GH_COMMIT_AUTHOR}
git config --global user.email ${GH_COMMIT_EMAIL}

bundle exec rake deploy
