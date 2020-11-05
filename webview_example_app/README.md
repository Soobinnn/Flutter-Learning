# webview


## Install
```
dependencies:
  webview_flutter: ^1.0.6
```

import
```
import 'package:webview_flutter/webview_flutter.dart';
```

## Setting

android/app/build.gradle
```
android {
    defaultConfig {
        // Required by the Flutter WebView plugin.
        minSdkVersion 19
    }
  }
```

/android/app/src/main/AndroidManifest.xml
```
<application
        android:name="io.flutter.app.FlutterApplication"
        android:label="flutterdemo"
        android:icon="@mipmap/ic_launcher"
        android:usesCleartextTraffic="true">     <--- 추가
```