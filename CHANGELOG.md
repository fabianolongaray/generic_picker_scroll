## 4.0.1

* Fix style not updating when scrolling the picker component - styles now correctly update to reflect the currently selected value instead of staying at the initial value
* Convert `_ValueScrollView` from StatelessWidget to StatefulWidget to properly track and update selected item state during scrolling

---

## 4.0.0

* First commit of a generic picker scroll based on date picker scroll

---

## 3.8.2

* Remove `textAlign` parameter from `ScrollViewDetailOptions`. Use the `alignment` property instead, which provides the same functionality with better control over text positioning.

---

## 3.8.1

* Move the date picker indicator behind the scroll columns so custom `indicatorColor` no longer obscures text.
* Improve automatic column width calculation by measuring both selected and unselected text styles for every value, preventing month name truncation.
* Add `horizontalPadding` to `ScrollViewDetailOptions` to control extra space on the left and right of each column without affecting the automatic width.
* Update the example (`test_component.dart`) to demonstrate the new padding controls, custom indicator styling, locale tweaks, and disabling looping via `GenericPickerOptions.isLoop`.

---

## 3.7.5

* Add `indicatorColor` and `indicatorBorderRadius` parameters to `GenericPickerOptions` for customizing the center indicator appearance.
* Add `textAlign` parameter to `ScrollViewDetailOptions` for customizing text alignment of day, month, and year labels.

---

**Note:** Versions 3.7.4 and below were developed by the original author [mincheol-shin](https://github.com/mincheol-shin/scroll_date_picker). This fork maintains compatibility while adding new features.

---

## 3.7.4

* Add turkish months. Thanks @Barış Şenyerli. (#29)
* Add the option to enable/disable looping per scroll view. Thanks @moderateroni. (#32)
* Fix day jumps to wrong index. Thanks @moderateroni. (#34)
* Fix bug in GenericPickerViewType. Thanks @mkhitar-avsharyan (#36)

## 3.7.3

* Add viewType option. Thanks @sejun. (#21)

## 3.7.2

* Add the italian locale to the list of the ones that require day / month / year order
* Add support for Portuguese.

## 3.7.1

* Added support for Arabic. Thanks @Mahmod Masoud. (#22)

## 3.7.0

* Added support for Chinese. Thanks @Chenyang. (#19)
* Added crossAxisAlignment and mainAxisAlignment to `GenericPickerScrollViewOptions`. Thanks @Chenyang. (#19)


## 3.6.2

* Add a new backgroundColor constructor to date picker options. Thanks @Paroca72. (#18)


## 3.6.1

* Mac OS Support added in example. Thanks @Hamza A.Malik. (#16)
* Added italian localization. Thanks @sharkfabri. (#17)


## 3.6.0

* Add a new `all` constructor to scroll view options. Thanks @Syed Ahkam. (#13)
* Add and correct month names.  Thanks @Alexander Klehm. (#14)


## 3.5.1

* Update to Flutter 3


## 3.5.0

* Added support for Indonesian and Thai language.
* Improved to avoid text overflow by calculating the scrollview width.
* Delete `GenericPickerLocale` and utilize Locale class.
* Improved the directory structure and code.
* Update README
* Update example


## 3.4.0

* Added support for Vietnamese.


## 3.3.0

* Improved the directory structure and code.
* Fixed date limit issue.
* Fixed monthly reset issue.

## 3.2.0

* Added date limit function.
* Added year, month and day padding parameters.
* Added indicator parameters.
* Added selection text style setting function.
* Update enum values naming
* Update README
* Update example


## 3.1.0

* Adding the german support. Thanks @komarekw.


## 3.0.0

* Delete `controller` parameters and add `selectedDate` parameters.
* Improved scroll performance.
* Improved the directory structure and code.
* Update README


## 2.0.5

* Adding the french support. Thanks @Babacar-arch.


## 2.0.4

* new property added `initialDateTime` for `GenericPickerController`
* `initialDateTime` was removed from `ScrollGenericPicker`
* Update README


## 2.0.3

* code improvements
* Update README

## 2.0.2

* `Controller` can now be used inside `outside the widget`
```dart
          ScrollGenericPicker(
            yearController: _yearController,
            monthController: _monthController,
            dayController: _dayController,
            minimumYear: _minimumYear,
            maximumYear: _maximumYear,
            initialDateTime: _selectedDate,
          ),

```

## 2.0.1

* The operand can't be null, so the condition is always true.

## 2.0.0

* Stable null safety release.

## 1.0.1

* NotificationListener option
* Date output bug

## 1.0.0

* Scroll Date Picker creation
