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
    private var workIntervalSecondsRest : Int?
    private var restIntervalSeconds : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    func startTimer() {
        self.workIntervalSecondsRest = self.workIntervalSeconds
        self.timer = Timer.scheduledTimer(timeInterval: 1,
                                          target: self,
                                          selector: (#selector(onTick)),
                                          userInfo: nil,
                                          repeats: true)
    }
    
    @objc
    func onTick() {
        self.workIntervalSecondsRest = self.workIntervalSecondsRest!-1
        self.lblLeftTime.intValue = Int32(self.workIntervalSecondsRest!)
        if(self.workIntervalSecondsRest==0) {
            self.workIntervalSecondsRest = self.workIntervalSeconds
            self.showNotificationWithTitle("Rest time start", informativeText: "Please rest")
        }
    }
    
    func showNotificationWithTitle(_ title: String, informativeText: String) -> Void {
        let notification = NSUserNotification()
        notification.title = title
        notification.informativeText = informativeText
        notification.soundName = NSUserNotificationDefaultSoundName
        NSUserNotificationCenter.default.deliver(notification)
    }
    
    @IBAction func onBtnSetInterval(_ sender: Any) {
        self.workIntervalSeconds = Int(self.tfWorkInterval!.intValue)
        self.restIntervalSeconds = Int(self.tfRestInterval!.intValue)
        self.startTimer()
    }
    
    @IBAction func onBtnTerminate(_ sender: Any) {
        NSApplication.shared.terminate(sender)
    }
}
