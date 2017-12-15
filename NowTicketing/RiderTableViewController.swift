//
//  RiderTableViewController.swift
//  NowTicketing
//
//  Created by Maria Yu on 12/14/17.
//  Copyright © 2017 Maria Yu. All rights reserved.
//

import UIKit

class RiderTableViewController: UITableViewController {
    
    var tickets: [Ticket] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if tickets.count == 0 {
            guard let file = Bundle.main.url(forResource: "ticket", withExtension: "json") else { return }
            
            tickets = loadFromFile(file: file)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadFromFile(file : URL) -> [Ticket] {
        var alltickets = [Ticket]()
        
        do {
            let data = try Data(contentsOf: file)
            guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:AnyObject] else  {
                return alltickets
            }
            
            for (key, _) in json {
                var allFares = [Fare]()
                
                if let fares = json[key]?["fares"] as? [[String:AnyObject]] {
                    for fare in fares {
                        if let desc = fare["description"] as? String,
                            let price = fare["price"] as? Double {
                            let fareobj = Fare(desc: desc, pr: price)
                            allFares.append(fareobj)
                        }
                    }
                }
                
                let ticket  = Ticket(tpe: key, text: json[key]?["subtext"] as? String ?? "", fareAry: allFares)
                
                alltickets.append(ticket)
            }
            
            alltickets.sort(by: {$0.type! < $1.type!})
        }
        catch {
            print("Error parsing JSON file")
        }
        
        return alltickets
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowFares" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let vc = segue.destination as! FareTableViewController
                
                vc.selectedRider = tickets[indexPath.row]
            }
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tickets.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RiderTableCell", for: indexPath)
        
        cell.textLabel?.text = tickets[indexPath.row].type
        cell.detailTextLabel?.text = tickets[indexPath.row].subtext
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?  {
        return "Select Rider"
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int)
    {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font = UIFont.boldSystemFont(ofSize: 17)
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
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
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
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
