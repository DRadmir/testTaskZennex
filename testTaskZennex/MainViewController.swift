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
    
    private var workers = try! Realm().objects(Workers.self).sorted(by: (["type", "name"]))
    private var sectionNames: [String] {
        return Set(workers.value(forKeyPath: "type") as! [String]).sorted()
    }
    private var ascedningSorting = false
    
    @IBOutlet weak var sortingButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
 
    @IBAction func editTapped(_ sender: Any) {
    }
    
    @IBAction func sortedTapped(_ sender: Any) {
        
        if ascedningSorting {
            sortingButton.image = #imageLiteral(resourceName: "AZ")
        } else {
            sortingButton.image = #imageLiteral(resourceName: "ZA")
        }
        
        sorting()
    }
    
    @IBAction func unwindSegue(segue: UIStoryboardSegue) {

        guard let newWorkerVC = segue.source as? NewWorkerViewController else {return}
        newWorkerVC.saveWorkers()

        tableView.reloadData()
    }

    //MARK:- custom func
    func sorting() {
        workers = workers.sorted(byKeyPath: "surname", ascending: ascedningSorting)
        ascedningSorting.toggle()
        tableView.reloadData()
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
    
    //MARK: - section
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionNames.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionNames[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workers.filter("type == %@", sectionNames[section]).count
    }
    
    
    //MARK:- rows
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! StaffTableViewCell
        
        let info = workers.filter("type == %@", sectionNames[indexPath.section])[indexPath.row]
        cell.settingCell(data: info)
        
        return cell

    }
    
}

