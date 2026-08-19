plugins {
    id("com.android.application")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.template.app"
    // flutter_secure_storage 11+가 compileSdk 37을 요구한다 (Flutter 기본값 36).
    compileSdk = 37
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.template.app"
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

    // flavor별 resValue(app_name) 사용을 위해 필요 (AGP 8+는 기본 비활성)
    buildFeatures {
        resValues = true
    }

    // dev/stg/prod flavor. 한 기기에 세 flavor를 동시에 설치할 수 있도록
    // applicationId suffix와 앱 이름을 분리한다.
    // 실행: flutter run --flavor dev -t lib/main_dev.dart
    flavorDimensions += "env"
    productFlavors {
        create("dev") {
            dimension = "env"
            applicationIdSuffix = ".dev"
            resValue("string", "app_name", "App DEV")
        }
        create("stg") {
            dimension = "env"
            applicationIdSuffix = ".stg"
            resValue("string", "app_name", "App STG")
        }
        create("prod") {
            dimension = "env"
            resValue("string", "app_name", "App")
        }
    }
}

kotlin {
    compilerOptions {
        jvmTarget = org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17
    }
}

flutter {
    source = "../.."
}
