//
//  ViewController.swift
//  Operations
//
//  Created by Евгений Сабина on 7.05.24.
//

import UIKit

class ViewController: UIViewController {

        @IBOutlet weak var label1: UILabel!
        @IBOutlet weak var label2: UILabel!
        @IBOutlet weak var label3: UILabel!

        let operationQueue = OperationQueue()
        let operation2 = BlockOperation()

        @IBAction func startOperations(_ sender: UIButton) {
            
            let operation1 = BlockOperation {
                for i in 1...10 {
                  
                    
                    DispatchQueue.main.async {
                        self.label1.text = "\(i)"
                    }
                    sleep(1)
                }
            }

            let operation2 = BlockOperation {
                for i in 11...25 {
                    if self.operation2.isCancelled {
                                        return
                  }
                    DispatchQueue.main.async {
                        self.label2.text = "\(i)"
                    }
                    sleep(1)
                }
            }
            operation2.addDependency(operation1)

            let operation3 = BlockOperation {
                while !operation2.isFinished {
                    DispatchQueue.main.async {
                        self.label3.text = "Задача 3"
                        self.label3.backgroundColor = self.label3.backgroundColor == UIColor.red ? UIColor.green : UIColor.red
                    }
                    sleep(2)
                }
            }
            operation3.addDependency(operation1)

            operationQueue.addOperations([operation1, operation2, operation3], waitUntilFinished: false)
                }

                @IBAction func stopOperation1(_ sender: UIButton) {
                    operation2.cancel()
                }
        
 
    @IBAction func stopall(_ sender: UIButton) {
        
        operationQueue.cancelAllOperations() 
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

}


