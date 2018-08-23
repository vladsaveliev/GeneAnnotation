#!/bin/bash
# this script uses the ANACONDA_TOKEN env var. 
# to create a token:
# >>> anaconda login
# >>> anaconda auth -c -n travis --max-age 307584000 --url https://anaconda.org/USERNAME/PACKAGENAME --scopes "api:write api:read"
set -e
set -x

if [ -z $PACKAGE_NAME ] ; then
    echo 'PACKAGE_NAME environment variable must be specified' >&2
    exit 1
fi

if [ -z $ANACONDA_TOKEN ] ; then
    echo 'ANACONDA_TOKEN environment variable must be specified' >&2
    exit 1
fi

echo "Converting conda package..."
conda convert --platform all $HOME/miniconda/conda-bld/linux-64/${PACKAGENAME}-*.tar.bz2 --output-dir conda-bld/

echo "Deploying to Anaconda.org..."
anaconda -t ${ANACONDA_TOKEN} upload conda-bld/**/${PACKAGENAME}-*.tar.bz2

echo "Successfully deployed to Anaconda.org."
exit 0