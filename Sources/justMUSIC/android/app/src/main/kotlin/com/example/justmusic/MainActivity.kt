package com.example.justmusic
import android.os.Bundle
import com.google.android.gms.ads.MobileAds
import io.flutter.embedding.android.FlutterActivity

class MainActivity: FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        MobileAds.initialize(this)
    }

}
