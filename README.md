<img align="right" src="Screenshots/RadioGroup.png">

# RadioGroup

[![Swift Version][swift-image]][swift-url]
[![Build Status][travis-image]][travis-url]
[![License][license-image]][license-url]
[![CocoaPods Compatible](https://img.shields.io/cocoapods/v/RadioGroup.svg)](https://img.shields.io/cocoapods/v/RadioGroup.svg)  
[![Platform](https://img.shields.io/cocoapods/p/RadioGroup.svg?style=flat)](http://cocoapods.org/pods/RadioGroup)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat-square)](http://makeapullrequest.com)

The missing iOS radio buttons group.

## Usage

```swift
let radioGroup = RadioGroup(titles: ["First Option Title", "Another Option Title", "Last"])
radioGroup.selectedIndex = 0
radioGroup.addTarget(self, action: #selector(optionSelected), forControlEvents: .valueChanged)
```

### Changing Appearance

Layout:

```swift
radioGroup.titleAlignment = .right
radioGroup.isButtonAfterTitle = true // default is false => button left (leading) relative to title
```

Color:

```swift
radioGroup.tintColor = .green // surrounding ring
radioGroup.selectedColor = .red // center circle
```

Size:

```swift
radioGroup.buttonSize = 42.0
radioGroup.spacing = 12 // vertical spacing between options
radioGroup.itemSpacing = 12 // horizontal spacing between button and title
```

## Installation

### CocoaPods:

```ruby
pod 'RadioGroup'
```

### Manually:

Copy `Sources/*.swift` and [`MiniLayout.swift`](https://github.com/yonat/MiniLayout) to your Xcode project.

## Meta

[@yonatsharon](https://twitter.com/yonatsharon)

[https://github.com/yonat/RadioGroup](https://github.com/yonat/RadioGroup)

[swift-image]:https://img.shields.io/badge/swift-4.2-orange.svg
[swift-url]: https://swift.org/
[license-image]: https://img.shields.io/badge/License-MIT-blue.svg
[license-url]: LICENSE.txt
[travis-image]: https://img.shields.io/travis/dbader/node-datadog-metrics/master.svg?style=flat-square
[travis-url]: https://travis-ci.org/dbader/node-datadog-metrics
[codebeat-image]: https://codebeat.co/badges/c19b47ea-2f9d-45df-8458-b2d952fe9dad
[codebeat-url]: https://codebeat.co/projects/github-com-vsouza-awesomeios-com
