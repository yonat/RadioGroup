//
//  RadioGroupPickerDemo.swift
//  RadioGroupDemo
//
//  Created by Yonat Sharon on 17/09/2019.
//  Copyright © 2019 Yonat Sharon. All rights reserved.
//

#if canImport(SwiftUI)
import RadioGroup
import SwiftUI

@available(iOS 13.0, *)
struct RadioGroupPickerDemo: View {
    @State private var selectedIndex: Int = -1

    var body: some View {
        VStack {
            Spacer()
            RadioGroupPicker(selectedIndex: $selectedIndex, titles: ["First", "Second", "Third", "Done"], isVertical: false, spacing: 16)
                .fixedSize()
                .border(Color.accentColor)
            Spacer()
            RadioGroupPicker(selectedIndex: $selectedIndex, titles: ["One", "Two", "Three", "Jinx"])
                .accentColor(.purple)
                .fixedSize()
            Spacer()
            RadioGroupPicker(
                selectedIndex: $selectedIndex,
                titles: ["אחת", "שתיים", "ו-ש-לוש", "הסוף!"],
                selectedColor: .systemRed,
                buttonSize: 32,
                itemSpacing: 8,
                titleColor: .systemGreen,
                titleAlignment: .right
            )
                .environment(\.layoutDirection, .rightToLeft)
                .fixedSize()
                .padding(8)
                .border(Color.red)
                .accentColor(.green)
            Spacer()
        }
        .padding()
    }
}

#endif
