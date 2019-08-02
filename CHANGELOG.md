# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.comd/en/1.0.0/)
and this project adheres to [Semantic Versioning](http://semver.orgd/spec/v2.0.0.html).

## [Unreleased]

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
