import UIKit
import Flutter

/*
import AEPCore
import AEPEdge
import AEPEdgeIdentity
import AEPEdgeConsent
import AEPUserProfile
import AEPIdentity
import AEPLifecycle
import AEPServices
*/

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)

    
    //MobileCore.setWrapperType(.flutter)
    //MobileCore.setLogLevel(.debug)
    //let envFileId = "5e52683bb000/eb8a5cfa2988/launch-7becf70dc541"
    //5e52683bb000/eb8a5cfa2988/launch-7becf70dc541
    //5e52683bb000/eb8a5cfa2988/launch-fb3da957b1d4-dev

    //let appState = application.applicationState

    /*let extensions = [
          AEPEdgeIdentity.Identity.self,
          AEPIdentity.Identity.self,
          Consent.self,
          Edge.self,
          //Assurance.self,
          UserProfile.self,
          Lifecycle.self,
        ]
    
    MobileCore.registerExtensions(extensions, {
      MobileCore.configureWith(appId: envFileId)

      if appState != .background {
        MobileCore.lifecycleStart(additionalContextData: nil)
      } 
    })*/

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
