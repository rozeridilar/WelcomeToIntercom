//
//  ViewController.swift
//  WelcomeToIntercom
//
//  Created by Kızılay on 29.04.2019.
//  Copyright © 2019 Rozeri Dilar. All rights reserved.
//

//Customers.txt should be full of json objects line by line, file is readed line by line and converted to customer json objects then added to customers array.


import UIKit
import CoreLocation


//Here you can change the targeted location
let intercomLocation = CLLocation(latitude: 53.339428, longitude: -6.257664)

class ViewController: UIViewController {
    
    var customers : [Customer] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadJson(filename: "customers")
        
    }
    
    func checkLocations(_ customers: [Customer]){
    
        for customer in customers {
            print(customer.latitude)
            print(customer.longitude)
        }
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
}

