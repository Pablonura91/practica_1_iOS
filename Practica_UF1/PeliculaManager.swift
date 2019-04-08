//
//  PeliculaManager.swift
//  Practica_UF1
//
//  Created by Alumne on 28/03/2019.
//  Copyright © 2019 LaSalle. All rights reserved.
//

import Foundation

class PeliculaManager {
    var peliculas:[Pelicula]=[Pelicula]()
    
    func addPelicula(pelicula: Pelicula){
        self.peliculas.append(pelicula)
    }    
    
    func deletePelicula(index: Int){
        self.peliculas.remove(at: index)
    }
    
    func clear(){
        self.peliculas.removeAll()
    }
    
}
