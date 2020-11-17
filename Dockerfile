FROM openjdk:8-jdk

ENV ANDROID_COMPILE_SDK 29
ENV ANDROID_BUILD_TOOLS 29.0.3
ENV ANDROID_SDK_TOOLS 30.0.4
ENV ANDROID_HOME /android-sdk-linux

RUN apt-get --quiet update --yes >>log.txt && \
    apt-get --quiet install --yes wget tar unzip lib32stdc++6 lib32z1 ruby-dev make g++>>log.txt

RUN echo 'gem: --no-document' > /etc/gemrc

RUN mkdir cmdline-tools
WORKDIR cmdline-tools

RUN wget --quiet --output-document=android-sdk.zip https://dl.google.com/android/repository/commandlinetools-linux-6609375_latest.zip && \
    echo Extracting tools && \
    unzip android-sdk.zip && \
    rm android-sdk.zip

RUN yes | tools/bin/sdkmanager --sdk_root=$ANDROID_HOME --licenses
RUN tools/bin/sdkmanager --sdk_root=$ANDROID_HOME "platform-tools" "platforms;android-29"
RUN tools/bin/sdkmanager --sdk_root=$ANDROID_HOME "build-tools;${ANDROID_BUILD_TOOLS}"
RUN tools/bin/sdkmanager --sdk_root=$ANDROID_HOME "extras;android;m2repository"
RUN tools/bin/sdkmanager --sdk_root=$ANDROID_HOME "extras;google;google_play_services"
RUN tools/bin/sdkmanager --sdk_root=$ANDROID_HOME "extras;google;m2repository"
