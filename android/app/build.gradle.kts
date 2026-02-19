import java.io.FileInputStream
import java.util.Properties

plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.yourcompany.znoona_game_app" // Change this
    compileSdk = 36
    
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }

    defaultConfig {
        applicationId = "com.yourcompany.znoona_game_app" // Change this
        minSdk = flutter.minSdkVersion
        targetSdk = 35
        versionCode = 1
        versionName = "1.0.0"
        
        multiDexEnabled = true
        
        // REMOVE any ndk.abiFilters from here if they exist
        // If you have something like this, REMOVE IT:
        // ndk {
        //     abiFilters 'armeabi-v7a', 'arm64-v8a', 'x86_64'
        // }
    }

    // Load keystore properties from file if it exists
    val keystorePropertiesFile = rootProject.file("key.properties")
    val keystoreProperties = Properties()
    if (keystorePropertiesFile.exists()) {
        keystoreProperties.load(FileInputStream(keystorePropertiesFile))
    }

    signingConfigs {
        create("release") {
            val keyAliasValue = System.getenv("KEY_ALIAS") 
                ?: keystoreProperties["keyAlias"] as String? 
                ?: project.findProperty("KEY_ALIAS") as String?
            
            val keyPasswordValue = System.getenv("KEY_PASSWORD") 
                ?: keystoreProperties["keyPassword"] as String? 
                ?: project.findProperty("KEY_PASSWORD") as String?
            
            val storeFileValue = System.getenv("STORE_FILE") 
                ?: keystoreProperties["storeFile"] as String? 
                ?: project.findProperty("STORE_FILE") as String?
            
            val storePasswordValue = System.getenv("STORE_PASSWORD") 
                ?: keystoreProperties["storePassword"] as String? 
                ?: project.findProperty("STORE_PASSWORD") as String?

            if (keyAliasValue != null && keyPasswordValue != null && 
                storeFileValue != null && storePasswordValue != null) {
                
                keyAlias = keyAliasValue
                keyPassword = keyPasswordValue
                storeFile = file(storeFileValue)
                storePassword = storePasswordValue
            }
        }
    }

    buildTypes {
        release {
            signingConfig = if (signingConfigs.findByName("release") != null) {
                signingConfigs.getByName("release")
            } else {
                signingConfigs.getByName("debug")
            }
            
            isMinifyEnabled = true
            isShrinkResources = true
            
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
            
            ndk {
                debugSymbolLevel = "FULL"
            }
        }
        
        debug {
            signingConfig = signingConfigs.getByName("debug")
            isMinifyEnabled = false
            applicationIdSuffix = ".debug"
            versionNameSuffix = "-debug"
        }
    }
    
    // For DEBUG builds, we don't need to split ABIs
    // You can keep this for RELEASE only or remove entirely for debug
    splits {
        abi {
            // Disable for debug builds
            isEnable = false
            reset()
            include("armeabi-v7a", "arm64-v8a", "x86_64")
            isUniversalApk = false
        }
    }
    
    // Bundle configuration for App Bundle (only affects release builds)
    bundle {
        language {
            enableSplit = true
        }
        density {
            enableSplit = true
        }
        abi {
            enableSplit = true
        }
    }
    
    // Packaging options
    packaging {
        resources {
            excludes += "/META-INF/{AL2.0,LGPL2.1}"
            excludes += "META-INF/versions/**"
            excludes += "kotlin/**"
            excludes += "**/*.kotlin_*"
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    implementation("androidx.multidex:multidex:2.0.1")
    implementation("androidx.core:core-ktx:1.12.0")
    implementation("org.jetbrains.kotlin:kotlin-stdlib:2.1.0")
}
