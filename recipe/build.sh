set -x

# Get an updated config.sub and config.guess
cp $BUILD_PREFIX/share/gnuconfig/config.* ./

if [[ "$CONDA_BUILD_CROSS_COMPILATION" == 1 ]]; then
    export ac_cv_path_PYTHON=$BUILD_PREFIX/bin/python
else
    # We need to explicitly set the python path
    export ac_cv_path_PYTHON=$PREFIX/bin/python
fi

rm -f src/.depend
rm -f libsrc_c/.depend

./configure --prefix=$PREFIX --with-netcdf4=$PREFIX

make
make check
make install

# Remove $PREFIX/bin .py files which aren't needed.
rm -f $PREFIX/*.py
