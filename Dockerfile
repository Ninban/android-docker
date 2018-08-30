FROM openjdk:8-jdk

RUN apt-get --quiet update --yes \
    && apt-get --quiet install --yes wget tar unzip lib32stdc++6 lib32z1 \
    && wget --quiet --output-document=android-sdk.zip https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip \
    && unzip android-sdk.zip -d android-sdk-linux

RUN echo y | android-sdk-linux/tools/bin/sdkmanager update sdk --no-ui --all --filter android-27

RUN echo y | android-sdk-linux/tools/android --silent update sdk --no-ui --all --filter platform-tools

RUN echo y | android-sdk-linux/tools/android --silent update sdk --no-ui --all --filter build-tools-27.0.3

RUN echo y | android-sdk-linux/tools/android --silent update sdk --no-ui --all --filter extra-android-m2repository

RUN echo y | android-sdk-linux/tools/android --silent update sdk --no-ui --all --filter extra-google-google_play_services

RUN echo y | android-sdk-linux/tools/android --silent update sdk --no-ui --all --filter extra-google-m2repository

RUN export ANDROID_HOME=$PWD/android-sdk-linux \
    && export PATH=$PATH:$PWD/android-sdk-linux/platform-tools/ \
    && export GRADLE_USER_HOME=$PWD/.gradle