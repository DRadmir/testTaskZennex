//
//  NewWorkerViewController.swift
//  testTaskZennex
//
//  Created by Radmir Dzhurabaev on 26.01.2020.
//  Copyright © 2020 Radmir Dzhurabaev. All rights reserved.
//

import UIKit

class NewWorkerViewController: UIViewController {
    
    var currentWorkers: Workers!
    var type: TypeWorker!
    
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
    }
    
    @IBAction func saveWorkersTapped(_ sender: Any) {
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
    }
    
    func saveWorkers() {
        
        switch workersSegmentedControl.selectedSegmentIndex {
        case 0:
            let newWorker = Workers(type: type,
                                    name: nameTF.text!,
                                    surname: surnameTF.text!,
                                    patronymic: patronymicTF.text!,
                                    salary: Int(salaryTF.text!)!,
                                    businessHours: <#T##Boss#>,
                                    lunchTime: nil,
                                    accountant: nil,
                                    workplace: nil)
        case 1:
            <#code#>
        case 2:
            <#code#>
        default:
            <#code#>
        }
        
    }
    
    func bossInterfaceSetting() {
        typeAccountantSegmentedControl.isHidden = true
        numberWorkplaceStackView.isHidden = true
        bussinessHoursStackView.isHidden = false
        lunchTimeStackView.isHidden = true
        self.type = TypeWorker(type: "boss")
    }
    
    func staffInterfaceSetting() {
        typeAccountantSegmentedControl.isHidden = true
        numberWorkplaceStackView.isHidden = false
        bussinessHoursStackView.isHidden = true
        lunchTimeStackView.isHidden = false
        self.type = TypeWorker(type: "staff")
    }
    
    func accountantInterfaceSetting() {
        typeAccountantSegmentedControl.isHidden = false
        numberWorkplaceStackView.isHidden = false
        bussinessHoursStackView.isHidden = true
        lunchTimeStackView.isHidden = false
        self.type = TypeWorker(type: "accountant")
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
