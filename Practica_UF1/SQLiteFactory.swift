//
//  SQLiteFactory.swift
//  Practica_UF1
//
//  Created by Pablo Nuñez on 05/04/2019.
//  Copyright © 2019 LaSalle. All rights reserved.
//

import Foundation

class SQLiteFactory{
    class func createFactory(_ type: Int) -> SQLiteDAO{
        return DatabaseManager()
    }
}
