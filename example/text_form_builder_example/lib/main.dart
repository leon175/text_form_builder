import 'package:flutter/material.dart';
import 'package:text_form_builder/text_form_builder.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TextFormBuilder Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final _formKey = GlobalKey<TextFormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: TextFormBuilder(
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
        ),
      ),
    );
  }
}
