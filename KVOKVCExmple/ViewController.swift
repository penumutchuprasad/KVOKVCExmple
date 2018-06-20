//
/*
 
 * KVOKVCExmple
 * Created by: Leela Prasad on 18/06/18
 
 * Copyright © 2018 Leela Prasad. All rights reserved.
 * All rights have been granted for free of use for any project in SecNinjaz
 
 */

import UIKit



class ViewController: UIViewController {
    
    //Example 1
    
    @IBOutlet var timeLbl: UILabel!
    
    @objc var configManager: ConfigurationManager!
    
    //Example 2
    
    var child1: Children!
    var child2: Children!
    var child3: Children!
    
    var child1Context = UnsafeMutableRawPointer.allocate(byteCount: 4 * 4, alignment: 1)
    var child2Context = UnsafeMutableRawPointer.allocate(byteCount: 4 * 4, alignment: 2)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //Example 1
        
        self.configManager = ConfigurationManager.init(withConfiguration: Configuration())
        
        // by providing 'initial' in the options array, observeValue() method triggers immediately.
        /**
         * Here we are not providing context parameter.
         * If we want to pass context parameter, we need to define the UIUnsafeMutablePointer type in global / static keyword. So You can use the same pointer every time the change occurs in the observing value.
         * http://michael-brown.net/2017/swift-and-kvo-context-variables/
         */
        self.addObserver(self, forKeyPath: #keyPath(configManager.configuration.updatedAt), options: [.old, .new, .initial], context: nil)
        
        
        //Example 2
        
        self.child1 = Children()
        
        // Normal way of assigning
//
//        self.child1.name = "LEELA KRISHNA"
//        self.child1.age = 28
        
        // Using KVC
        
        self.child1.setValue("LEELA PRASAD", forKey: "name")
        self.child1.setValue(28, forKey: "age")
        
        let myNAme = self.child1.value(forKey: "name") as! String
        let myAge = self.child1.value(forKey: "age") as! Int
        
        print(myNAme)
        print(myAge)
        
        
        
        self.child2 = Children.init()
        self.child2.child = Children.init()
        
        self.child2.setValue("Sarah", forKey: "name")
        self.child2.setValue(25, forKey: "age")
        
        self.child2.setValue("Sansa", forKeyPath: "child.name")
        self.child2.setValue(5, forKeyPath: "child.age")
        
        //    print(self.child2.child?.name)
        //    print(self.child2.child?.age)
        
        
        self.child3 = Children.init()
        self.child3.child = Children.init()
        self.child3.child?.child = Children.init()
        
        self.child3.setValue("Mark", forKeyPath: "child.child.name")
        self.child3.setValue(20, forKeyPath: "child.child.age")
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        self.child1.addObserver(self, forKeyPath: "name", options:[.new, .old], context: child1Context)
        self.child1.addObserver(self, forKeyPath: "age", options: [.new, .old], context: child1Context)
        

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.child1.removeObserver(self, forKeyPath: "name", context: child1Context)
        self.child1.removeObserver(self, forKeyPath: "age", context: child1Context)
        
        //Example 1
        
        self.removeObserver(self, forKeyPath: #keyPath(configManager.configuration.updatedAt), context: nil)
        
        
    }
    
//    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
//
//        if keyPath == "name" {
//
//            print("child Name is changed")
//            print(change![NSKeyValueChangeKey.newKey] as! String)
//            print(change![NSKeyValueChangeKey.oldKey] as! String)
//
//        }
//
//        if keyPath == "age" {
//
//            print("child Age is changed")
//            print(change!)
//        }
//
//
//    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        //Example 2

        if context == child1Context {

            if keyPath == "name" {

                print("child 1 Name is changed")
                print(change![NSKeyValueChangeKey.newKey] as! String)
                print(change![NSKeyValueChangeKey.oldKey] as! String)

            }

            if keyPath == "age" {

                print("child 1 Age is changed")
                print(change!)
            }

        } else if context == child2Context {

            if keyPath == "age" {

                print("child2 Age is changed")
                print(change!)
            }

            self.child2.removeObserver(self, forKeyPath: "age", context: child2Context)

        }else {
            //print("context is not needed")
            //Example 1
            
            if keyPath == #keyPath(configManager.configuration.updatedAt) {
                
                self.timeLbl.text = String.init(describing: configManager.updatedAt)
            }
        }

    }

    override class func automaticallyNotifiesObservers(forKey key: String) -> Bool {
        
        
        return true
    }
    
  
    
    
    @IBAction func onChangeSelected(_ sender: UIButton) {
        
        //Example 1
        
        self.configManager.updateConfiguration()
        
        //Example 2
        
//        self.child1.willChangeValue(forKey: "name")
//        self.child1.name = "Dariooooo"
//        self.child1.didChangeValue(forKey: "name")
        
        //or
        
        self.child1.setName(name: "Dariooooo")

        self.child1.age = 25
        
//        self.child2.addObserver(self, forKeyPath: "age", options: [.new, .old], context: nil)
//        self.child2.setValue(23, forKey: "age")
        
        
        self.child2.addObserver(self, forKeyPath: "age", options: [.new, .old], context: child2Context)
        
        self.child2.age = 999
        
    }
    
    
    
}

