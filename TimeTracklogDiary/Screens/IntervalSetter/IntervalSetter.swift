//
//  IntervalSetter.swift
//  TimeTracklogDiary
//
//  Created by kassergey on 6/7/18.
//  Copyright © 2018 kassergeymac. All rights reserved.
//

import Cocoa

class IntervalSetter: NSViewController {
    
    @IBOutlet weak var tfWorkInterval: NSTextField!
    @IBOutlet weak var tfRestInterval: NSTextField!
    @IBOutlet weak var lblLeftTime: NSTextField!
    
    private var timer = Timer()
    
    private var workIntervalSeconds : Int?
    private var workIntervalSecondsLeft : Int?
    private var restIntervalSeconds : Int?
    private var restIntervalSecondsLeft : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tfWorkInterval.formatter = OnlyIntegerValueFormatter()
        self.tfRestInterval.formatter = OnlyIntegerValueFormatter()
        
        if (UserDefaults.standard.integer(forKey: Constants.UDWorkInterval) == 0) {
            self.workIntervalSeconds = Constants.defaultWorkIntervalSeconds
        } else {
            self.workIntervalSeconds =  UserDefaults.standard.integer(forKey: Constants.UDWorkInterval)
        }
        
        if (UserDefaults.standard.integer(forKey: Constants.UDRestInterval) == 0) {
            self.restIntervalSeconds = Constants.defaultRestIntervalSeconds
        } else {
            self.restIntervalSeconds =  UserDefaults.standard.integer(forKey: Constants.UDRestInterval)
        }
        
        self.tfWorkInterval.intValue = Int32(self.workIntervalSeconds!/Constants.secondsInMinute)
        self.tfRestInterval.intValue = Int32(self.restIntervalSeconds!/Constants.secondsInMinute)
        
        self.startWorkTimer()
    }
    
    func showNotificationWithTitle(_ title: String, informativeText: String) -> Void {
        let notification = NSUserNotification()
        notification.title = title
        notification.informativeText = informativeText
        notification.soundName = NSUserNotificationDefaultSoundName
        NSUserNotificationCenter.default.deliver(notification)
    }
    
    @IBAction func onBtnSetInterval(_ sender: Any) {
        self.workIntervalSeconds = Int(self.tfWorkInterval!.intValue) * Constants.secondsInMinute
        self.restIntervalSeconds = Int(self.tfRestInterval!.intValue) * Constants.secondsInMinute
        UserDefaults.standard.set(self.workIntervalSeconds, forKey: Constants.UDWorkInterval)
        UserDefaults.standard.set(self.restIntervalSeconds, forKey: Constants.UDRestInterval)
        self.startWorkTimer()
    }
    
    @IBAction func onBtnTerminate(_ sender: Any) {
        NSApplication.shared.terminate(sender)
    }
}

extension IntervalSetter {
    
    //work timer
    fileprivate func startWorkTimer() {
        self.workIntervalSecondsLeft = self.workIntervalSeconds
        self.timer = Timer.scheduledTimer(timeInterval: 1,
                                          target: self,
                                          selector: (#selector(onWorkTick)),
                                          userInfo: nil,
                                          repeats: true)
    }
    
    @objc
    func onWorkTick() {
        self.workIntervalSecondsLeft = self.workIntervalSecondsLeft!-1
        self.lblLeftTime.intValue = Int32(self.workIntervalSecondsLeft!)
        if(self.workIntervalSecondsLeft==0) {
            self.timer.invalidate()
            self.startRestTimer()
            self.showNotificationWithTitle(NSLocalizedString("Work notification title", comment: ""),
                                           informativeText: NSLocalizedString("Work notification text", comment: ""))
        }
    }
    
    //rest timer
    fileprivate func startRestTimer() {
        self.restIntervalSecondsLeft = self.restIntervalSeconds
        self.timer = Timer.scheduledTimer(timeInterval: 1,
                                          target: self,
                                          selector: (#selector(onRestTick)),
                                          userInfo: nil,
                                          repeats: true)
    }
    
    @objc
    func onRestTick() {
        self.restIntervalSecondsLeft = self.restIntervalSecondsLeft!-1
        self.lblLeftTime.intValue = Int32(self.restIntervalSecondsLeft!)
        if(self.restIntervalSecondsLeft==0) {
            self.timer.invalidate()
            self.startWorkTimer()
            self.showNotificationWithTitle(NSLocalizedString("Rest notification title", comment: ""),
                                           informativeText: NSLocalizedString("Rest notification text", comment: ""))
        }
    }
    
}
