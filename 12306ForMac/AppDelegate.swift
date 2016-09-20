//
//  AppDelegate.swift
//  Train12306
//
//  Created by fancymax on 15/7/30.
//  Copyright (c) 2015年 fancy. All rights reserved.
//
import Fabric
import Crashlytics

import Cocoa

let logger: XCGLogger = {
    // Setup XCGLogger
    let log = XCGLogger.defaultInstance()
    let logPath: NSString = ("~/Desktop/12306ForMac_log.txt" as NSString).expandingTildeInPath as NSString
    log.xcodeColors = [
        .verbose: .lightGrey,
        .debug: .darkGrey,
        .info: .darkGreen,
        .warning: .orange,
        .error: XCGLogger.XcodeColor(fg: NSColor.red, bg: NSColor.white), // Optionally use an NSColor
        .severe: XCGLogger.XcodeColor(fg: (255, 255, 255), bg: (255, 0, 0)) // Optionally use RGB values directly
    ]
    log.setup(.debug, showThreadName: true, showLogLevel: true, showFileNames: true, showLineNumbers: true, writeToFile: logPath)
    
    return log
}()

let DidSendLoginMessageNotification = "com.12306.DidSendLoginMessageNotification"
let DidSendLogoutMessageNotification = "com.12306.DidSendLogoutMessageNotification"
let DidSendSubmitMessageNotification = "com.12306.DidSendSubmitMessageNotification"
let DidSendTrainFilterMessageNotification = "com.12306.DidSendTrainFilterMessageNotification"
let DidSendCheckPassengerMessageNotification = "com.12306.DidSendCheckPassengerMessageNotification"
let CanFilterTrainNotification = "com.12306.CanFilterTrainNotification"
let DidSendAutoLoginMessageNotification = "com.12306.DidSendAutoLoginMessageNotification"
let DidSendAutoSubmitMessageNotification = "com.12306.DidSendAutoSubmitMessageNotification"

@NSApplicationMain class AppDelegate: NSObject, NSApplicationDelegate {

    var mainController:MainWindowController?
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
    UserDefaults.standard.register(defaults: ["NSApplicationCrashOnExceptions":NSNumber(value: true as Bool)])
        
        Fabric.with([Crashlytics.self])
        
        let mainController = MainWindowController(windowNibName: "MainWindowController")
        mainController.showWindow(self)
        
        self.mainController = mainController
        
        logger.debug("application start")
        
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    func applicationShouldTerminateAfterLastWindowClosed(_ sender:NSApplication)->Bool {
        return true
    }
    
    


}

