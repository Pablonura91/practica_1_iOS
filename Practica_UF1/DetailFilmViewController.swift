//
//  DetailFilmViewController.swift
//  Practica_UF1
//
//  Created by Alumne on 28/03/2019.
//  Copyright © 2019 LaSalle. All rights reserved.
//

import UIKit

class DetailFilmViewController: UIViewController {

    var pelicula: Pelicula?
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var detailTitle: UILabel!
    @IBOutlet weak var horario: UILabel!
    @IBOutlet weak var sinopsis: UITextView!
    @IBOutlet weak var favorite: UIButton!
    @IBAction func onClickFavorite(_ sender: UIButton) {
        if favorite.backgroundColor != UIColor.red{
            favorite.backgroundColor = UIColor.red
            pelicula?.favorito = "1"
        } else {
            favorite.backgroundColor = UIColor.white
            pelicula?.favorito = "0"
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let currentPelicula = pelicula{
            self.pelicula = currentPelicula
            
            image.image = UIImage(named: currentPelicula.image)
            detailTitle.text = currentPelicula.title
            horario.text = currentPelicula.horario
            sinopsis.text = currentPelicula.sinopsis
            if currentPelicula.favorito == "1" {
                favorite.backgroundColor = UIColor.red
            }
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "saveDetailFilm" {
            if let rvc = segue.destination as? PeliculaTableViewController{
                rvc.pelicula = self.pelicula
            }
        }
    }

    /*
    // MARK: - Navigation
    
    https://stackoverflow.com/questions/33394990/creating-favorites-button-in-swift-xcode-6

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
