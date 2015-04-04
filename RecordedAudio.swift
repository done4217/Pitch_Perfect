//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by Don Esry on 3/24/15.
//  Copyright (c) 2015 Don Esry. All rights reserved.
//

import Foundation

// I'm not sure if this is correct or not but it seems to work
class RecordedAudio {
    var title: String!
    var filePathUrl: NSURL!
    
    // trying to understand initiators better...
    init() {
        self.title = "default"
        self.filePathUrl = NSURL.fileURLWithPath("default")
    }
    
}