//
//  ViewController.swift
//  WelcomeToIntercom
//
//  Created by Kızılay on 29.04.2019.
//  Copyright © 2019 Rozeri Dilar. All rights reserved.
//

import UIKit

struct ResponseData: Decodable {
    var person: [Person]
}

struct Person : Decodable {
    var name: String
    var age: String
    var employed: String
}

func loadJson(filename fileName: String) -> [Person]? {
    if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let jsonData = try decoder.decode(ResponseData.self, from: data)
            return jsonData.person
        } catch {
            print("error:\(error)")
        }
    }
    return nil
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


}

