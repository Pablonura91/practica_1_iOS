//
//  DatabaseManager.swift
//  Practica_UF1
//
//  Created by Alumne on 01/04/2019.
//  Copyright © 2019 LaSalle. All rights reserved.
//

import Foundation

class DatabaseManager: SQLiteDAO{
    let databaseFileName = "cinema.db"
    var databasePath:String?
    
    func insert(_ database: FMDatabase, newRecord: AnyObject) -> Bool {
        var result = false
        let pelicula = newRecord as! Pelicula
        let cinemaDB = database
        
        if cinemaDB.open(){
            let lastIDSQL = "SELECT MAX(ID_Film) FROM films"
            let data: [Any]=[Any]()
            var data2: [Any]=[Any]()
            if let resultSet = cinemaDB.executeQuery(lastIDSQL, withArgumentsIn: data){
                resultSet.next()
                if let result = resultSet.string(forColumnIndex: 0){
                    let lastIndex = Int(result) ?? 0
                    data2 = [String(lastIndex + 1), pelicula.image, pelicula.title, pelicula.horario, pelicula.genero, pelicula.sinopsis, "0"]
                }
                
            }
            
            let insertSQL = "INSERT INTO films (ID_Film, Image, Name, Date, Gender, Sinopsis, Favorite) VALUES(?,?,?,?,?,?,?)"
            result = cinemaDB.executeUpdate(insertSQL, withArgumentsIn: data2)
               
            cinemaDB.close()
        } else {
            print("Error \(database.lastErrorMessage())")
        }
        return result
    }
    
    func update(_ database: FMDatabase, newRecord: AnyObject) -> Bool {
        var result = false
        let pelicula = newRecord as! Pelicula
        let cinemaDB = database
        
        if cinemaDB.open(){
            let updateSQL = "UPDATE films SET image = ?, Name = ?, Date = ?, Gender = ?, Sinopsis = ?, Favorite = ? WHERE ID_Film = ?"
            let data = [pelicula.image, pelicula.title, pelicula.horario, pelicula.genero, pelicula.sinopsis, pelicula.favorito, pelicula.id,]
            result = cinemaDB.executeUpdate(updateSQL, withArgumentsIn: data)
            cinemaDB.close()
        } else {
            print("Error \(database.lastErrorMessage())")
        }
        return result
    }
    
    func delete(_ database: FMDatabase, newRecord: AnyObject) -> Bool {
        var result = false
        let cinemaDB = database
        let idFilm = [newRecord]
        
        if cinemaDB.open(){
            let deleteSQL = "DELETE FROM films WHERE ID_Film = ?"
            
            result = cinemaDB.executeQuery(deleteSQL, withArgumentsIn: idFilm)?.next() ?? false
        }
        return result
    }
    
    func readRecords(_ database: FMDatabase) -> AnyObject{
        let peliculasManager = PeliculaManager()
        peliculasManager.clear()
        let cinemaDB = database
        
        if cinemaDB.open(){
            let selectSQL = "SELECT * FROM films"
            let data: [Any]=[Any]()
            var id, image, name, date, gender, sinopsis, favorite: String?
            if let resultSet = cinemaDB.executeQuery(selectSQL, withArgumentsIn: data){
                while(resultSet.next()){
                    if let filmSelect = resultSet.string(forColumnIndex: 0){
                        id = filmSelect
                    }
                    if let filmSelect = resultSet.string(forColumnIndex: 1){
                        image = filmSelect
                    }
                    if let filmSelect = resultSet.string(forColumnIndex: 2){
                        name = filmSelect
                    }
                    if let filmSelect = resultSet.string(forColumnIndex: 3){
                        date = filmSelect
                    }
                    if let filmSelect = resultSet.string(forColumnIndex: 4){
                        gender = filmSelect
                    }
                    if let filmSelect = resultSet.string(forColumnIndex: 5){
                        sinopsis = filmSelect
                    }
                    if let filmSelect = resultSet.string(forColumnIndex: 6){
                        favorite = filmSelect
                    }
                    
                    peliculasManager.addPelicula(pelicula: Pelicula(id: id!, image: image!, title: name!, genero: gender!, horario: date!, sinopsis: sinopsis!, favorito: favorite!))
                }
                resultSet.close()
            }
            cinemaDB.close()
        } else {
            print("Error \(database.lastErrorMessage())")
        }
        return peliculasManager
    }
    
