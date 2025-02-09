#!/bin/bash
echo "distclean Buildroot"
cd buildroot || { echo "Not Found BuildRoot Directory"; exit 1; }
make distclean
echo "Buildroot cleaned."

