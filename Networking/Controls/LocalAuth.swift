//
//  LocalAuth.swift
//  Networking
//
//  Created by RomaDUlbich on 8/23/19.
//  Copyright © 2019 Oleg1. All rights reserved.
//

import Foundation
import LocalAuthentication
class Biometrical{
    var context = LAContext()
    var loginReason = "Logging in with ;Touch ID"
    
    func canEvaluatePolicy() -> Bool{
            return context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil)
        
    }
    
 
}
