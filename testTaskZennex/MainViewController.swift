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
    
    private var workers = try! Realm().objects(Workers.self).sorted(by: (["order"]))
    private var sectionNames: [String] {
        return Set(workers.value(forKeyPath: "type") as! [String]).sorted()
    }
    private var ascedningSorting = false
    
    @IBOutlet weak var sortingButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
 
    @IBAction func editTapped(_ sender: Any) {
        self.tableView.isEditing = !self.tableView.isEditing
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
    private func sorting() {
        workers = workers.sorted(byKeyPath: "surname", ascending: ascedningSorting)
        ascedningSorting.toggle()
        tableView.reloadData()
    }
    
    //MARK- Navigation
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: - editing
    //delite
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        tableView.setEditing(editing, animated: animated)
    }

    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let worker = workers.filter("type == %@", sectionNames[indexPath.section])[indexPath.row]
            
            StorageManager.deliteObject(worker)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }

    //move
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath, toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath {
        let sourceSection = sourceIndexPath.section
        let destSection = proposedDestinationIndexPath.section
        
        if destSection < sourceSection {
            return IndexPath(row: 0, section: sourceSection)
        } else if destSection > sourceSection {
            return IndexPath(row: self.tableView(tableView, numberOfRowsInSection:sourceSection)-1, section: sourceSection)
        }
        
        return proposedDestinationIndexPath
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        try! realm.write {
            let sourceObject = workers.filter("type == %@", sectionNames[sourceIndexPath.section])[sourceIndexPath.row]
            let destinationObject = workers.filter("type == %@", sectionNames[sourceIndexPath.section])[destinationIndexPath.row]
            
            let destinationObjectOrder = destinationObject.order
            
            if sourceIndexPath.row < destinationIndexPath.row {
                
                for index in sourceIndexPath.row...destinationIndexPath.row {
                    let object = workers.filter("type == %@", sectionNames[sourceIndexPath.section])[index]
                    object.order -= 1
                }
            } else {
                
                for index in (destinationIndexPath.row..<sourceIndexPath.row).reversed() {
                    let object = workers.filter("type == %@", sectionNames[sourceIndexPath.section])[index]
                    object.order += 1
                }
            }
            
            sourceObject.order = destinationObjectOrder
        }
    }
    
    
}

