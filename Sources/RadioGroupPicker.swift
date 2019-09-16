//
//  RadioGroupPicker.swift
//
//  Copyright © 2019 Yonat Sharon. All rights reserved.
//

#if canImport(SwiftUI)

import SweeterSwift
import SwiftUI

/// The missing iOS radio buttons group
@available(iOS 13.0, *) public struct RadioGroupPicker: UIViewRepresentable {
    public typealias UIViewType = RadioGroup
    private let uiView = RadioGroup()

    @Binding var selectedIndex: Int

    public init(
        selectedIndex: Binding<Int>,
        titles: [String]? = nil,
        attributedTitles: [NSAttributedString]? = nil,
        selectedColor: UIColor? = nil,
        isVertical: Bool? = nil,
        buttonSize: CGFloat? = nil,
        spacing: CGFloat? = nil,
        itemSpacing: CGFloat? = nil,
        isButtonAfterTitle: Bool? = nil,
        titleColor: UIColor? = nil,
        titleAlignment: NSTextAlignment? = nil,
        titleFont: UIFont? = nil
    ) {
        _selectedIndex = selectedIndex
        uiView.translatesAutoresizingMaskIntoConstraints = false
        uiView.titles =? titles
        uiView.attributedTitles =? attributedTitles
        uiView.selectedColor =? selectedColor
        uiView.isVertical =? isVertical
        uiView.buttonSize =? buttonSize
        uiView.spacing =? spacing
        uiView.itemSpacing =? itemSpacing
        uiView.isButtonAfterTitle =? isButtonAfterTitle
        uiView.titleColor =? titleColor
        uiView.titleAlignment =? titleAlignment
        uiView.titleFont =? titleFont
    }

    public func makeUIView(context: UIViewRepresentableContext<RadioGroupPicker>) -> RadioGroup {
        uiView.addTarget(context.coordinator, action: #selector(Coordinator.valueChanged), for: .valueChanged)
        return uiView
    }

    public func updateUIView(_ uiView: RadioGroup, context: UIViewRepresentableContext<RadioGroupPicker>) {
        uiView.selectedIndex = selectedIndex
    }

    public func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    public class Coordinator: NSObject {
        let parent: RadioGroupPicker

        init(_ parent: RadioGroupPicker) {
            self.parent = parent
        }

        @objc func valueChanged(_ sender: RadioGroup) {
            parent.selectedIndex = sender.selectedIndex
        }
    }
}

#endif