    func readRecordsByFavorites(_ database: FMDatabase) -> AnyObject {
        let peliculasManager = PeliculaManager()
        peliculasManager.clear()
        let cinemaDB = database
        
        if cinemaDB.open(){
            let selectSQL = "SELECT * FROM films WHERE Favorite = 1"
            let data: [Any]=[Any]()
            var id, image, name, date, gender, sinopsis, favorite: String?
            if let resultSet = cinemaDB.executeQuery(selectSQL, withArgumentsIn: data){
                while(resultSet.next()){
                    if let filmSelect = resultSet.string(forColumnIndex: 0){
                        id = filmSelect
                    }
                    if let filmSelect = resultSet.string(forColumnIndex: 1){
                        image = filmSelect
                    }
                    if let filmSelect = resultSet.string(forColumnIndex: 2){
                        name = filmSelect
                    }
                    if let filmSelect = resultSet.string(forColumnIndex: 3){
                        date = filmSelect
                    }
                    if let filmSelect = resultSet.string(forColumnIndex: 4){
                        gender = filmSelect
                    }
                    if let filmSelect = resultSet.string(forColumnIndex: 5){
                        sinopsis = filmSelect
                    }
                    if let filmSelect = resultSet.string(forColumnIndex: 6){
                        favorite = filmSelect
                    }
                    
                    peliculasManager.addPelicula(pelicula: Pelicula(id: id!, image: image!, title: name!, genero: gender!, horario: date!, sinopsis: sinopsis!, favorito: favorite!))
                }
                resultSet.close()
            }
            cinemaDB.close()
        } else {
            print("Error \(database.lastErrorMessage())")
        }
        return peliculasManager
    }
    //get document device directory
    func setUpDataBase(){
        let fileManager = FileManager()
        if let dirDocument = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first{
            let databaseURL = dirDocument.appendingPathComponent(databaseFileName)
            databasePath = databaseURL.path
        }
        //create tables if not exists
        let cinemaDB = FMDatabase(path:databasePath)
        
        if cinemaDB.open(){
            if !cinemaDB.executeStatements("CREATE TABLE IF NOT EXISTS films (ID_Film INTEGER PRIMARY KEY, Image TEXT, Name TEXT, Date TEXT, Gender TEXT, Sinopsis TEXT, Favorite INTEGER, CONSTRAINT name_unique UNIQUE (Name))"){
                print(cinemaDB.lastError().localizedDescription)
            }
            cinemaDB.close()
        }else{
            print(cinemaDB.lastError().localizedDescription)
        }
        
    }
    
    func selectData(_ peliculasManager: PeliculaManager){
        peliculasManager.clear()
        let cinemaDB = FMDatabase(path:databasePath)
        
        if cinemaDB.open(){
            let selectSQL = "SELECT * FROM films"
            let data: [Any]=[Any]()
            var id, image, name, date, gender, sinopsis, favorite: String?
            if let resultSet = cinemaDB.executeQuery(selectSQL, withArgumentsIn: data){
                while(resultSet.next()){
                    if let filmSelect = resultSet.string(forColumnIndex: 0){
                        id = filmSelect
                    }
                    if let filmSelect = resultSet.string(forColumnIndex: 1){
                        image = filmSelect
                    }
                    if let filmSelect = resultSet.string(forColumnIndex: 2){
                        name = filmSelect
                    }
                    if let filmSelect = resultSet.string(forColumnIndex: 3){
                        date = filmSelect
                    }
                    if let filmSelect = resultSet.string(forColumnIndex: 4){
                        gender = filmSelect
                    }
                    if let filmSelect = resultSet.string(forColumnIndex: 5){
                        sinopsis = filmSelect
                    }
                    if let filmSelect = resultSet.string(forColumnIndex: 6){
                        favorite = filmSelect
                    }
                    
                    peliculasManager.addPelicula(pelicula: Pelicula(id: id!, image: image!, title: name!, genero: gender!, horario: date!, sinopsis: sinopsis!, favorito: favorite!))
                }
                resultSet.close()
            }
            cinemaDB.close()
        }
    }
    
    func saveData(_ pelicula: Pelicula){
        let cinemaDB = FMDatabase(path:databasePath)
        
        if cinemaDB.open(){
            let updateSQL = "UPDATE INTO films (ID_Film, Image, Name, Date, Gender, Sinopsis, Favorite) VALUES(?,?,?,?,?,?,?)"
            let data = [pelicula.id, pelicula.image, pelicula.title, pelicula.horario, pelicula.genero, pelicula.sinopsis, pelicula.favorito]
            if !cinemaDB.executeUpdate(updateSQL, withArgumentsIn: data){
                print(cinemaDB.lastError().localizedDescription)
            }
            cinemaDB.close()
        }
    }
    
    func insertData(_ pelicula: Pelicula){
        let cinemaDB = FMDatabase(path:databasePath)
        
        if cinemaDB.open(){
            let lastIDSQL = "SELECT MAX(ID_Film) FROM films"
            let data: [Any]=[Any]()
            var data2: [Any]=[Any]()
            if let resultSet = cinemaDB.executeQuery(lastIDSQL, withArgumentsIn: data){
                resultSet.next()
                if let result = resultSet.string(forColumnIndex: 0){
                    let lastIndex = Int(result) ?? 0
                    data2 = [String(lastIndex + 1), pelicula.image, pelicula.title, pelicula.horario, pelicula.genero, pelicula.sinopsis, "0"]
                }
                
            }
            
            let insertSQL = "INSERT INTO films (ID_Film, Image, Name, Date, Gender, Sinopsis, Favorite) VALUES(?,?,?,?,?,?,?)"
            if !cinemaDB.executeUpdate(insertSQL, withArgumentsIn: data2){
                print(cinemaDB.lastError().localizedDescription)
            }
            cinemaDB.close()
        }
    }
        
    
}




//alomillor simplementa
/*func createDateTable(){
 let cinemaDB = FMDatabase(path:databasePath)
 
 if cinemaDB.open(){
 if !cinemaDB.executeStatements("CREATE TABLE IF NOT EXISTS date (ID_Date INTEGER PRIMARY KEY, ID_Film INTEGER)"){
 print(cinemaDB.lastError().localizedDescription)
 }
 cinemaDB.close()
 }else{
 print(cinemaDB.lastError().localizedDescription)
 }
 }*/
// , FOREIGN KEY (ID_Date) REFERENCES filmDate(ID_Date)
