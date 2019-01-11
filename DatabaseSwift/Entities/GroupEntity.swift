//
//  GroupEntity.swift
//  DatabaseSwift
//
//  Created by JOAQUIN DIAZ RAMIREZ on 11/1/19.
//  Copyright © 2019 JOAQUIN DIAZ RAMIREZ. All rights reserved.
//

import Foundation

import RealmSwift

class GroupEntity: Object {
    
    @objc dynamic var id = ""
    @objc dynamic var name = ""
     @objc dynamic var numberPeople = ""
    //@objc dynamic var friends = [Task!].self
    @objc dynamic var isDone = false
    
    override static func primaryKey() -> String? {
        return "id"
    }
    convenience init (group: Group)
    {
        self.init()
        self.id = group.id
        self.name = group.name
        self.numberPeople = String(group.numberPeople)
       // self.friends = group.people
        self.isDone = group.isDone
    }
    func groupModel() -> Group{
        let model = Group()
        model.id = self.id
        model.name = self.name
        model.numberPeople = Int(self.numberPeople)
        model.isDone = self.isDone
        return model
    }
}
