//
//  ViewController.swift
//  Seyehat Kitabım
//
//  Created by Erdo on 12.01.2019.
//  Copyright © 2019 Erdo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


    @IBAction func addButtonClicked(_ sender: Any) {
        self.performSegue(withIdentifier: "toMyDetailsVC", sender: nil)
    }
}

