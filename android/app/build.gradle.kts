

plugins {
    id("com.android.application")
    id("kotlin-android") // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
    id("com.google.gms.google-services") // Apply Google Services plugin here
    id("org.jetbrains.kotlin.android")
}


android {
    
    defaultConfig {
        minSdkVersion flutter.minSdkVersion  // Set to at least 19 (or higher if needed)
        targetSdkVersion 33 // Match latest stable Android version
    
}
    namespace = "com.example.flutter_demo"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = "11"
    }

    java {
    toolchain {
        languageVersion.set(JavaLanguageVersion.of(11))
    }
}
buildscript {
    ext.kotlin_version = '1.5.0' // or the latest version that matches your Gradle version
}
    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.example.flutter_demo"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    implementation("com.google.firebase:firebase-auth-ktx:22.1.0") // Firebase Authentication
    implementation("com.google.firebase:firebase-firestore-ktx:24.8.1") // Firestore
    implementation("com.google.firebase:firebase-storage-ktx:20.3.0") // Firebase Storage
}
