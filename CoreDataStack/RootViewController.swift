//
//  RootViewController.swift
//  CoreDataStack
//
//  Created by Bart Jacobs on 17/07/16.
//  Copyright © 2016 Cocoacasts. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {

    // MARK: - Properties

    private var coreDataManager: CoreDataManager?

    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        if coreDataManager != nil {
            setupView()

        } else {
            coreDataManager = CoreDataManager(modelName: "DataModel", completion: {
                self.setupView()
            })
        }
    }

    // MARK: - View Methods

    private func setupView() {
        view.backgroundColor = .red
    }

}
