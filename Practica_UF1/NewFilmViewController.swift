//
//  NewFilmViewController.swift
//  Practica_UF1
//
//  Created by Alumne on 04/04/2019.
//  Copyright © 2019 LaSalle. All rights reserved.
//

import UIKit

class NewFilmViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var filmTitle: UITextField!
    @IBOutlet weak var filmGender: UITextField!
    @IBOutlet weak var filmHorario: UITextField!
    @IBOutlet weak var filmSinopsis: UITextView!
    
    var pelicula: Pelicula?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        filmSinopsis.layer.borderWidth = 1
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "saveNewFilm"{
            if let rvc = segue.destination as? PeliculaTableViewController{
                rvc.pelicula = Pelicula(id: "4", image: "interrogant", title: filmTitle.text ?? "", genero: filmGender.text ?? "", horario: filmHorario.text ?? "", sinopsis: filmSinopsis.text ?? "", favorito: "0")
            }
        }
    }

}
