//
//  ViewController.swift
//  WelcomeToIntercom
//
//  Created by Kızılay on 29.04.2019.
//  Copyright © 2019 Rozeri Dilar. All rights reserved.
//

//Customers.txt should be full of json objects line by line, because file is readed line by line and converted to customer json objects, after then, these objects are added to customers array.


import UIKit
import CoreLocation


//Here you can change the targeted location
let intercomLocation = CLLocation(latitude: 53.339428, longitude: -6.257664)

let radiusOfEarth: Double = 6371

let closeLocationwithin100Kms: Double = 100

class ViewController: UIViewController {
    
    //MARK: Variables
    var customers : [Customer] = []
    var closestCustomers: [Customer] = []
    
    //MARK: Outlets
    @IBOutlet weak var textViewCustomers: UITextView!
    
    
    //MARK: Lyfecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadJson(filename: "customers")
        
    }
    
    func checkLocations(_ customers: [Customer]){
        let intercomLongtitude = intercomLocation.coordinate.longitude
        let intercomLatitude = intercomLocation.coordinate.latitude
        for customer in customers {
            
            guard  Double(customer.longitude) != nil && Double(customer.latitude) != nil else{
                let errorMsg = Double(customer.longitude) == nil ? "longitude" : Double(customer.latitude) == nil ? "latitude" :  "longitude and latitude"
                self.showError("\(customer.name) doesnt have \(errorMsg)")
                return
            }
            
            let distance = ( radiusOfEarth * acos( cos( radians(intercomLongtitude) ) * cos( radians( Double(customer.longitude)!) ) * cos( radians( Double(customer.latitude)!) - radians(intercomLatitude) ) + sin( radians(intercomLongtitude) ) * sin( radians( Double(customer.longitude)!)) ) )
            
            if distance <= closeLocationwithin100Kms {
                closestCustomers.append(customer)
            }
            
        }
        updateUIWithClosestCustomers(closestCustomers)
    }
}

extension ViewController{
    func loadJson(filename fileName: String){
        DispatchQueue.global(qos: .background).async{
            if let path = Bundle.main.path(forResource: fileName, ofType: "txt") {
                do {
                    let data = try String(contentsOfFile: path, encoding: .utf8)
                    let myStrings = data.components(separatedBy: .newlines)
                    guard myStrings.count > 0 else{
                        return
                    }
                    for str in myStrings {
                        let data = str.data(using: .utf8)!
                        do {
                            let customer = try JSONDecoder().decode(Customer.self, from: data)
                            print(customer)
                            self.customers.append(customer)
                            
                        } catch {
                            print(error)
                        }
                    }
                } catch {
                    print(error)
                }
                self.checkLocations(self.customers)
            }
        }
    }
    
    func radians(_ number: Double) -> Double {
        return number * .pi / 180
    }
    
    //MARK: UI Functions
    func updateUIWithClosestCustomers(_ closestCustomers: [Customer]){
        
        let customerStr = closestCustomers.count > 0 ?  closestCustomers.sorted{$0.userId<$1.userId}.reduce("Customers who are close within 100 kms are, \n ") {text, customer in "\(text) \n \(customer.name) with userId: \(customer.userId) \n"} : "You do not have close customers." 
        
        DispatchQueue.main.async {
            self.textViewCustomers.text = "\(customerStr)"
        }
        
    }
    
    func showError(_ error: String){
        let sendMailErrorAlert = UIAlertController(title: "Ups!", message: error, preferredStyle: .alert)
        let dismiss = UIAlertAction(title: "OK", style: .default, handler: nil)
        sendMailErrorAlert.addAction(dismiss)
        self.present(sendMailErrorAlert, animated: true, completion: nil)
    }
}

