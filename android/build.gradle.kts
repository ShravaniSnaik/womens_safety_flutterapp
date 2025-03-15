plugins {
    id("com.android.application") version "8.4.0" apply false
    id("dev.flutter.flutter-gradle-plugin") apply false
    id("org.gradle.kotlin.kotlin-dsl") version "4.4.0" apply false
    id("org.jetbrains.kotlin.android") version "1.9.23" apply false
}

allprojects {
    repositories {
        google()
        mavenCentral()
        maven { url = uri("https://storage.googleapis.com/download.flutter.io") } // Ensure Flutter repository is added
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

dependencies {
    classpath("com.android.tools.build:gradle:8.4.0") // Make sure this matches your Gradle version
    classpath("org.jetbrains.kotlin:kotlin-gradle-plugin:1.9.23")
    classpath("com.google.gms:google-services:4.4.2") // Ensure correct Google services version
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
