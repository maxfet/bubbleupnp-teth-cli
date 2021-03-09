# Tethering Client for BubbleUPnP server
# 
FROM arm32v7/alpine
LABEL   maintainer="maxfet"
# BubbleUPnP server connection parameter
# default port for https connection is 58051
#
# bubbleUPnP environment variables default values
ENV BBSRV_IP=localhost
ENV BBSRV_PORT=58001
ENV LOGIN=root
ENV PASS=pwd1
#
# java environment variables
ENV JAVA_HOME=/usr/lib/jvm/default-jvm
ENV PATH=$PATH:$JAVA_HOME/jre/bin:$JAVA_HOME/bin 
ENV LANG=C.UTF-8
#
#
# install Java jre 8
RUN apk update
RUN apk add -l openjdk8-jre-lib openjdk8-jre-base
#
# install utility
RUN apk -l curl
#
#
# download and install BubbleUPnP Tether Client
RUN mkdir /usr/local/bubbleUPnP
RUN curl -O https://bubblesoftapps.com/bubbleupnptetherclient/BubbleUPnPTetherClient-0.9.2.zip
RUN unzip -o BubbleUPnPTetherClient-0.9.2.zip  *.jar *.sh *.txt -d /usr/local/bubbleUPnP
RUN rm BubbleUPnPTetherClient-0.9.2.zip
WORKDIR /usr/local/bubbleUPnP
RUN chmod +x launch.sh
#
#
#
EXPOSE  1900/udp 2869/udp 5001
ENTRYPOINT ["./launch.sh"]
CMD ["-connect", "https://$BBSRV_IP:$BBSRV_PORT", \
     "-login", "$LOGIN", "-password", "$PASS"]
