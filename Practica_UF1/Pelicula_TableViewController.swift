//
//  Pelicula_TableViewController.swift
//  Practica_UF1
//
//  Created by Alumne on 25/03/2019.
//  Copyright © 2019 LaSalle. All rights reserved.
//

import UIKit

class Pelicula_TableViewController: UITableViewController {
    
    var peliculas:[String] = ["1","2","3"]
    
    class MyTable: UITableViewCell{
        @IBOutlet var imagePelicula: UIImageView!
        @IBOutlet var titlePelicula: UILabel!
        @IBOutlet var horariosPelicula: UILabel!        
    }
    
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

        let item:String = peliculas[indexPath.row]
        
        if let myTableCell = cell as? MyTable{
            
            myTableCell.titlePelicula.text = item
            myTableCell.horariosPelicula.text = "12:30 | 13:30"
        }
        
        return cell
    }

}


