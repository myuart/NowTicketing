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
    var currentTicketNum: Int = 0
    var currentTotal: Double = 0.0
    
    @IBOutlet weak var confirmLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var passLbl: UILabel!
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
            
            currentTicketNum = 1
            currentTotal = calculate()
        }
        else { //shouldn't happen though
            typeLbl.text = ""
            passLbl.text = ""
            numLbl.text = "0"
            totalLbl.text = "Buy 0 ticket - $0.00"
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func calculate() -> Double {
        if let price = selectedFare?.price {
            let total = Double(currentTicketNum) * price
            return total
        }
        else {
            return 0.0
        }
    }
    
    @IBAction func add(_ sender: Any) {
        currentTicketNum = Int(numLbl.text!)! + 1
        numLbl.text = "\(currentTicketNum)"
        currentTotal = calculate()
        
        let tic = currentTicketNum > 1 ? "tickets" : "ticket"
        totalLbl.text = "Buy " + "\(currentTicketNum) " + tic + " - $" + String(format: "%.2f", currentTotal)
    }
    
    @IBAction func subtract(_ sender: Any) {
        var num = Int(numLbl.text!)!
        if num == 0 {
            let alert = UIAlertController(title: "Cannot subtract ticket", message: nil, preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default)
            alert.addAction(ok)
            present(alert, animated: true)
            return
        }
        
        num = num - 1
        currentTicketNum = num
        numLbl.text = "\(currentTicketNum)"
        currentTotal = calculate()
        
        let tic = currentTicketNum > 1 ? "tickets" : "ticket"
        totalLbl.text = "Buy " + "\(currentTicketNum) " + tic + " - $" + String(format: "%.2f", currentTotal)
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
