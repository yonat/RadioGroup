//
//  ViewController.swift
//  RadioGroupDemo
//
//  Created by Yonat Sharon on 03.02.2019.
//  Copyright © 2019 Yonat Sharon. All rights reserved.
//

import RadioGroup
import UIKit

#if canImport(SwiftUI)
import SwiftUI
#endif

class ViewController: UIViewController {
    @IBOutlet var radioGroup: RadioGroup!
    @IBOutlet var secondGroup: RadioGroup!
    @IBOutlet var showSwiftUIButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        radioGroup.titles = ["One", "Two", "Last"]
        secondGroup.attributedTitles = [
            NSAttributedString(string: "Lorem ipsum dolor sit amet"),
            NSAttributedString(string: "consectetur adipiscing elit", attributes: [.strokeWidth: -3.0]),
            NSAttributedString(string: "sed do eiusmod tempor incididunt", attributes: [.obliqueness: 0.3]),
            NSAttributedString(string: "ut labore et dolore magna aliqua", attributes: [.underlineStyle: 2, .underlineColor: secondGroup.tintColor ?? .orange]),
        ]

        radioGroup.addTarget(self, action: #selector(didSelectOption(radioGroup:)), for: .valueChanged)

        secondGroup.titleFont = UIFont(name: "Courier", size: UIFont.labelFontSize)
        secondGroup.titleColor = .brown
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if #available(iOS 13.0, *) {
            showSwiftUIButton.isHidden = false
            showSwiftUIButton.layer.borderWidth = 1
            showSwiftUIButton.layer.cornerRadius = showSwiftUIButton.frame.height / 2
            showSwiftUIButton.layer.borderColor = view.actualTintColor.cgColor
        }
    }

    @objc func didSelectOption(radioGroup: RadioGroup) {
        print(radioGroup.titles[radioGroup.selectedIndex] ?? "")
    }

    @IBAction func showSwiftUIDemo() {
        #if canImport(SwiftUI)
        if #available(iOS 13.0, *) {
            present(UIHostingController(rootView: RadioGroupPickerDemo()), animated: true)
        }
        #endif
    }
}
