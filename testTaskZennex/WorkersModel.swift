//
//  WorkersModel.swift
//  testTaskZennex
//
//  Created by Radmir Dzhurabaev on 26.01.2020.
//  Copyright © 2020 Radmir Dzhurabaev. All rights reserved.
//

import RealmSwift

class Workers: Object {
    
    @objc dynamic var type: String? = nil
    @objc dynamic var id = 0
    @objc dynamic var order = 0
    @objc dynamic var name = ""
    @objc dynamic var surname = ""
    @objc dynamic var patronymic = ""
    @objc dynamic var salary = 0
    @objc dynamic var businessHours: String? = nil
    @objc dynamic var lunchTime: String? = nil
    @objc dynamic var accountant: String? = nil
    @objc dynamic var workplace: String? = nil

    override class func primaryKey() -> String? {
        return "id"
    }

    convenience init(id: Int, order: Int, type: String?, name: String, surname: String, patronymic: String, salary: Int, businessHours: String?, lunchTime: String?, accountant: String?, workplace: String?) {
        self.init()
        self.id = id
        self.order = order
        self.type = type
        self.name = name
        self.surname = surname
        self.patronymic = patronymic
        self.salary = salary
        self.businessHours = businessHours
        self.lunchTime = lunchTime
        self.accountant = accountant
        self.workplace = workplace
        
    }

}
