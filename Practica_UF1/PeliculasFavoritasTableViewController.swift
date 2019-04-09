//
//  PeliculasFavoritasTableViewController.swift
//  Practica_UF1
//
//  Created by Pablo Nuñez on 07/04/2019.
//  Copyright © 2019 LaSalle. All rights reserved.
//

import UIKit

class PeliculasFavoritasTableViewController: UITableViewController {
    var database: FMDatabase = SQLiteSingleton.getInstance()
    var dataBaseManager: DatabaseManager = (SQLiteFactory.createFactory(0) as! DatabaseManager)
    var peliculasManager: PeliculaManager?
    var pelicula: Pelicula?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataBaseManager = DatabaseManager()
        peliculasManager = dataBaseManager.readRecordsByFavorites(database) as? PeliculaManager
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.dataBaseManager = DatabaseManager()
        peliculasManager = dataBaseManager.readRecordsByFavorites(database) as? PeliculaManager
        tableView.reloadData()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return peliculasManager?.peliculas.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listPeliculas", for: indexPath) as! TableViewPeliculaCell
        if let currentPeliculaManager = peliculasManager {
            let pelicula = currentPeliculaManager.peliculas[indexPath.row]
            cell.imagePelicula?.image = UIImage(named: pelicula.image)
            cell.titlePelicula?.text = pelicula.title
            cell.horariosPelicula?.text = pelicula.horario
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        if let currentPeliculaManager = peliculasManager {
            let item = currentPeliculaManager.peliculas[indexPath.row]
            self.performSegue(withIdentifier: "DetailFavFilm", sender: item)
            tableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailFavFilm" {
            if let cell = sender as? UITableViewCell,
                let indexPath = tableView.indexPath(for: cell)
            {
                if let destinationNavigationController = segue.destination as? UINavigationController,
                    let targetController = destinationNavigationController.topViewController as? DetailFilmFavViewController {
                    if let currentPeliculaManager = peliculasManager {
                        targetController.pelicula = currentPeliculaManager.peliculas[indexPath.row]
                    }
                }
            }
        }
    }
    
    @IBAction func goBack(segue: UIStoryboardSegue){
        switch segue.identifier {
        case "cancelDetailFilm": break
            
        case "saveDetailFilm":
            if let backPelicula = pelicula{
                if let currentPeliculaManager = peliculasManager {
                    currentPeliculaManager.addPelicula(pelicula: backPelicula)
                }
                if (dataBaseManager.update(database, newRecord: backPelicula as AnyObject)){
                    tableView.reloadData()
                }
            }
        default:
            break
        }
    }
}
