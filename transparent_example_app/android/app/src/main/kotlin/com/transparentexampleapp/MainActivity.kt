package com.transparentexampleapp

import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant
import android.os.Bundle

class MainActivity: FlutterActivity() {
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine);
    }
    override fun onCreate(savedInstanceState: android.os.Bundle?) {
        intent.putExtra("background_mode","transparent")
        super.onCreate(savedInstanceState)
    }
}
