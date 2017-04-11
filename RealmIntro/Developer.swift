//
//  Developer.swift
//  RealmIntro
//
//  Created by Sujan Vaidya on 4/11/17.
//  Copyright © 2017 Sujan Vaidya. All rights reserved.
//

import Foundation
import RealmSwift

class Developer: Object {
  dynamic var id: Int = 0
  dynamic var name: String = ""
  dynamic var position: String = ""
  dynamic var workingSince: Int = 0

  public override static func primaryKey() -> String? {
    return "id"
  }
}
