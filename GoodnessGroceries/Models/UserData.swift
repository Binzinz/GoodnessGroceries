//
//  UserData.swift
//  GoodnessGroceries
//
//  Created by Benjamin FORNAGE on 03/02/2022.
//  Copyright © 2022 Flavio Matias. All rights reserved.
//

import Foundation
struct UserData: Decodable {
    var status: UserStatus
    var phase1_date: String?
    var phase2_date: String?
}
