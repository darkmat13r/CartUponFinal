import UIKit
import Flutter
import GoogleMaps
@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        GMSServices.provideAPIKey("AIzaSyD00RiCdlFZyHG0yPYcUcKJo_Hqjq90QGg")
        GeneratedPluginRegistrant.register(with: self)
        //initialization code
        //set custom delegate for push handling, in our case AppDelegate
       // Pushwoosh.sharedInstance()?.delegate = self
        
        //register for push notifications
      // Pushwoosh.sharedInstance()?.registerForPushNotifications()
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    //handle token received from APNS
    /*override func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Pushwoosh.sharedInstance()?.handlePushRegistration(deviceToken)
    }
    
    //handle token receiving error
    override func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        Pushwoosh.sharedInstance()?.handlePushRegistrationFailure(error);
    }
    
    //this is for iOS < 10 and for silent push notifications
    
    
    //this event is fired when the push gets received
    func pushwoosh(_ pushwoosh: Pushwoosh!, onMessageReceived message: PWMessage!) {
        print("onMessageReceived: ", message.payload.description)
    }
    
    //this event is fired when a user taps the notification
    func pushwoosh(_ pushwoosh: Pushwoosh!, onMessageOpened message: PWMessage!) {
        print("onMessageOpened: ", message.payload.description)
    }*/
}
