export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/platform-tools

tns device
tns run android --device <device_number>

## Exception in thread "main" javax.net.ssl.SSLException: java.lang.RuntimeException: Unexpected error: 
  java.security.InvalidAlgorithmParameterException: the trustAnchors parameter must be non-empty

  Решение:
        sudo apt-get install ca-certificates-java
        sudo update-ca-certificates -f
