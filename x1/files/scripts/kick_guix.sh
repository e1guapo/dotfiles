#!/bin/bash
sudo mount -o remount,rw /gnu/store
sudo restorecon -R /gnu /var/guix
sudo systemctl restart guix-daemon
