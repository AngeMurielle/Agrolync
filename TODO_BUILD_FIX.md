# Build Fix TODO

## Issues
1. JVM target mismatch: `compileDebugJavaWithJavac` (17) vs `compileDebugKotlin` (1.8)
2. Duplicate blocks in `android/build.gradle.kts`
3. `google_api_headers` iOS warnings (non-fatal)

## Steps
- [ ] Update `android/gradle.properties` → java.version=17, remove kotlin.jvmTarget=1.8
- [ ] Update `android/app/build.gradle.kts` → JavaVersion.VERSION_17, jvmTarget="17"
- [ ] Clean up `android/build.gradle.kts` → remove duplicates, set jvmTarget="17"
- [ ] Run `flutter clean`
- [ ] Run `flutter run` to verify on TECNO BF7

