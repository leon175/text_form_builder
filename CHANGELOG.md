# Change Log

## [1.0.0] - 29.09.2020

### Added
* Generate a form with its the boilerplate code
* Add text fields aswell as other widgets to your generated form
* Disable that submitting the last field in the form submits the form itself
* Disable that clicking outside of a field closes the keyboard

### Changed
* Nothing

### Fixed
* Nothing

## [1.0.1] - 30.09.2020

### Fixed
* Error: `onFieldSubmitted` called on `null`

## [1.0.2+3] - 30.09.2020

### Added
* `onSubmit` returns now `TextFieldResultList` which makes it easier to access a single `TextFormResult`

## [1.0.3+4] - 03.10.2020

### Added
* `TextFormBuilderField` has now the option `obscureText`
* The `submit` method of `TextFormBuilderState` returns now `TextFieldResultList`

## [1.0.4+5] - 05.10.2020

### Added
* `TextFieldResultList.contains` to check for an id

### Fixed
* `TextFieldResultList.find` throws `Bad state: no element`
* `TextFieldResultList.results = []`

## [1.0.4+6] - 05.10.2020

### Changed
* If `TextFieldResultList.find` found nothing it returns `TextFieldResult(ID, null)`

## [1.0.5+7] - 05.10.2020

### Added
* `TextFormBuilder.getCurrentResultList` -> Get the current `TextFieldResultList` without validating or submitting the form
