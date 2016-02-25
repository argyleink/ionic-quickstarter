FROM phusion/baseimage:latest

MAINTAINER aegaas [at] deloitte [dot] com

CMD ["/sbin/my_init"]

# Install basics 
RUN apt-get update &&  \
    apt-get install -y git wget curl && \
    apt-get clean

RUN curl -sL https://deb.nodesource.com/setup_5.x | bash -

RUN apt-get update &&  \
    apt-get install -y nodejs build-essential && \
    ln -s /usr/bin/nodejs /usr/local/bin/node && \
    apt-get clean

# dept for phantomjs
RUN apt-get install libfontconfig -y

COPY tools /opt/tools

# Install npm packages

ENV NODE_PATH /tmp/node_modules
RUN echo NODE_PATH=\"$NODE_PATH\" >> /etc/environment

RUN npm install -g cordova ionic
RUN npm install -g grunt-cli
RUN npm install -g gulp
RUN npm install -g bower
RUN npm install -g gulp-sass
RUN npm install -g phantomjs


# Expose port: web (8100), livereload (35729)
EXPOSE 8100 35729


#########ANDROID
#########JAVA
########
######### ENV DEBIAN_FRONTEND noninteractive
########RUN dpkg-reconfigure debconf -f noninteractive
########
######### install python-software-properties (so you can do add-apt-repository)
########RUN apt-get update && apt-get install -y -q python-software-properties software-properties-common
########
######### install oracle java from PPA
######### RUN add-apt-repository ppa:webupd8team/java -y
########RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
#########echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections
######### RUN apt-get update && apt-get -y install oracle-java7-installer
########
########RUN echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu precise main" | tee /etc/apt/sources.list.d/webupd8team-java.list
########RUN echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu precise main" | tee -a /etc/apt/sources.list.d/webupd8team-java.list
########RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886
########RUN apt-get update &&  \
########    apt-get install -y oracle-java8-installer
########
#########ANDROID STUFF
########RUN dpkg --add-architecture i386 && apt-get update && apt-get install -y --force-yes expect ant wget libc6-i386 lib32stdc++6 lib32gcc1 lib32ncurses5 lib32z1 qemu-kvm kmod
########
######### Install Android SDK
########RUN cd /opt && wget --output-document=android-sdk.tgz --quiet http://dl.google.com/android/android-sdk_r24.0.2-linux.tgz && tar xzf android-sdk.tgz && rm -f android-sdk.tgz
########
######### Setup environment
########ENV ANDROID_HOME /opt/android-sdk-linux
########ENV PATH ${PATH}:${ANDROID_HOME}/tools:${ANDROID_HOME}/platform-tools
########
######### Install sdk elements
########ENV PATH ${PATH}:/opt/tools
########
########RUN echo ANDROID_HOME="${ANDROID_HOME}" >> /etc/environment
########
########RUN ["/opt/tools/android-accept-licenses.sh", "android update sdk --all --no-ui --filter platform-tools,tools,build-tools-21.1.2,android-19,addon-google_apis_x86-google-19,extra-android-support,extra-android-m2repository,extra-google-m2repository,sys-img-x86-android-21"]

#setup app
ENV APP_HOME /MyApp

WORKDIR $APP_HOME

# save to environment
ENV PATH $APP_HOME/node_modules/.bin:${PATH}
RUN echo PATH=\"$PATH\" >> /etc/environment

# help from http://bitjudo.com/blog/2014/03/13/building-efficient-dockerfiles-node-dot-js/
ADD package.json /tmp/package.json
RUN cd /tmp && npm install
RUN mkdir -p $APP_HOME/node_modules && cp -R /tmp/node_modules $APP_HOME

ADD ./bower.json $APP_HOME/
RUN bower install --allow-root

ADD . $APP_HOME/


CMD ["ionic", "serve", "--all", "--port", "8100", "--livereload", "--livereload-port", "35729", "--nobrowser", "--consolelogs"]
