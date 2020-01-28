//
//  NewWorkerViewController.swift
//  testTaskZennex
//
//  Created by Radmir Dzhurabaev on 26.01.2020.
//  Copyright © 2020 Radmir Dzhurabaev. All rights reserved.
//

import UIKit
import RealmSwift

class NewWorkerViewController: UIViewController {
    
    var currentWorker: Workers?
    private var type = "boss"
    private var typeAccountant = "salary"
    var id: Int?
    
    @IBOutlet weak var workersSegmentedControl: UISegmentedControl!
    @IBOutlet weak var typeAccountantSegmentedControl: UISegmentedControl!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var surnameTF: UITextField!
    @IBOutlet weak var patronymicTF: UITextField!
    @IBOutlet weak var salaryTF: UITextField!
    @IBOutlet weak var numberWorkplaceTF: UITextField!
    @IBOutlet weak var bussinessHoursTF: UITextField!
    @IBOutlet weak var lunchTimeTF: UITextField!
    
    @IBOutlet weak var numberWorkplaceStackView: UIStackView!
    @IBOutlet weak var bussinessHoursStackView: UIStackView!
    @IBOutlet weak var lunchTimeStackView: UIStackView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        bossInterfaceSetting()
        loadUserData()
//        print(currentWorker?.id)
    }
    
