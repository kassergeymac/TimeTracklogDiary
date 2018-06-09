//
//  Constants.swift
//  TimeTracklogDiary
//
//  Created by kassergey on 6/9/18.
//  Copyright © 2018 kassergeymac. All rights reserved.
//

import Cocoa

class Constants {
    
    //default values
    static let secondsInMinute = 60
    static let defaultWorkIntervalSeconds = 45 * Constants.secondsInMinute
    static let defaultRestIntervalSeconds = 15 * Constants.secondsInMinute
    
    //user defaults
    static let UDWorkInterval = "WorkInterval"
    static let UDRestInterval = "RestInterval"

}
