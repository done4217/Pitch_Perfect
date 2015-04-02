//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by Don Esry on 3/24/15.
//  Copyright (c) 2015 Don Esry. All rights reserved.
//

import Foundation

class RecordedAudio: NSObject{
    var filePathUrl: NSURL!
    var title: String!
    
    // trying to understand initiators better...
    override init() {
        self.title = "default"
        self.filePathUrl = NSURL.fileURLWithPath("default")
    }
    
}