//
//  Notes.swift
//  MakeSchoolNotes
//
//  Created by Lakshmi on 12/3/16.
//  Copyright © 2016 MakeSchool. All rights reserved.
//

import Foundation
import RealmSwift

class Note: Object {
    dynamic var title = ""
    dynamic var content = ""
    dynamic var modificationTime = NSDate()
}