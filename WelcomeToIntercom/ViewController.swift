//
//  ViewController.swift
//  WelcomeToIntercom
//
//  Created by Kızılay on 29.04.2019.
//  Copyright © 2019 Rozeri Dilar. All rights reserved.
//

import UIKit

struct ResponseData: Decodable {
    var customers: [Customer]
}

func loadJson(filename fileName: String) -> Customer? {
    if let url = Bundle.main.url(forResource: fileName, withExtension: "txt") {
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let jsonData = try decoder.decode(Customer.self, from: data)
            print(jsonData)
            return jsonData
        } catch {
            print("error:\(error)")
        }
    }
    return nil
}

class ViewController: UIViewController {

    var customers : [Customer] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
     //   customers = loadJson(filename: "customers") ?? []
    let k = loadJson(filename: "customers")
    }


}

