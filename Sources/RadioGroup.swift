//
//  RadioGroup.swift
//  RadioGroup
//
//  Created by Yonat Sharon on 03.02.2019.
//

import SweeterSwift
import UIKit

@IBDesignable open class RadioGroup: UIControl {
    public convenience init(titles: [String]) {
        self.init(frame: .zero)
        self.titles = titles
    }

    open var titles: [String] = [] {
        didSet {
            stackView.removeAllArrangedSubviewsCompletely()
            stackView.addArrangedSubviews(titles.map { RadioGroupItem(title: $0, group: self) })

            // update every forEachItem
            selectedColor = { selectedColor }()
            buttonSize = { buttonSize }()
            itemSpacing = { itemSpacing }()
            isButtonAfterTitle = { isButtonAfterTitle }()
            titleAlignment = { titleAlignment }()
            selectedIndex = { selectedIndex }()
        }
    }

    @IBInspectable open var selectedIndex: Int = -1 {
        didSet {
            item(at: oldValue)?.radioButton.isSelected = false
            item(at: selectedIndex)?.radioButton.isSelected = true
        }
    }

    @IBInspectable open dynamic var selectedColor: UIColor? {
        didSet {
            forEachItem { $0.radioButton.selectedColor = selectedColor }
        }
    }

    @IBInspectable open dynamic var buttonSize: CGFloat = 20 {
        didSet {
            forEachItem { $0.radioButton.size = buttonSize }
        }
    }

    @IBInspectable open dynamic var spacing: CGFloat = 8 {
        didSet {
            stackView.spacing = spacing
        }
    }

    @IBInspectable open dynamic var itemSpacing: CGFloat = 4 {
        didSet {
            forEachItem { $0.stackView.spacing = itemSpacing }
        }
    }

    @IBInspectable open dynamic var isButtonAfterTitle: Bool = false {
        didSet {
            let direction: UISemanticContentAttribute = isButtonAfterTitle ? .forceRightToLeft : .unspecified
            forEachItem { $0.stackView.semanticContentAttribute = direction }
        }
    }

    @IBInspectable open dynamic var titleColor: UIColor? {
        didSet {
            guard titleColor != oldValue else { return }
            forEachItem { $0.titleLabel.textColor = titleColor }
        }
    }

    @objc open dynamic var titleAlignment: NSTextAlignment = .natural {
        didSet {
            forEachItem { $0.titleLabel.textAlignment = titleAlignment }
        }
    }

    @objc open dynamic var titleFont: UIFont? {
        didSet {
            guard titleFont != oldValue else { return }
            let newFont = titleFont ?? UIFont.systemFont(ofSize: UIFont.labelFontSize)
            forEachItem { $0.titleLabel.font = newFont }
        }
    }

    // MARK: - Private

    private let stackView = UIStackView()

    private func setup() {
        addConstrainedSubview(stackView, constrain: .leftMargin, .rightMargin, .topMargin, .bottomMargin)
        stackView.axis = .vertical
        setContentCompressionResistancePriority(.required, for: .vertical)
        spacing = { spacing }()
        accessibilityIdentifier = "RadioGroup"
    }

    private func item(at index: Int) -> RadioGroupItem? {
        guard index >= 0 && index < stackView.arrangedSubviews.count else { return nil }
        return stackView.arrangedSubviews[index] as? RadioGroupItem
    }

    private func forEachItem(_ perform: (RadioGroupItem) -> Void) {
        stackView.arrangedSubviews.compactMap { $0 as? RadioGroupItem }.forEach(perform)
    }

    func selectIndex(item: RadioGroupItem) {
        guard let index = stackView.arrangedSubviews.firstIndex(of: item) else { return }
        selectedIndex = index
        sendActions(for: [.valueChanged, .primaryActionTriggered])
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    open override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        titles = ["First Option", "Second Option", "Third"]
    }
}

class RadioGroupItem: UIView {
    let titleLabel = UILabel()
    let radioButton = RadioButton()
    let stackView = UIStackView()

    unowned var group: RadioGroup

    init(title: String, group: RadioGroup) {
        self.group = group
        super.init(frame: .zero)

        titleLabel.numberOfLines = 0
        titleLabel.text = title
        if let titleFont = group.titleFont {
            titleLabel.font = titleFont
        }
        if let titleColor = group.titleColor {
            titleLabel.textColor = titleColor
        }

        addConstrainedSubview(stackView, constrain: .left, .right, .top, .bottom)
        stackView.addArrangedSubviews([radioButton, titleLabel])
        stackView.alignment = .center
        setContentCompressionResistancePriority(.required, for: .vertical)

        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didSelect)))

        isAccessibilityElement = true
        accessibilityLabel = "option"
        accessibilityValue = title
        accessibilityIdentifier = "RadioGroupItem"
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func didSelect() {
        group.selectIndex(item: self)
    }

    override var accessibilityTraits: UIAccessibilityTraits {
        get {
            return radioButton.isSelected ? [.selected] : []
        }
        set {} // swiftlint:disable:this unused_setter_value
    }
}

extension UIStackView {
    func addArrangedSubviews(_ subviews: [UIView]) {
        for subview in subviews {
            addArrangedSubview(subview)
        }
    }
}
