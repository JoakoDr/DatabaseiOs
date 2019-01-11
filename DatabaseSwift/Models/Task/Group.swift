//
//  Group.swift
//  DatabaseSwift
//
//  Created by JOAQUIN DIAZ RAMIREZ on 11/1/19.
//  Copyright © 2019 JOAQUIN DIAZ RAMIREZ. All rights reserved.
//

import Foundation

class Group {
    var id: String!
    var name: String!
    var numberPeople: Int!
    var people: [Task]!
    var isDone = false
}
