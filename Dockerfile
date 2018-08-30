FROM openjdk:8-jdk

ENV SDK_URL="https://dl.google.com/android/repository/sdk-tools-linux-3859397.zip" \
    ANDROID_HOME="/android-sdk" \
    ANDROID_VERSION=27 \
    ANDROID_BUILD_TOOLS_VERSION=28.0.2

    ANDROID_COMPILE_SDK=27
    ANDROID_BUILD_TOOLS=27.0.3
    ANDROID_SDK_TOOLS=24.4.1


# Download Android SDK
RUN apt-get --quiet update --yes \
  && apt-get --quiet install --yes wget tar unzip lib32stdc++6 lib32z1 \
  && wget --quiet --output-document=android-sdk.tgz https://dl.google.com/android/android-sdk_r${ANDROID_SDK_TOOLS}-linux.tgz \
  && tar --extract --gzip --file=android-sdk.tgz \
  && echo y | android-sdk-linux/tools/android --silent update sdk --no-ui --all --filter android-${ANDROID_COMPILE_SDK} \
  && echo y | android-sdk-linux/tools/android --silent update sdk --no-ui --all --filter platform-tools \
  && echo y | android-sdk-linux/tools/android --silent update sdk --no-ui --all --filter build-tools-${ANDROID_BUILD_TOOLS} \
  && echo y | android-sdk-linux/tools/android --silent update sdk --no-ui --all --filter extra-android-m2repository \
  && echo y | android-sdk-linux/tools/android --silent update sdk --no-ui --all --filter extra-google-google_play_services \
  && echo y | android-sdk-linux/tools/android --silent update sdk --no-ui --all --filter extra-google-m2repository