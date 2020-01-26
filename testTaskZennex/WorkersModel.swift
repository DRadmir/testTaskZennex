//
//  WorkersModel.swift
//  testTaskZennex
//
//  Created by Radmir Dzhurabaev on 26.01.2020.
//  Copyright © 2020 Radmir Dzhurabaev. All rights reserved.
//

import RealmSwift

class Workers: Object {
    
    let type = List<Type>()
    @objc dynamic var name = ""
    @objc dynamic var surname = ""
    @objc dynamic var patronymic = ""
    @objc dynamic var salary = 0.0
    @objc dynamic var businessHours: Boss? = nil
    @objc dynamic var lunchTime: String? = nil
    @objc dynamic var accountant: AccountantType? = nil
    dynamic var workplace = RealmOptional<Int>()


    convenience init(type: [Type], name: String, surname: String, patronymic: String, salary: Double, businessHours: Boss, lunchTime: String, accountant: AccountantType, workplace: Int) {
        self.init()
        self.type.append(objectsIn: type)
        self.name = name
        self.surname = surname
        self.patronymic = patronymic
        self.salary = salary
        self.businessHours = businessHours
        self.lunchTime = lunchTime
        self.accountant = accountant
        self.workplace.value = workplace
        
    }
}

class Type: Object {
    
    @objc dynamic var type: String? = nil
    
    convenience init(type: String) {
        self.init()
        self.type = type
    }

}

class Boss: Object {
    @objc dynamic var workHouse = ""
    
    convenience init(workHouse: String) {
        self.init()
        self.workHouse = workHouse
    }
}

class AccountantType: Object {
    
    @objc dynamic var accountantType: String? = nil
    
    convenience init(accountantType: String) {
        self.init()
        self.accountantType = accountantType
    }
    
}
