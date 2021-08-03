//
//  UserInformation.swift
//  SignUpWork
//
//  Created by 김인환 on 2021/08/04.
//

import Foundation
import UIKit

class UserInformation {
    static let shared: UserInformation = UserInformation()
    
    private init() { }
    
    var image: UIImage?
    var id: String?
    var password: String?
    var description: String?
    var phoneNumber: String?
    var birthDay: Date?
    
    func clearFields() {
        self.image = nil
        self.id = nil
        self.password = nil
        self.description = nil
        self.phoneNumber = nil
        self.birthDay = nil
    }
}
