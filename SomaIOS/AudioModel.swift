//
//  AudioModel.swift
//  SomaIOS
//
//  Created by ali ziwa on 9/17/16.
//  Copyright © 2016 ali ziwa. All rights reserved.
//

import UIKit
import RealmSwift

class AudioModel: Object {

    dynamic var title = ""
    dynamic var author = ""
    dynamic var level = ""
    dynamic var summary = ""
    dynamic var filename = ""
    
    override static func primaryKey() -> String? {
        return "filename"
    }
}
