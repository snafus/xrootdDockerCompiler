cd /xrootd/packaging && rm -f xrootd*
./makesrpm.sh
rpm2cpio xrootd-*.src.rpm | cpio -imdv --no-absolute-filenames
cp xrootd.tar.gz ~/rpmbuild/SOURCES/
sed -i '1s/^/%define _with_ceph11 1\n/' xrootd.spec
sed -i '1s/^/%define _with_ceph 1\n/' xrootd.spec
rpmbuild    -ba xrootd.spec
cp ~/rpmbuild/RPMS/*/* /RPMS/.

