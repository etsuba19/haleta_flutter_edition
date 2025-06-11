@echo off
echo Deleting build.gradle.kts, app/build.gradle.kts, and settings.gradle.kts...
del /f build.gradle.kts
del /f app\build.gradle.kts
del /f settings.gradle.kts

echo Cleaning Gradle cache...
rmdir /s /q %USERPROFILE%\.gradle\caches\transforms-3
rmdir /s /q %USERPROFILE%\.gradle\caches\build-cache-1

echo Running Gradle clean...
call gradlew clean

echo Running Gradle build...
call gradlew build

echo Done! 