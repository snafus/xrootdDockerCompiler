FROM centos:7



RUN yum update -y && yum install -y vim git rpm-build wget  

RUN yum --disablerepo=\* --enablerepo=base,updates groupinstall -y  "Development Tools"
RUN  yum install -y yum-plugin-priorities
RUN yum install -y  https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm

# Verify that /etc/yum.repos.d/epel.repo exists; the [epel] section should contain:
# The line enabled=1
# Either no priority setting, or a priority setting that is 99 or higher

RUN  yum install -y cmake3 krb5-devel readline-devel fuse-devel libxml2-devel zlib-devel ncurses-devel libcurl-devel libuuid-devel voms-devel libmacaroons-devel json-c-devel python2-devel python3-devel openssl-devel selinux-policy-devel graphviz systemd-devel

RUN yum install -y  xrootd xrootd-devel xerces-c
RUN wget https://repo.opensciencegrid.org/osg/upcoming/el7/release/x86_64/xrootd-cmstfc-1.5.2-6.osgup.el7.x86_64.rpm 
RUN rpm -ivh xrootd-cmstfc-1.5.2-6.osgup.el7.x86_64.rpm

COPY ceph.repo /etc/yum.repos.d/ceph.repo
RUN yum install -y  librados-devel libradosstriper-devel libradospp-devel librados2 libradosstriper1 


RUN mkdir -p ~/rpmbuild/{BUILD,BUILDROOT,RPMS,SOURCES,SPECS,SRPMS}

COPY docker_entryfile.sh .
CMD ./docker_entryfile.sh

