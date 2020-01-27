//
//  ViewController.swift
//  testTaskZennex
//
//  Created by Radmir Dzhurabaev on 26.01.2020.
//  Copyright © 2020 Radmir Dzhurabaev. All rights reserved.
//

import UIKit
import RealmSwift

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let workers = try! Realm().objects(Workers.self).sorted(by: (["type", "name"]))
    var sectionNames: [String] {
        return Set(workers.value(forKeyPath: "type") as! [String]).sorted()
    }
    
    @IBOutlet weak var tableView: UITableView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
 
    @IBAction func editTapped(_ sender: Any) {
    }
    @IBAction func sortedTapped(_ sender: Any) {
    }

    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionNames.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionNames[section]
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workers.filter("type == %@", sectionNames[section]).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! StaffTableViewCell
        
        let info = workers.filter("type == %@", sectionNames[indexPath.section])[indexPath.row]
        cell.settingCell(data: info)
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "showDetail" {

            guard let indexPath = tableView.indexPathForSelectedRow else {return}

            let info = workers.filter("type == %@", sectionNames[indexPath.section])[indexPath.row]
            let id = info.id

            let newWorkerVC = segue.destination as! NewWorkerViewController
            newWorkerVC.id = id
        }
    }
    


}

