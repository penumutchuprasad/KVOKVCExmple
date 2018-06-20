//ConfigurationManager.swift
/*
 * KVOKVCExmple
 * Created by penumutchu.prasad@gmail.com on 20/06/18
 * Is a product created by Leela Prasad
 * For the KVOKVCExmple in the KVOKVCExmple
 
 * Here the permission is granted to this file with free of use anywhere in the IOS Projects.
 * Copyright © 2018 ABNBoys.com All rights reserved.
*/

import Foundation

class ConfigurationManager: NSObject {
    
    // MARK: - Properties
    
   @objc dynamic var configuration: Configuration
    
    // MARK: -
    
    lazy private var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy:MM:dd HH:mm:ss"
        return dateFormatter
    }()
    
    // MARK: -
    
    var createdAt: String {
        return dateFormatter.string(from: configuration.createdAt)
    }
    
    var updatedAt: String {
        return dateFormatter.string(from: configuration.updatedAt)
    }
    
    // MARK: - Initialization
    
    init(withConfiguration configuration: Configuration) {
        self.configuration = configuration
        
        super.init()
    }
    
    // MARK: - Public Interface
    
   func updateConfiguration() {
        configuration.updatedAt = Date()
    }
    
}

