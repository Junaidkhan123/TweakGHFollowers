//
//  AppDelegate.swift
//  SAMEABC
//
//  Created by Junaid Khan on 05/05/2025.
//

import UIKit
import SBTUITestTunnelServer

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var environment: [String: String] {
        return ProcessInfo.processInfo.environment
    }
    
    var isUITest: Bool {
        return environment["uiTest"] != nil
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        #if DEBUG
        setupSoftwareKeyboard()
        if isUITest {
            SBTUITestTunnelServer.takeOff()
            UIView.setAnimationsEnabled(false)
        }
        #endif
        return true
    }

    private func setupSoftwareKeyboard() {
#if targetEnvironment(simulator)
        // Disable hardware keyboards.
        let setHardwareLayout = NSSelectorFromString("setHardwareLayout:")
        UITextInputMode.activeInputModes
        // Filter `UIKeyboardInputMode`s.
            .filter({ $0.responds(to: setHardwareLayout) })
            .forEach { $0.perform(setHardwareLayout, with: nil) }
#endif
    }
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

