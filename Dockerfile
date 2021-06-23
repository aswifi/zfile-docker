# FROM lsiobase/alpine:3.14

# ARG ZFILE_VERSION=3.1

# ENV PUID=1000
# ENV PGID=1000
# ENV TZ="Asia/Shanghai"

# LABEL MAINTAINER="aswifi"

# RUN \
#     echo ">>>>>> update dependencies <<<<<<" \
#     && apk update && apk add tzdata openjdk8 \
#     && echo ">>>>>> set up timezone <<<<<<" \
#     && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
#     && echo ${TZ} > /etc/timezone \
#     && apk del tzdata \
#     && echo ">>>>>> get zfile from github <<<<<<" \
#     && wget -O zfile.jar https://github.com/zhaojun1998/zfile/releases/download/${ZFILE_VERSION}/zfile-${ZFILE_VERSION}.jar

# VOLUME ["/zfile", "/root/.zfile-new"]

# EXPOSE 8080

# ENTRYPOINT java -Xms10m -Xmx300m -Djava.security.egd=file:/dev/./urandom -jar zfile.jar

FROM stilleshan/alpine-openjdk-8-headless:2021-06-11
MAINTAINER Aswifi <none>

ENV VERSION 3.1

WORKDIR /root

RUN wget https://github.com/zhaojun1998/zfile/releases/download/${VERSION}/zfile-${VERSION}.war \
    && mkdir zfile && unzip zfile-${VERSION}.war -d zfile && rm -rf zfile-${VERSION}.war \
    && chmod +x ~/zfile/bin/*.sh

EXPOSE 8080

CMD sh ./zfile/bin/start.sh && tail -f /dev/null
