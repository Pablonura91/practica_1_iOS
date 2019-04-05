//
//  SQLiteSingleton.swift
//  Practica_UF1
//
//  Created by Pablo Nuñez on 05/04/2019.
//  Copyright © 2019 LaSalle. All rights reserved.
//

import Foundation

private let databaseFileName: String = "cinema.db"
private var databasePath: String = String()
private var database: FMDatabase?

class SQLiteSingleton{
    class func getInstance() -> FMDatabase{
        if database == nil {
            let fileManager = FileManager()
            
            if let dirDocument = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first{
                let databaseURL = dirDocument.appendingPathComponent(databaseFileName)
                databasePath = databaseURL.path
                database = FMDatabase(path: databasePath)
            }
        }
        return database!
    }
}
