#!/bin/bash
echo "distclean Buildroot 2"
cd buildroot || { echo "Not Found BuildRoot Directory"; exit 1; }
make distclean
echo "Buildroot cleaned."

