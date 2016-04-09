//
//  AppDelegate.swift
//  swiftTest
//
//  Created by Mr_zhaohy on 16/3/30.
//  Copyright © 2016年 Mr_zhaohy. All rights reserved.
//

import UIKit

    var shortItems = NSMutableArray()
    var use_array = NSMutableArray()
    var no_use_array = NSMutableArray()
    let isClose:Bool = NSUserDefaults.standardUserDefaults().boolForKey("isClose")
    let count = 10

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        var obj =  NSUserDefaults.standardUserDefaults().objectForKey("use")
        if obj != nil
        {
            use_array = NSMutableArray(array: obj as! NSArray)
        }
        
        obj =  NSUserDefaults.standardUserDefaults().objectForKey("no_use")
        if obj != nil
        {
           no_use_array = NSMutableArray(array: obj as! NSArray)
        }
        
        for var i:NSInteger = 0 ;i < count;i++
        {
            let shortItem = UIApplicationShortcutItem(type: String(i), localizedTitle:String(format:"标题%d",i), localizedSubtitle: String(i), icon: UIApplicationShortcutIcon(type: UIApplicationShortcutIconType.Location), userInfo: nil)
            shortItems.addObject(shortItem)
            
            if isClose == false && no_use_array.count < count-4
            {
                if i < 4
                {
                   use_array.addObject(String(i))
                }
                else
                {
                    no_use_array.addObject(String(i))
                }
            }
        }

        NSUserDefaults.standardUserDefaults().setObject(use_array, forKey: "use")
        NSUserDefaults.standardUserDefaults().setObject(no_use_array, forKey: "no_use")

        let array = NSMutableArray()
        for index in use_array
        {
            array.addObject(shortItems[index.integerValue])
        }
        
        UIApplication.sharedApplication().shortcutItems = array as? [UIApplicationShortcutItem]
        
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    @available(iOS 9.0, *)
    func application(application: UIApplication, performActionForShortcutItem shortcutItem: UIApplicationShortcutItem, completionHandler: (Bool) -> Void)
    {
        print("点击了",shortcutItem.localizedTitle,"type:",shortcutItem.type)
    }

}

