//
//  RelamDB.swift
//  weather
//
//  Created by Mahmoud BEN AISSA on 14/10/2018.
//  Copyright © 2018 Mahmoud BEN AISSA. All rights reserved.
//

import Foundation
import  RealmSwift
class RealmDB: DatabaseInterface {
    
    let realm = try! Realm()
    
    func get<T>(predicate: String) -> T? {
        return Array(realm.objects(T.self as! (Object.Type)).filter(predicate)).first as? T
    }
    
    func save<T>(data: T) {
        try! realm.write {
            realm.add(data as! Object,update: true )
        }
    }
    
}
