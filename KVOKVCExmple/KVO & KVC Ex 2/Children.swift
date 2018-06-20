//
/*
 
 * KVOKVCExmple
 * Created by: Leela Prasad on 18/06/18
 
 * Copyright © 2018 Leela Prasad. All rights reserved.
 * All rights have been granted for free of use for any project in SecNinjaz
 
 */

import Foundation


class Children: NSObject {
    
    @objc dynamic var name: String!
    @objc dynamic var age: Int
    
    @objc dynamic var child: Children?
    
    @objc dynamic var siblings: [String]!
    
    
    override init() {
        
        self.name = ""
        self.age = 0
        //    self.child = Children()
        self.siblings = [String]()
        super.init()
        
    }
    
    func setName(name: String) {
        self.willChangeValue(forKey: "name")
        self.name = name
        self.didChangeValue(forKey: "name")
    }
    

  
    override class func automaticallyNotifiesObservers(forKey key: String) -> Bool {
        
        if key == "name" {
            
            return false
        } else {
            
            return super.automaticallyNotifiesObservers(forKey: key)

        }
        
    }
    
    //For KVO for Array
    
    func countOfSiblings() {
    
    }
    
    func insert(_ anObject: Any, at index: Int) {
        
        
        
    }
    

  
  
}
