//
//  Pelicula_TableViewController.swift
//  Practica_UF1
//
//  Created by Alumne on 25/03/2019.
//  Copyright © 2019 LaSalle. All rights reserved.
//

import UIKit

struct Pelicula {
    var image:String
    var title:String
    var horario:String
    
}

class tableViewCell: UITableViewCell{
    
    @IBOutlet weak var imagePelicula: UIImageView!
    @IBOutlet weak var horariosPelicula: UILabel!
    @IBOutlet weak var titlePelicula: UILabel!
    
}


class Pelicula_TableViewController: UITableViewController {
    
    var peliculas:[Pelicula] = [Pelicula(image: "", title: "Pelicula 1", horario:"12:00 | 15:30"), Pelicula(image: "", title: "Pelicula 2", horario:"12:30 | 16:00 | 19:00")]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return peliculas.count
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listPeliculas", for: indexPath)
        
        as! tableViewCell
        let pelicula = peliculas[indexPath.row]
      
        //cell.imagePelicula?.image = pelicula.image
        if let titleText = cell.titlePelicula {
            titleText.text = pelicula.title
        }
        
        if let horarioText = cell.horariosPelicula {
            horarioText.text = pelicula.horario
        }
        return cell
    }

}

//https://www.ralfebert.de/ios-examples/uikit/uitableviewcontroller/custom-cells/
//custom cells shit
