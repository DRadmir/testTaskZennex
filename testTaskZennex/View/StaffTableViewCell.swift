//
//  StaffTableViewCell.swift
//  testTaskZennex
//
//  Created by Radmir Dzhurabaev on 26.01.2020.
//  Copyright © 2020 Radmir Dzhurabaev. All rights reserved.
//

import UIKit

class StaffTableViewCell: UITableViewCell {
    
    @IBOutlet weak var workerImageView: UIImageView! {
        didSet {
            workerImageView.layer.cornerRadius = workerImageView.frame.size.height / 2
            workerImageView.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var fioLabel: UILabel!
    @IBOutlet weak var salaryLabel: UILabel!
    @IBOutlet weak var numberWorkplaceLabel: UILabel!
    @IBOutlet weak var lunchOrTypeLabel: UILabel!
    

    func getBossData(data: Workers) {
        
        switch data.type {
        case "boss":
            fioLabel.text = "\(data.surname)" + " " + "\(data.name)" + " " + "\(data.patronymic)"
            salaryLabel.text = "salary: \(data.salary) $"
            guard let businessHours = data.businessHours else { return }
            numberWorkplaceLabel.text = "business hours: \(businessHours)"
            lunchOrTypeLabel.isHidden = true
        case "staff":
            fioLabel.text = "\(data.surname)" + " " + "\(data.name)" + " " + "\(data.patronymic)"
            salaryLabel.text = "salary: \(data.salary) $"
            guard let numberWorkplace = data.workplace, let lunchTime = data.lunchTime else { return }
            numberWorkplaceLabel.text = "number workspace: \(numberWorkplace)"
            lunchOrTypeLabel.isHidden = false
            lunchOrTypeLabel.text = "lunch: \(lunchTime)"
        case "accountant":
            fioLabel.text = "\(data.surname)" + " " + "\(data.name)" + " " + "\(data.patronymic)"
            salaryLabel.text = "salary: \(data.salary) $"
            guard let numberWorkplace = data.workplace, let typeAcc = data.accountant else { return }
            numberWorkplaceLabel.text = "number workspace: \(numberWorkplace)"
            lunchOrTypeLabel.isHidden = false
            lunchOrTypeLabel.text = "type: \(typeAcc)"
        default:
            break
        }

    }

}
