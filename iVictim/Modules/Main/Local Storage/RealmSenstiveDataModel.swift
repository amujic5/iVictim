//
//  RealmSenstiveDataModel.swift
//  iVictim
//
//  Created by Azzaro Mujic on 01/06/16.
//
//

import UIKit
import RealmSwift

final class RealmSensitiveDataModel: Object {
    
    dynamic var key: String = ""
    dynamic var data: String = ""
    
    func updateKey(key: String) {
        let realm = try! Realm()
        realm.beginWrite()
        
        self.key = key
        
        try! realm.commitWrite()
    }
    
    func updateData(data: String) {
        let realm = try! Realm()
        realm.beginWrite()
        
        self.data = data
        
        try! realm.commitWrite()
    }
    
    func saveObject() {
        let realm = try! Realm()
        realm.beginWrite()
        
        try! realm.write({ () -> Void in
            realm.add(self)
        })
        
        try! realm.commitWrite()
    }
    
    static func objectForKey(key: String) -> RealmSensitiveDataModel? {
        let realm = try! Realm()
        let realmObject =  realm.objectForPrimaryKey(RealmSensitiveDataModel.self, key: key)
        
        return realmObject
    }
    
    override static func primaryKey() -> String {
        return "key"
    }
}