//
//  ViewController.swift
//  RadioGroupDemo
//
//  Created by Yonat Sharon on 03.02.2019.
//  Copyright © 2019 Yonat Sharon. All rights reserved.
//

import RadioGroup
import UIKit

class ViewController: UIViewController {

    @IBOutlet var radioGroup: RadioGroup!
    @IBOutlet var secondGroup: RadioGroup!

    override func viewDidLoad() {
        super.viewDidLoad()

        radioGroup.titles = ["One", "Two", "Last"]
        secondGroup.titles = [
            "Lorem ipsum dolor sit amet",
            "consectetur adipiscing elit",
            "sed do eiusmod tempor incididunt",
            "ut labore et dolore magna aliqua",
        ]

        radioGroup.addTarget(self, action: #selector(didSelectOption(radioGroup:)), for: .valueChanged)
    }

    @objc func didSelectOption(radioGroup: RadioGroup) {
        print(radioGroup.titles[radioGroup.selectedIndex])
    }
}
