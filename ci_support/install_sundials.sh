#!/bin/sh
set -ex

SUNDIALS=sundials-"${SUNDIALS_VERSION:-2.7.0}"
SUNDIALS_FILE=$SUNDIALS.tar.gz
SUNDIALS_URL=http://computation.llnl.gov/projects/sundials-suite-nonlinear-differential-algebraic-equation-solvers/download/$SUNDIALS_FILE
PRECISION="${SUNDIALS_PRECISION:-double}"

wget "$SUNDIALS_URL"

tar -xzvf "$SUNDIALS_FILE"

mkdir sundials_build


# ARKODE and examples are disabled as they does not support multiple precisions
# (should be fixed in the 3.0 release)
cd sundials_build &&
    cmake -DCMAKE_INSTALL_PREFIX=$SUNDIALS_DIR -DLAPACK_ENABLE=ON -DSUNDIALS_PRECISION="$PRECISION" -DBUILD_ARKODE:BOOL=OFF -DEXAMPLES_ENABLE:BOOL=OFF -DEXAMPLES_INSTALL:BOOL=OFF ../$SUNDIALS &&
    make && make install
