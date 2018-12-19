//
//  Repository.swift
//  DatabaseSwift
//
//  Created by JOAQUIN DIAZ RAMIREZ on 19/12/18.
//  Copyright © 2018 JOAQUIN DIAZ RAMIREZ. All rights reserved.
//

import Foundation

protocol Repository {
    associatedtype T
    func getAll() -> [T]
    func get (identifier: String) -> T?
    func create(a: T) -> Bool
    func update (a: T) -> Bool
    func delete (a: T) -> Bool
}
