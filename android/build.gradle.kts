allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
subprojects {
    project.evaluationDependsOn(":app")
}

plugins {
    id("com.android.application") version "8.4.0" apply false // Specify version here
    id("dev.flutter.flutter-gradle-plugin") version "3.29.0" apply false
    id("org.gradle.kotlin.kotlin-dsl") version  "4.4.0" apply false
     id("org.jetbrains.kotlin.android") version "1.9.23" apply false
}
android {
    compileSdk = 34  // Add compile SDK version
    defaultConfig {
        minSdk = 21
        targetSdk = 34
    }

    java {
        toolchain {
            languageVersion.set(JavaLanguageVersion.of(11))
        }
    }
}

dependencies {
        
    classpath("com.android.tools.build:gradle:8.4.0") // Match your Gradle version
    classpath("org.jetbrains.kotlin:kotlin-gradle-plugin:1.9.23")
    classpath ('com.google.gms:google-services:4.4.2')
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}