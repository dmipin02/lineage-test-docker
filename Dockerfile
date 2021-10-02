FROM ubuntu:14.04

ARG home=/home/droid
COPY buildroot/.profile /tmp/profileconcat
COPY buildroot/.bashrc /tmp/bashrcconcat

RUN apt update && \
    apt -y install bc bison build-essential ccache curl flex g++-multilib gcc-multilib git zip && \
    apt -y install gnupg gperf imagemagick lib32ncurses5-dev lib32readline-dev lib32z1-dev && \
    apt -y install liblz4-tool libncurses5 libncurses5-dev libsdl1.2-dev libssl-dev libxml2 && \
    apt -y install libxml2-utils lzop pngcrush rsync schedtool squashfs-tools xsltproc zlib1g-dev && \
    apt -y install python3.9 python3-pip

# For Ubuntu 14.04 only
RUN apt -y install libwxgtk2.8-dev openjdk-7-jdk

RUN useradd -m -s /bin/sh droid

USER droid

RUN mkdir -p $home/bin && mkdir -p $home/android/lineage && \
    curl https://storage.googleapis.com/git-repo-downloads/repo > $home/bin/repo && \
    chmod a+x $home/bin/repo && chown droid:droid $home/bin/repo
    
RUN cp $home/.profile /tmp/profileorig && \
    cp $home/.bashrc /tmp/bashrcorig && \
    cat /tmp/profileorig /tmp/profileconcat > $home/.profile && \
    cat /tmp/bashrcorig /tmp/bashrcconcat > $home/.bashrc

RUN cd $home/android/lineage

ENTRYPOINT [ "/bin/bash" ]