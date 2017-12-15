//
//  PurchaseViewController.swift
//  NowTicketing
//
//  Created by Maria Yu on 12/14/17.
//  Copyright © 2017 Maria Yu. All rights reserved.
//

import UIKit

class PurchaseViewController: UIViewController {
    var selectedType: String?
    var selectedFare: Fare?
    
    @IBOutlet weak var confirmLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var passLbl: UILabel!
    //@IBOutlet weak var numTicket: UIButton!
    @IBOutlet weak var totalLbl: UILabel!
    @IBOutlet weak var numLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        confirmLbl.font = UIFont.boldSystemFont(ofSize: 17)
        
        if let fare = selectedFare, let type = selectedType {
            typeLbl.text = type
            passLbl.text = selectedFare?.description
            numLbl.text = "1"
            totalLbl.text = "Buy 1 ticket - $" + String(format: "%.2f", fare.price!)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func add(_ sender: Any) {
        var num = Int(numLbl.text!)!
        num = num + 1
        numLbl.text = "\(num)"
        let total = Double(num) * (selectedFare?.price)!
        
        let tic = num > 1 ? "tickets" : "ticket"
        totalLbl.text = "Buy " + "\(num) " + tic + " - $" + String(format: "%.2f", total)
    }
    
    @IBAction func subtract(_ sender: Any) {
        var num = Int(numLbl.text!)!
        if num == 1 {
            let alert = UIAlertController(title: "Cannot subtract ticket", message: "Minimum is 1", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default)
            alert.addAction(ok)
            present(alert, animated: true)
            return
        }
        
        num = num - 1
        numLbl.text = "\(num)"
        let total = Double(num) * (selectedFare?.price)!
        
        let tic = num > 1 ? "tickets" : "ticket"
        totalLbl.text = "Buy " + "\(num) " + tic + " - $" + String(format: "%.2f", total)
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
