//
//  TaskEntitiy.swift
//  DatabaseSwift
//
//  Created by JOAQUIN DIAZ RAMIREZ on 19/12/18.
//  Copyright © 2018 JOAQUIN DIAZ RAMIREZ. All rights reserved.
//

import Foundation
import RealmSwift

class TaskEntity: Object {
    
    @objc dynamic var id = ""
    @objc dynamic var name = ""
    @objc dynamic var job = ""
    @objc dynamic var food = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
    convenience init (task: Task)
    {
        self.init()
        self.id = task.id
        self.name = task.name
        self.job = task.job
        self.food = task.food
    }
    func taskModel() -> Task{
        let model = Task()
        model.id = self.id
        model.name = self.name
        model.job = self.job
        model.food = self.food
        
        return model
    }
}
