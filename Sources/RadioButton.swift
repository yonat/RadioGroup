//
//  RadioButton.swift
//  RadioGroup
//
//  Created by Yonat Sharon on 03.02.2019.
//

import UIKit

@IBDesignable open class RadioButton: UIView {
    @IBInspectable open var isSelected: Bool = false {
        didSet {
            selectedCenterView.isHidden = !isSelected
        }
    }

    @IBInspectable open var size: CGFloat = 20 {
        didSet {
            constrain(.height, to: size)
            layer.cornerRadius = size / 2
            updateCenterRadius()
        }
    }

    @IBInspectable open var ringWidth: CGFloat = 2 {
        didSet {
            layer.borderWidth = ringWidth
        }
    }

    @IBInspectable open var ringSpacing: CGFloat = 4 {
        didSet {
            layoutMargins = UIEdgeInsets(top: ringSpacing, left: ringSpacing, bottom: ringSpacing, right: ringSpacing)
            updateCenterRadius()
        }
    }

    @IBInspectable open var selectedColor: UIColor? {
        didSet {
            selectedCenterView.backgroundColor = selectedColor ?? actualTintColor
        }
    }

    private let selectedCenterView = UIView()

    private func setup() {
        constrain(self, at: .width, to: self, at: .height)
        addConstrainedSubview(selectedCenterView, constrain: .topMargin, .bottomMargin, .leftMargin, .rightMargin)
        selectedCenterView.layoutMargins = .zero
        selectedColor = { selectedColor }()
        size = { size }()
        ringWidth = { ringWidth }()
        ringSpacing = { ringSpacing }()
        isSelected = { isSelected }()
        tintColorDidChange()
    }

    private func updateCenterRadius() {
        selectedCenterView.layer.cornerRadius = (size - layoutMargins.bottom - layoutMargins.top) / 2
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    open override func tintColorDidChange() {
        super.tintColorDidChange()
        let newTint = actualTintColor
        layer.borderColor = newTint.cgColor
        if nil == selectedColor {
            selectedCenterView.backgroundColor = newTint
        }
    }
}

extension UIView {
    var actualTintColor: UIColor {
        var tintedView: UIView? = self
        while let currentView = tintedView, nil == currentView.tintColor {
            tintedView = currentView.superview
        }
        return tintedView?.tintColor ?? .blue
    }
}
