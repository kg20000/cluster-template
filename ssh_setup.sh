#!/bin/bash
ssh-keyscan -H 192.168.1.1 >> ~/.ssh/known_hosts
ssh 192.168.1.1 -f 'sleep 5'
ssh-keyscan -H 192.168.1.2 >> ~/.ssh/known_hosts
ssh 192.168.1.2 -f 'sleep 5'
ssh-keyscan -H 192.168.1.3 >> ~/.ssh/known_hosts
