//
//  AppDelegate.swift
//  goSellSDKExample
//
//  Copyright © 2018 Tap Payments. All rights reserved.
//

import class goSellSDK.goSellSDK
import class UIKit.UIApplication.UIApplication
import protocol UIKit.UIApplication.UIApplicationDelegate
import class UIKit.UIResponder.UIResponder
import class UIKit.UIWindow.UIWindow

@UIApplicationMain
internal class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    internal func applicationDidFinishLaunching(_ application: UIApplication) {
        
        goSellSDK.secretKey = "sk_test_IpaGWuwyK9nNSQX8Cb47l0kg" //+ "_zalupa"
    }
}
