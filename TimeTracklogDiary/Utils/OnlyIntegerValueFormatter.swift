//
//  OnlyIntegerValueFormatter.swift
//  TimeTracklogDiary
//
//  Created by kassergey on 6/10/18.
//  Copyright © 2018 kassergeymac. All rights reserved.
//

//source:https://stackoverflow.com/questions/12161654/restrict-nstextfield-to-only-allow-numbers

import Cocoa

class OnlyIntegerValueFormatter: NumberFormatter {
    
    override func isPartialStringValid(_ partialString: String, newEditingString newString: AutoreleasingUnsafeMutablePointer<NSString?>?, errorDescription error: AutoreleasingUnsafeMutablePointer<NSString?>?) -> Bool {
        
        // Ability to reset your field (otherwise you can't delete the content)
        // You can check if the field is empty later
        if partialString.isEmpty {
            return true
        }
        
        // Optional: limit input length
        if (partialString.count>2) {
            return false
        }
        
        // Actual check
        return Int(partialString) != nil
    }
    
}
