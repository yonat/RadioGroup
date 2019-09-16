# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.comd/en/1.0.0/)
and this project adheres to [Semantic Versioning](http://semver.orgd/spec/v2.0.0.html).

## [Unreleased]

### Added
- add SwiftUI wrapper `RadioGroupPicker`.

## [1.3.3] - 2019-09-12

### Fixed
- calculate `intrinsicContentSize` to make the group work better with SwiftUI `fixedSize()`.

## [1.3.2] - 2019-08-22

### Added
- support Swift Package Manager.

## [1.3.1] - 2019-08-05

### Fixed
- use `.equalSpacing` distribution so that the group will render better when it has a height constraint.

## [1.3.0] - 2019-08-02

### Added
- use `NSAttributedString` in titles by setting  `attributedTitles`.

## [1.2.6] - 2019-07-19

### Added
- allow horizontal layout by setting `radioGroup.isVertical = false`

## [1.2.5] - 2019-07-13

### Changed
- MiniLayout moved to SweeterSwift.

## [1.2.4] - 2019-06-21

### Changed
- Swift 5, CocoaPods 1.7.

## [1.2.3] - 2019-06-15

### Added
- UIAppearance support for `RadioButton`.

## [1.2.2] - 2019-06-02

### Added
- UIAppearance support.
- multiline labels.

### Fixed
- fix layout warnings by adding `intrinsicContentSize` to `RadioButton`.

## [1.2.1] - 2019-02-22

### Fixed
- allow `titleColor` to be set before `titles`.

## [1.2.0] - 2019-02-21

### Added
- configurable `titleColor` and `titleFont`.

## [1.1.0] - 2019-02-05

### Added
- accessibility.

## [1.0.1] - 2019-02-03

### Fixed
- remove old titles when setting new ones.

## [1.0.0] - 2019-02-03

### Added
- initial release.
