//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by Don Esry on 3/24/15.
//  Copyright (c) 2015 Don Esry. All rights reserved.
//

import Foundation

// I'm not sure I really understand this initializer but it is working
// and I think it is done correctly now...
class RecordedAudio: NSObject{
    var title: String!
    var filePathUrl: NSURL!

    init(filePathUrl: NSURL, title: String) {
        self.filePathUrl = filePathUrl
        self.title = title
    }    
}