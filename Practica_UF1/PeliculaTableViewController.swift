//
//  Pelicula_TableViewController.swift
//  Practica_UF1
//
//  Created by Alumne on 25/03/2019.
//  Copyright © 2019 LaSalle. All rights reserved.
//

import UIKit


class PeliculaTableViewController: UITableViewController {
    
    var peliculasManager: PeliculaManager = PeliculaManager()
    
    var pelicula: Pelicula?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let dataBaseManager = DatabaseManager()
        dataBaseManager.setUpDataBase()
        dataBaseManager.selectData(peliculasManager)
        
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
        return peliculasManager.peliculas.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listPeliculas", for: indexPath)
        
        as! TableViewPeliculaCell
        let pelicula = peliculasManager.peliculas[indexPath.row]
      
        cell.imagePelicula?.image = UIImage(named: pelicula.image)
        cell.titlePelicula?.text = pelicula.title
        cell.horariosPelicula?.text = pelicula.horario
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            peliculasManager.deletePelicula(index: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let item = peliculasManager.peliculas[indexPath.row]
        self.performSegue(withIdentifier: "detailFilmSegue", sender: item)
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailFilmSegue" {
            if let cell = sender as? UITableViewCell,
                let indexPath = tableView.indexPath(for: cell)
            {
                if let destinationNavigationController = segue.destination as? UINavigationController,
                    let targetController = destinationNavigationController.topViewController as? DetailFilmViewController {
                    targetController.pelicula = peliculasManager.peliculas[indexPath.row]
                }
            }
        }
    }    
    
    @IBAction func goBack(segue: UIStoryboardSegue){
        switch segue.identifier {
        case "cancelDetailFilm": break
            
        case "saveDetailFilm":
            if let backPelicula = pelicula{
                peliculasManager.addPelicula(pelicula: backPelicula)
                tableView.reloadData()
            }
        default:
            break
        }
    }    
}


//https://www.ralfebert.de/ios-examples/uikit/uitableviewcontroller/custom-cells/
//custom cells shit

//INSERT into database
/*
 
 let cinemaDB = FMDatabase(path:databasePath)
 
 if cinemaDB.open(){
 let insertSQL = "INSERT INTO films (ID_Film, Image, Name, Date, Gender, Sinopsis, Favorite) VALUES(?,?,?,?,?,?,?)"
 let data = ["1", "imageHeartTrue","Pelicula 1", "12:00 | 15:30", "siensia", "pofghudopfh", "0"]
 if !cinemaDB.executeUpdate(insertSQL, withArgumentsIn: data){
 print(cinemaDB.lastError().localizedDescription)
 }
 
 let insertSQL2 = "INSERT INTO films (ID_Film, Image, Name, Date, Gender, Sinopsis, Favorite) VALUES(?,?,?,?,?,?,?)"
 let data2 = ["1", "imageHeartFalse","Pelicula 2", "12:30 | 16:00 | 19:00", "kappa", "pofghudopfh", "1"]
 if !cinemaDB.executeUpdate(insertSQL2, withArgumentsIn: data2){
 print(cinemaDB.lastError().localizedDescription)
 }
 cinemaDB.close()
 
 }else{
 print(cinemaDB.lastError().localizedDescription)
 }
 */



//harcoded films
/*peliculasManager.addPelicula(pelicula: Pelicula(image: "imageHeartTrue", title: "Pelicula 1", horario:"12:00 | 15:30", sinopsis: "vjbcnvglojngjko"))
 peliculasManager.addPelicula(pelicula: Pelicula(image: "imageHeartFalse", title: "Pelicula 2", horario:"12:30 | 16:00 | 19:00", sinopsis: "vjbcnvglojngjko"))*/
