# App "Mein Bildungscampus"
This is the official app of the Bildungscampus der Dieter Schwarz Stiftung in Heilbronn. The project aims to provide the opportunity to contribute in the development of the Bildungscampus App: Firstly to create new features making life easier on campus – and secondly to solve issues. Let's work together to make campus life easier for everyone!. 
The app was originally developed by camao-tec, but it is now open source, meaning that it can be developed by students for students. To keep your data safe, we only use the non-personalized data. 
For more information, see our Privacy Policy and Terms of Use and Code of Conduct.

You can find the app in the stores here:

&nbsp;&nbsp;[![Available on the App Store](https://cl.ly/WouG/Download_on_the_App_Store_Badge_US-UK_135x40.svg)](https://apps.apple.com/app/id1571668921)

<a href='https://play.google.com/store/apps/details?id=com.schwarz.bildungscampus.application'>
    <img alt='Available on the Google Play' src='https://play.google.com/intl/en_us/badges/images/generic/en_badge_web_generic.png' height='60px'/>
</a>


# Documentation

* [Install Flutter](https://flutter.dev/get-started/)
* [Flutter documentation](https://docs.flutter.dev/)
* [Contributing to Bildungs Campus App](https://github.com/camao-tec/bcapp/blob/main/CONTRIBUTING.md)

# How to build code

## Backend (mock service)
To start the local mock server you need to do the following:

1. Install [Docker Desktop](https://www.docker.com/get-started/)
2. Navigate to the `\api-schema` folder
3. Run the following command: `docker-compose up -d`
4. The Mock server will be running on the port `localhost:8080`. You also will have access to the Swagger UI from the following url: `localhost:8081/swagger`

## Flutter

### Installing flutter on your environment

Please follow the instructions on the flutter.dev page to configure your local system: [flutter quick start](https://docs.flutter.dev/get-started/install)

NOTE: If you are using the new Apple silicon (M1/M1Pro/M1Max or M2/M2Pro/M2Max). Be aware that you could have problems with compiling the app. Please follow the instructions which are shown in the logs.

Like:

    Error: To set up CocoaPods for ARM macOS, run: sudo gem uninstall ffi && sudo gem install ffi -- --enable-libffi-alloc

### Installing additional flutter plugins

Depending on the IDE which are you want to use please install following Flutter Intl plugins:
- [Android Studio & IntelliJ](https://docs.flutter.dev/get-started/install)
- [Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=localizely.flutter-intl)

#### Build flutter code

To build the code you need to the following steps:
1. Go to the file `bcapp\bildungscampus_app\lib\main.dart`
2. Check if you have configured the url to the backend server correctly (`apiGatewayUrl` property):
Depending for what platform you are implementing the settings need to be different.

For android it should be: `http://10.0.2.2:8080` (for standard google emulator)

For iOS it should be: `http://localhost:8080`

You probably also need to configure the Info.plist file:

    <key>NSAppTransportSecurity</key>
    <dict>
        <key>NSAllowsArbitraryLoads</key>
            <true/>
    </dict>      

3. Run following command: `flutter run --flavor dev` or use the Visual Studio Code `Run without debugging` option in the `run` tab