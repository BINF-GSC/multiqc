FROM binfgsc/base-make:latest as base-make

################## MAINTAINER ######################
LABEL maintainer.name="William Hargreaves"
LABEL maintainer.email="whargrea@uoguelph.ca"

################## INSTALLATION ######################
RUN wget -O /opt/get-pip.py https://bootstrap.pypa.io/get-pip.py && \
    sudo python /opt/get-pip.py && \
    rm /opt/get-pip.py && \
    sudo pip install git+https://github.com/ewels/MultiQC.git

FROM binfgsc/fastqc:latest

COPY --from=base-make /usr/bin/multiqc /usr/bin/multiqc

RUN sudo apk --no-cache add python && \
    wget -O /opt/get-pip.py https://bootstrap.pypa.io/get-pip.py && \
    sudo python /opt/get-pip.py && \
    rm /opt/get-pip.py

COPY --from=base-make /usr/lib/python2.7/site-packages /usr/lib/python2.7/site-packages