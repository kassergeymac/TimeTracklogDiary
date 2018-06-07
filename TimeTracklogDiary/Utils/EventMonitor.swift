//
//  EventMonitor.swift
//  TimeTracklogDiary
//
//  Created by kassergey on 6/7/18.
//  Copyright © 2018 kassergeymac. All rights reserved.
//

//source: https://www.raywenderlich.com/165853/menus-popovers-menu-bar-apps-macos

import Cocoa

public class EventMonitor {
    private var monitor: Any?
    private let mask: NSEvent.EventTypeMask
    private let handler: (NSEvent?) -> Void
    
    public init(mask: NSEvent.EventTypeMask, handler: @escaping (NSEvent?) -> Void) {
        self.mask = mask
        self.handler = handler
    }
    
    deinit {
        self.stop()
    }
    
    public func start() {
        self.monitor = NSEvent.addGlobalMonitorForEvents(matching: self.mask, handler: self.handler)
    }
    
    public func stop() {
        if self.monitor != nil {
            NSEvent.removeMonitor(self.monitor!)
            self.monitor = nil
        }
    }
}
