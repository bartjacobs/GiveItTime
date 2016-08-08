//
//  ViewController.swift
//  CoreDataStack
//
//  Created by Bart Jacobs on 17/07/16.
//  Copyright © 2016 Cocoacasts. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var coreDataManager: CoreDataManager!

    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        print(coreDataManager.mainManagedObjectContext)
    }

}
