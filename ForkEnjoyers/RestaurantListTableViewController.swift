//
//  RestaurantListTableViewController.swift
//  ForkEnjoyers
//
//  Created by Robin on 26/04/2022.
//

import UIKit

class RestaurantListTableViewController: UITableViewController {
    
    // TODOOOOO
    // Faire un call API pour récupérer une liste de restaurant
    

    var browsers:[String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // On lance la requète
        let config = URLSessionConfiguration.default
               let session = URLSession(configuration: config)
               
               let url = URL(string: "http://api.deezer.com/search?q=a")!
               
               let task = session.dataTask(with: url) { (data, response, error) in
                   if error != nil {
                       print(error!.localizedDescription)
                   } else {
                       if let json = try? JSONSerialization.jsonObject(with: data!, options: .mutableContainers) {
                           if let data = json as? [String: AnyObject] {
                               
                               if let items = data["data"] as? [[String: AnyObject]] {
                                   for item in items {
                                       print(item["link"]!)
                                       self.browsers.append(item["link"]! as! String)
                                       /*if let artist = Artist(json: item) {
                                           self.browsers.append(artist)
                                       }*/
                                       
                                   }
                               }
                           }
                       }
                   }
                   
                   DispatchQueue.main.async {
                       self.tableView.reloadData()
                   }
                   
               }
               task.resume()
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // 1 cause we have only 1 section
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // TODOOO
        // Return self.restaurants.count
        return self.browsers.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // TODOOO
        // Configure cell for appropriate restaurant cells

        cell.textLabel?.text = self.browsers[indexPath.row]
        
        if indexPath.row % 2 == 0 {
            cell.backgroundColor = UIColor.green
        }
        else {
            cell.backgroundColor = UIColor.red
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODOOOO
        // Navigate to Detailed Restaurant View
        
        
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
