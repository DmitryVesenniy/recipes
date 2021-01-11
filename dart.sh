sudo apt-get update
sudo apt-get install apt-transport-https
sudo sh -c 'wget -qO- https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -'
sudo sh -c 'wget -qO- https://storage.googleapis.com/download.dartlang.org/linux/debian/dart_stable.list > /etc/apt/sources.list.d/dart_stable.list'

sudo apt-get update
sudo apt-get install dart

export PATH="$PATH:/usr/lib/dart/bin"
echo 'export PATH="$PATH:/usr/lib/dart/bin"' >> ~/.profile

sudo ln -s /usr/lib/dart/bin/pub /usr/bin/pub

# download dart-sdk from /usr/lib/dart-sdk
export PATH="$PATH:/usr/lib/dart-sdk/bin"
echo 'export PATH="$PATH:/usr/lib/dart-sdk/bin"' >> ~/.profile
source ~/.profile

git clone https://github.com/flutter/flutter.git
export PATH="$PATH:/media/jack/libs/FlutterSDK/flutter/bin"
echo 'export PATH="$PATH:/media/jack/libs/FlutterSDK/flutter/bin"' >> ~/.profile
flutter precache

flutter config --android-studio-dir="C:\Program Files\Android\Android Studio"
flutter doctor
