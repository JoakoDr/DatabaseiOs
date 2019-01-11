//
//  GroupRepository.swift
//  DatabaseSwift
//
//  Created by JOAQUIN DIAZ RAMIREZ on 11/1/19.
//  Copyright © 2019 JOAQUIN DIAZ RAMIREZ. All rights reserved.
//

import Foundation
import RealmSwift

class GroupRepository: NSObject {
    
    func getAll() -> [Group] {
        var groups : [Group] = []
        do {
            let entities = try Realm().objects(GroupEntity.self).sorted(byKeyPath: "name", ascending: true)
            for entity in entities {
                let model = entity.groupModel()
                groups.append(model)
            }
        }
        catch let error as NSError {
            print("Error en el getAll Tasks:", error.description)
        }
        return groups
    }
    func get(identifier: String) -> Group? {
        
        do{
            let realm = try Realm()
            if let entity = realm.objects(GroupEntity.self).filter("id == %@",identifier).first{
                let model = entity.groupModel()
                return model
            }
        }
        catch {
            return nil
        }
        return nil
    }
    func create(a: Group) -> Bool {
        do {
            let realm = try Realm()
            let entities = GroupEntity(group: a)
            try realm.write {
                realm.add(entities,update: true)
            }
        }
        catch {
            return false
        }
        return true
    }
    func update(a: Group) -> Bool {
        
        return create(a: a)
    }
    
    func delete(a: Group) -> Bool {
        do {
            let realm = try Realm()
            try realm.write {
                let entitiyDelete = realm.objects(GroupEntity.self).filter("id == %@", a.id)
                realm.delete(entitiyDelete)
            }
        }
        catch{
            return false
        }
        return true
    }
    
}
