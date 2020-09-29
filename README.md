# text_form_builder

Build simple forms with custom widgets more easily.

## Getting Started

Import the package.

```dart
import 'package:text_form_builder/text_form_builder.dart';
```

Now you can use the `TextFormBuilder` widget to generate your form.

In `children` you can use any widget, which should be displayed in the form. If you want to use a text field, you have to use the `TextFormBuilderField` widget. This requires an id with which you will access its value after submitting the form.

With `textFieldBuilder` you can return your custom `TextFormField`. It's required if you are using a `TextFormBuilderField` in `children`. The function includes a `TextFieldOptions` parameter, which options you can pass to your `TextFormField`. It's recommended to pass the following options:

- initialValue: options.value
- maxLines: options.lines
- keyboardType: options.keyboardType
- validator: options.validator
- onFieldSubmitted: options.onFieldSubmitted
- onChanged: options.onChanged
- focusNode: options.focusNode
- textInputAction: options.textInputAction
- onSaved: options.onSaved

`onSubmit` is called when the form was submitted. The function includes a list of `TextFieldResult` which stores the id and the value of single `TextFormBuilderField`.

`submitOnLastFieldSubmitted` decides whether the form will be submitted if onFieldSubmitted is called on the last field of the form. The default value is `true`.

`closeableKeyboard` decides whether the keyboard should be closed if you click on the form outside of a field.

With `key` you are able to get access to the state of `TextFormBuilder` which you can use to submit or clear the form programmatically.

## Example

```dart
...
TextFormBuilder(
	key: _formKey,
	children: [
		TextFormBuilderField(
			id: "firstname",
			title: "Firstname",
			validator: (value) {
				if (value.length < 1) {
					return "Required";
				}
				return null;
			},
			value: "Max",
		),
		SizedBox(height: 20),
		TextFormBuilderField(
			id: "surname",
			title: "Surname",
			validator: (value) {
				if (value.length < 1) {
					return "Required";
				}
				return null;
			},
		),
		SizedBox(height: 50),
		TextFormBuilderField(
			id: "email",
			title: "E-Mail",
			disabled: true,
			value: "max@mustermann.de",
		),
		SizedBox(height: 20),
		TextFormBuilderField(
			id: "description",
			title: "Description",
			lines: 5,
		),
		SizedBox(height: 50),
		TextFormBuilderField(
			id: "age",
			title: "Age",
			keyboardType: TextInputType.number,
		),
		SizedBox(height: 50),
		Row(
			mainAxisAlignment: MainAxisAlignment.spaceBetween,
			children: [
				RaisedButton(
					child: Text('Reset'),
					onPressed: () {
						_formKey.currentState.reset();
					},
				),
				RaisedButton(
					child: Text('Submit'),
					onPressed: () {
						_formKey.currentState.submit();
					},
				),
			],
		),
	],
	textFieldBuilder: (options) {
		return Column(
			crossAxisAlignment: CrossAxisAlignment.start,
			children: [
				Text(options.title),
				SizedBox(height: 5),
				TextFormField(
					initialValue: options.value,
					maxLines: options.lines,
					keyboardType: options.keyboardType,
					validator: options.validator,
					onFieldSubmitted: options.onFieldSubmitted,
					onChanged: options.onChanged,
					focusNode: options.focusNode,
					textInputAction: options.textInputAction,
					onSaved: options.onSaved,
				),
			],
		);
	},
	padding: const EdgeInsets.all(50),
	onSubmit: (data) {
		print(data);
	},
),
...
```
