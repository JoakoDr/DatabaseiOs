//
//  LocalTaskRepository.swift
//  DatabaseSwift
//
//  Created by JOAQUIN DIAZ RAMIREZ on 19/12/18.
//  Copyright © 2018 JOAQUIN DIAZ RAMIREZ. All rights reserved.
//

import UIKit
import RealmSwift
clas

class LocalTaskRepository: NSObject {
    
    func getAll() -> [Task] {
        return []
    }
    func get(identifier: String) -> Task? {
        return nil
    }
    func create(a: Task) -> Bool {
        return true
    }
    func update(a: Task) -> Bool {
        return true
    }
    func delete(a: Task) -> Bool {
        return true
    }

}
