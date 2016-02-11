Installation and running locally

IOS:
in order to run locally, the ios project should
Clone this repo and the ServiceSkeds-iOS repo. To make things easier, have each repo as sybling folders.

```bash
cd ServiceSkeds-iOS
xcodebuild -target "skeds Universal-cal" CODE_SIGN_IDENTITY="iPhone Developer: Mark O'Shea (PSBB9B4M36)"  CONFIGURATION=debug CONFIGURATION_BUILD_DIR=build -sdk iphonesimulator
```

Android:
in order to run locally, the Android APK should be built from the repo
Android APK is built using ANT. TO build with ant, first a build.xml file must exist.

```bash
cd ServiceSkeds-AndroidOS/Skeds-Android-Phone-Business/
android update project --path . -s
OR
android update project --path . -s -t 2
```

The android update command may ask to supply a target, if this happens use Google API 15 as a target.
To get the target number:

```bash
android list targets
```

Then supply the correct target number to the update project command

```bash
cd ServiceSkeds-AndroidOS/Skeds-Android-Phone-Business/
android update project --path . -s -t 1
```

This command will create and setup build.xml and a local properties file if necessary.
To build the APK

```bash
ant debug
```

Setting up the test framework:
install ruby 2.0

```bash
gem install bundler
cd skeds-qa-mobile
bundle install # this will install all necessary gems. They are listed in the Gemfile
```

To run the test suites
IOS:

```bash
USER=picadilly PASS=123456 MUT=IOS SDK_VERSION=7.0-64 PROJECT_DIR="../ServiceSkeds-iOS" APP_BUNDLE_PATH="../ServiceSkeds-iOS/build/FieldLocate.app" BUNDLE_ID="com.skeds.SkedsMobile" cucumber features/
```

Android:

```bash
USER=picadilly PASS=123456 MUT=AND calabash-android run *.apk features/
```

There should only be one APK file in this folder.
Also, the APK file needs to be in the skeds-qa-mobile directory, as there is a bug where if the apk is in a directory outside the folder, then
all files from that folder will be included in the project at runtime.
