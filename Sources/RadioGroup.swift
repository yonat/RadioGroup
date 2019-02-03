//
//  RadioGroup.swift
//  RadioGroup
//
//  Created by Yonat Sharon on 03.02.2019.
//

import MiniLayout
import UIKit

@IBDesignable open class RadioGroup: UIControl {
    open var titles: [String] = [] {
        didSet {
            stackView.removeAllArrangedSubviews()
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
            if oldValue >= 0 {
                (stackView.arrangedSubviews[oldValue] as? RadioGroupItem)?.radioButton.isSelected = false
            }
            if selectedIndex >= 0 && selectedIndex < stackView.arrangedSubviews.count {
                (stackView.arrangedSubviews[selectedIndex] as? RadioGroupItem)?.radioButton.isSelected = true
            }
        }
    }

    @IBInspectable open var selectedColor: UIColor? {
        didSet {
            forEachItem { $0.radioButton.selectedColor = selectedColor }
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

    @IBInspectable open var isButtonAfterTitle: Bool = false {
        didSet {
            let direction: UISemanticContentAttribute = isButtonAfterTitle ? .forceRightToLeft : .unspecified
            forEachItem { $0.stackView.semanticContentAttribute = direction }
        }
    }

    open var titleAlignment: NSTextAlignment = .natural {
        didSet {
            forEachItem { $0.titleLabel.textAlignment = titleAlignment }
        }
    }

    private let stackView = UIStackView()

    private func setup() {
        addConstrainedSubview(stackView, constrain: .leftMargin, .rightMargin, .topMargin, .bottomMargin)
        stackView.axis = .vertical
        setContentCompressionResistancePriority(.required, for: .vertical)
        spacing = { spacing }()
    }

    private func forEachItem(_ perform: (RadioGroupItem) -> Void) {
        stackView.arrangedSubviews.compactMap { $0 as? RadioGroupItem } .forEach(perform)
    }

    func selectIndex(item: RadioGroupItem) {
        guard let index = stackView.arrangedSubviews.firstIndex(of: item) else { return }
        selectedIndex = index
        sendActions(for: [.valueChanged, .primaryActionTriggered])
    }

    convenience init(titles: [String]) {
        self.init(frame: .zero)
        self.titles = titles
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
        titleLabel.text = title
        addConstrainedSubview(stackView, constrain: .left, .right, .top, .bottom)
        stackView.addArrangedSubviews([radioButton, titleLabel])
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didSelect)))
        setContentCompressionResistancePriority(.required, for: .vertical)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func didSelect() {
        group.selectIndex(item: self)
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