//    @IBAction func saveWorkersTapped(_ sender: Any) {
//        saveWorkers()
//        navigationController?.popViewController(animated: true)
//        dismiss(animated: true, completion: nil)
//    }

    @IBAction func cancelTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func workersSegmentedValueChanged(_ sender: Any) {

        switch workersSegmentedControl.selectedSegmentIndex {
        case 0:
            bossInterfaceSetting()
        case 1:
            staffInterfaceSetting()
        case 2:
            accountantInterfaceSetting()
        default:
            break
        }
    }
    
    @IBAction func typeAccountantSegmentedControlValueChanged(_ sender: UISegmentedControl) {
        switch typeAccountantSegmentedControl.selectedSegmentIndex {
        case 0:
            self.typeAccountant = "salary"
        case 1:
            self.typeAccountant = "accounting"
        default:
            break
        }
    }
    
    func saveWorkers() {
        
        switch workersSegmentedControl.selectedSegmentIndex {
        case 0:
            if nameTF.text == "" ||
                surnameTF.text == "" ||
                patronymicTF.text == "" ||
                salaryTF.text == "" ||
                bussinessHoursTF?.text == "" {
                
                showAlert(title: "Warning", message: "all fields must be filled")
                
            } else {
                
                saveWorker(type: type,
                           name: nameTF.text!,
                           surname: surnameTF.text!,
                           patronymic: patronymicTF.text!,
                           salary: Int(salaryTF.text!)!,
                           businessHuors: bussinessHoursTF.text!,
                           lunchTime: nil,
                           accountant: nil,
                           workplace: nil)
            }
            
        case 1:
            if nameTF.text == "" ||
                surnameTF.text == "" ||
                patronymicTF.text == "" ||
                salaryTF.text == "" ||
                lunchTimeTF.text == "" ||
                numberWorkplaceTF.text == "" {
                
                showAlert(title: "Warning", message: "all fields must be filled")
                
            } else {
                saveWorker(type: type,
                           name: nameTF.text!,
                           surname: surnameTF.text!,
                           patronymic: patronymicTF.text!,
                           salary: Int(salaryTF.text!)!,
                           businessHuors: nil,
                           lunchTime: lunchTimeTF.text!,
                           accountant: nil,
                           workplace: numberWorkplaceTF.text!)
            }
            
        case 2:
            if nameTF.text == "" ||
                surnameTF.text == "" ||
                patronymicTF.text == "" ||
                salaryTF.text == "" ||
                lunchTimeTF.text == "" ||
                numberWorkplaceTF.text == "" {
                
                showAlert(title: "Warning", message: "all fields must be filled")
                
            } else {
                saveWorker(type: type,
                           name: nameTF.text!,
                           surname: surnameTF.text!,
                           patronymic: patronymicTF.text!,
                           salary: Int(salaryTF.text!)!,
                           businessHuors: nil,
                           lunchTime: lunchTimeTF.text!,
                           accountant: typeAccountant,
                           workplace: numberWorkplaceTF.text!)
            }
        default:
            break
        }
        
    }
    
    private func saveWorker(type: String, name: String, surname: String, patronymic: String, salary: Int, businessHuors: String?, lunchTime: String?, accountant: String?, workplace: String?) {
        let id = incrementID()
        let newWorker = Workers(id: id,
                                order: id,
                                type: type,
                                name: name,
                                surname: surname,
                                patronymic: patronymic,
                                salary: salary,
                                businessHours: businessHuors,
                                lunchTime: lunchTime,
                                accountant: accountant,
                                workplace: workplace)
        if self.currentWorker != nil {
            try! realm.write {
                currentWorker?.type = newWorker.type
                currentWorker?.name = newWorker.name
                currentWorker?.surname = newWorker.surname
                currentWorker?.patronymic = newWorker.patronymic
                currentWorker?.salary = newWorker.salary
                currentWorker?.businessHours = newWorker.businessHours
                currentWorker?.lunchTime = newWorker.lunchTime
                currentWorker?.accountant = newWorker.accountant
                currentWorker?.workplace = newWorker.workplace

            }
        } else {
            StorageManager.saveObject(newWorker)
        }
    }
    
    private func bossInterfaceSetting() {
        typeAccountantSegmentedControl.isHidden = true
        numberWorkplaceStackView.isHidden = true
        bussinessHoursStackView.isHidden = false
        lunchTimeStackView.isHidden = true
        self.type = "boss"
    }
    
    private func staffInterfaceSetting() {
        typeAccountantSegmentedControl.isHidden = true
        numberWorkplaceStackView.isHidden = false
        bussinessHoursStackView.isHidden = true
        lunchTimeStackView.isHidden = false
        self.type = "staff"
    }
    
    private func accountantInterfaceSetting() {
        typeAccountantSegmentedControl.isHidden = false
        numberWorkplaceStackView.isHidden = false
        bussinessHoursStackView.isHidden = true
        lunchTimeStackView.isHidden = false
        self.type = "accountant"
    }
    
    private func setupEditScreen() {
        if currentWorker != nil {
            
            navigationItem.leftBarButtonItem = nil
            
            switch currentWorker?.type {
            case "boss":
                workersSegmentedControl.selectedSegmentIndex = 0
                bossInterfaceSetting()
            case "staff":
                 workersSegmentedControl.selectedSegmentIndex = 1
                staffInterfaceSetting()
            case "accountant":
                 workersSegmentedControl.selectedSegmentIndex = 2
                accountantInterfaceSetting()
            default:
                break
            }
            
            switch currentWorker?.type {
            case "accounting":
                typeAccountantSegmentedControl.selectedSegmentIndex = 0
            case "salary":
                typeAccountantSegmentedControl.selectedSegmentIndex = 1
            default:
                break
            }
            
            
            nameTF.text = currentWorker?.name
            surnameTF.text = currentWorker?.surname
            patronymicTF.text = currentWorker?.patronymic
            guard let salary = currentWorker?.salary else { return }
            salaryTF.text = "\(salary)"
            numberWorkplaceTF.text = currentWorker?.workplace
            bussinessHoursTF.text = currentWorker?.businessHours
            lunchTimeTF.text = currentWorker?.lunchTime
            
        }
    }
    
    private func loadUserData() {
        let realm = try! Realm()
        if id != nil {
            self.currentWorker = realm.objects(Workers.self).filter("id == \(self.id!)").first
            setupEditScreen()
        }
    }
    
    func incrementID() -> Int {
        let realm = try! Realm()
        return (realm.objects(Workers.self).max(ofProperty: "id") as Int? ?? 0) + 1
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
