//
//  DatabaseInterface.swift
//  weather
//
//  Created by Mahmoud BEN AISSA on 14/10/2018.
//  Copyright © 2018 Mahmoud BEN AISSA. All rights reserved.
//

import Foundation

protocol DatabaseInterface {
    
    func get<T>(predicate: String) -> T?
    func save<T>(data:T)
}
