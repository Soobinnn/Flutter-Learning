package com.transparentexample

import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant
import android.osBundle

class MainActivity: FlutterActivity() {
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        GeneratePluginRegistrant.registerWith(flutterEngine);
    }

    override fun onCreate(savedInstanceState: android.os.Bundle?) {
        intent.putExtra("background_mode","transparent")
        super.onCreate(savedInstanceState)
    }
}

