//
//  SQLiteDAO.swift
//  Practica_UF1
//
//  Created by Pablo Nuñez on 05/04/2019.
//  Copyright © 2019 LaSalle. All rights reserved.
//

import Foundation
protocol SQLiteDAO {
    func insert(_ database: FMDatabase, newRecord: AnyObject) -> Bool
    func update(_ database: FMDatabase, newRecord: AnyObject) -> Bool
    func delete(_ database: FMDatabase, newRecord: AnyObject) -> Bool
    func readRecords(_ database: FMDatabase) -> AnyObject
    func readRecordsByFavorites(_ database: FMDatabase) -> AnyObject
}
