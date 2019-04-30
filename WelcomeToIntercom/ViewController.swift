//
//  ViewController.swift
//  WelcomeToIntercom
//
//  Created by Kızılay on 29.04.2019.
//  Copyright © 2019 Rozeri Dilar. All rights reserved.
//

import UIKit




class ViewController: UIViewController {
    
    var customers : [Customer] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadJson(filename: "customers")
        
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
            }
        }
    }
}

