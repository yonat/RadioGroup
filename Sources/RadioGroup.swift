//
//  RadioGroup.swift
//  RadioGroup
//
//  Created by Yonat Sharon on 03.02.2019.
//

import MiniLayout
import UIKit

@IBDesignable open class RadioGroup: UIControl {
    public convenience init(titles: [String]) {
        self.init(frame: .zero)
        self.titles = titles
    }

    public convenience init(attributedTitles: [NSAttributedString]) {
        self.init(frame: .zero)
        self.attributedTitles = attributedTitles
    }

    open var titles: [String] = [] {
        didSet {
            stackView.removeAllArrangedSubviews()
            stackView.addArrangedSubviews(titles.map { RadioGroupItem(title: $0, group: self) })

            updateProperties()
        }
    }

    open var attributedTitles: [NSAttributedString] = [] {
        didSet {
            titles = attributedTitles.map { $0.string }
            
            stackView.removeAllArrangedSubviews()
            stackView.addArrangedSubviews(attributedTitles.map { RadioGroupItem(attributedTitle: $0, group: self) })

            updateProperties()
        }
    }

    private func updateProperties() {
        // update every forEachItem
        selectedColor = { selectedColor }()
        selectedRingColor = { selectedRingColor }()
        normalRingColor = { normalRingColor }()
        buttonSize = { buttonSize }()
        itemSpacing = { itemSpacing }()
        isButtonAfterTitle = { isButtonAfterTitle }()
        titleAlignment = { titleAlignment }()
        selectedIndex = { selectedIndex }()
    }

    @IBInspectable open var selectedIndex: Int = -1 {
        didSet {
            item(at: oldValue)?.radioButton.isSelected = false
            item(at: selectedIndex)?.radioButton.isSelected = true
        }
    }

    @IBInspectable open var selectedColor: UIColor? {
        didSet {
            forEachItem { $0.radioButton.selectedColor = selectedColor }
        }
    }

    @IBInspectable open var selectedRingColor: UIColor? {
        didSet {
            forEachItem { $0.radioButton.selectedRingColor = selectedRingColor }
        }
    }

    @IBInspectable open var normalRingColor: UIColor? {
        didSet {
            forEachItem { $0.radioButton.normalRingColor = normalRingColor }
        }
    }

    @IBInspectable open var buttonSize: CGFloat = 20 {
        didSet {
            forEachItem { $0.radioButton.size = buttonSize }
        }
    }

    @IBInspectable open var spacing: CGFloat = 8 {
        didSet {
            stackView.spacing = spacing
        }
    }

    @IBInspectable open var itemSpacing: CGFloat = 4 {
        didSet {
            forEachItem { $0.stackView.spacing = itemSpacing }
        }
    }
    
    @IBInspectable open var itemStackViewAlignment: UIStackView.Alignment = .fill {
        didSet {
            forEachItem { $0.stackView.alignment = itemStackViewAlignment }
        }
    }
    
    @IBInspectable open var multilineLabels: Bool = true {
        didSet {
            forEachItem { $0.titleLabel.numberOfLines = multilineLabels ? 0 : 1 }
        }
    }

    @IBInspectable open var isButtonAfterTitle: Bool = false {
        didSet {
            let direction: UISemanticContentAttribute = isButtonAfterTitle ? .forceRightToLeft : .unspecified
            forEachItem { $0.stackView.semanticContentAttribute = direction }
        }
    }

    @IBInspectable open var titleColor: UIColor? {
        didSet {
            guard titleColor != oldValue else { return }
            forEachItem { $0.titleLabel.textColor = titleColor }
        }
    }

    open var titleAlignment: NSTextAlignment = .natural {
        didSet {
            forEachItem { $0.titleLabel.textAlignment = titleAlignment }
        }
    }

    open var titleFont: UIFont? {
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
        stackView.arrangedSubviews.compactMap { $0 as? RadioGroupItem } .forEach(perform)
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
        accessibilityValue = title

        titleLabel.text = title
        if let titleFont = group.titleFont {
            titleLabel.font = titleFont
        }
        if let titleColor = group.titleColor {
            titleLabel.textColor = titleColor
        }

        commonInit()
    }

    init(attributedTitle: NSAttributedString, group: RadioGroup) {
        self.group = group
        super.init(frame: .zero)
        accessibilityValue = attributedTitle.string

        titleLabel.attributedText = attributedTitle

        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func commonInit() {
        titleLabel.numberOfLines = group.multilineLabels ? 0 : 1
        stackView.alignment = group.itemStackViewAlignment
        addConstrainedSubview(stackView, constrain: .left, .right, .top, .bottom)
        stackView.addArrangedSubviews([radioButton, titleLabel])
        setContentCompressionResistancePriority(.required, for: .vertical)

        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didSelect)))

        isAccessibilityElement = true
        accessibilityLabel = "option"
        accessibilityIdentifier = "RadioGroupItem"
    }

    @objc func didSelect() {
        group.selectIndex(item: self)
    }

    override var accessibilityTraits: UIAccessibilityTraits {
        get {
            return radioButton.isSelected ? [.selected] : []
        }
        // swiftlint:disable next unused_setter_value
        set {}
    }
}

extension UIStackView {
    func removeAllArrangedSubviews() {
        for subview in arrangedSubviews.reversed() {
            removeArrangedSubview(subview)
            subview.removeFromSuperview()
        }
    }

    func addArrangedSubviews(_ subviews: [UIView]) {
        for subview in subviews {
            addArrangedSubview(subview)
        }
    }
}
