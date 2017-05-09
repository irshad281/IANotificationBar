//
//  ViewController.swift
//  IANotificationBar
//
//  Created by preeti rani on 09/05/17.
//  Copyright © 2017 Innotical. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func clickOnShowMessage(_ sender: Any) {
        IANotificationBar.sharedInstance.showMessage(title: "Hello", description: "Hello This is a Simple Text Message to notify Your User's")
    }

    @IBAction func showMessageWithCallBack(_ sender: Any) {
        IANotificationBar.sharedInstance.profileImage = #imageLiteral(resourceName: "Profile")
        IANotificationBar.sharedInstance.showMessagewithHandler(title: "Hello", description: "Hello This is a Simple Text Message to notify Your User's This is a Dummy Text Hello 🇮🇳 ") { (completed) in
            let alertController = UIAlertController.init(title: "Tapped", message: nil, preferredStyle: .alert)
            let okAction = UIAlertAction.init(title: "You Tapped on Message!", style: .default, handler: nil)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
}

