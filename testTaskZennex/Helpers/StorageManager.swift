//
//  StorageManager.swift
//  testTaskZennex
//
//  Created by Radmir Dzhurabaev on 26.01.2020.
//  Copyright © 2020 Radmir Dzhurabaev. All rights reserved.
//

import RealmSwift

let realm = try! Realm()

class StorageManager {
    
    static func saveObject (_ workers: Workers) {
        
        try! realm.write {
            realm.add(workers)
        }
    }
    
    static func deliteObject(_ workers: Workers) {
        
        try! realm.write {
            realm.delete(workers)
        }
    }
}
