//
//  memoDataNodel.swift
//  test3
//
//  Created by 小林優斗 on 2022/01/07.
//

import Foundation
import RealmSwift

class memoDataModel: Object {
    
    @objc dynamic var context: String = ""
    
    @objc dynamic var date: String = ""
}
