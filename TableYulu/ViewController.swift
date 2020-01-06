//
//  ViewController.swift
//  TableYulu
//
//  Created by Aditya Ashok on 06/01/20.
//  Copyright © 2020 Aditya Ashok. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    @IBOutlet weak var tableView1: UITableView!
    @IBOutlet weak var tableView2: UITableView!
    
    var list1:[JsonModel] = []
    var list2:[JsonModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.tableView1.delegate = self
        self.tableView2.delegate = self
        self.tableView1.dataSource = self
        self.tableView2.dataSource = self
        readJSON()
        
    }
    
   func numberOfSections(in tableView: UITableView) -> Int {
           return 1
       }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return tableView == tableView1 ? 20: list2.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        var returnCell = UITableViewCell()
       
        if tableView == tableView1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "firstCell", for: indexPath)
            
            let person: JsonModel = list1[indexPath.row]
            cell.textLabel?.text = person.title + " ST : " + person.subTitle
            returnCell = cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "secondCell", for: indexPath)
            let person: JsonModel = list2[indexPath.row]
            cell.textLabel?.text = person.title + " ST : " + person.subTitle
            
            
            returnCell = cell
        }
        return returnCell
    }
    
    
    
    func readJSON()  {
        
       if let path = Bundle.main.path(forResource: "SampleJson", ofType: "json") {
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
            if let jsonResult = jsonResult as? Dictionary<String, AnyObject>, let persons = jsonResult["list"] as? [Any] {
                
                
                if persons.count < 20{
                    for p in persons{
                        let dict = p as! Dictionary<String, String>
                        let title = dict["title"]! as String
                        let subtitle = dict["subtitle"]! as String

                        let person:JsonModel = JsonModel(title: title, subTitle: subtitle)
                        list1.append(person)
                    }
                }else{
                    
                    let array1 = persons[0...20]
                    let array2 = persons[20..<persons.count]
                    
                    for p in array1{
                        let dict = p as! Dictionary<String, String>
                        let title = dict["title"]! as String
                        let subtitle = dict["subtitle"]! as String
                        
                        let person:JsonModel = JsonModel(title: title, subTitle: subtitle)
                        list1.append(person)
                    }
                    
                    for p in array2{
                        let dict = p as! Dictionary<String, String>
                        let title = dict["title"]! as String
                        let subtitle = dict["subtitle"]! as String
                        
                        let person:JsonModel = JsonModel(title: title, subTitle: subtitle)
                        list2.append(person)
                    }
                    
                }
            }
        
        } catch {
                   // handle error
              }
        }
    }

}

