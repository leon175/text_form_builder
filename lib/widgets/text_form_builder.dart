part of '../text_form_builder.dart';

/// This class is used to `build` the [Form] with
/// the [TextFormField]s and their functionality

class TextFormBuilder extends StatefulWidget {
  final Widget Function(TextFieldOptions options) textFieldBuilder;
  final List<Widget> children;
  final Function(List<TextFieldResult> data) onSubmit;
  final bool submitOnLastFieldSubmitted;
  final bool closeableKeyboard;
  final EdgeInsets padding;
  final double width;
  final Colors color;

  TextFormBuilder({
    Key key,
    this.textFieldBuilder,
    this.children = const [],
    this.onSubmit,
    this.submitOnLastFieldSubmitted = true,
    this.closeableKeyboard = true,
    this.padding = const EdgeInsets.all(0),
    this.width,
    this.color,
  }) : super(key: key);

  @override
  TextFormBuilderState createState() => TextFormBuilderState();
}

class TextFormBuilderState extends State<TextFormBuilder> {
  bool _init = false;
  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _formData = {};

  final List<FocusNode> _focusNodes = [];
  final List<Widget> _children = [];

  @override
  void initState() {
    super.initState();

    /// Create the [FocusNode]s
    widget.children.asMap().forEach((index, field) {
      if (index < widget.children.length - 1 && field is TextFormBuilderField) {
        _focusNodes.add(FocusNode());
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_init) {
      /// Check the `amount` of [TextFormBuilderField]s inside of [children]
      int fieldAmount = 0;
      widget.children.forEach((field) {
        if (field is TextFormBuilderField && !field.disabled) {
          fieldAmount++;
        }
      });
      int fieldIndex = 0;
      widget.children.asMap().forEach((index, field) {
        /// Add the `fields`
        if (field is TextFormBuilderField) {
          /// Throw an error if [TextFormBuilderField] is used but no
          /// [textFieldBuilder] was implemented
          if (widget.textFieldBuilder == null) {
            throw TextFormBuilderError(
                "You need to return a widget in the 'textFieldBuilder' method when using TextFormBuilderField as a child!");
          }
          if (fieldIndex == fieldAmount - 1) {
            /// Add the last [field] in the [Form]
            _children.add(widget.textFieldBuilder(TextFieldOptions(
              id: field.id,
              title: field.title,
              value: field.value,
              disabled: field.disabled,
              lines: field.lines,
              keyboardType: field.lines > 1
                  ? TextInputType.multiline
                  : field.keyboardType,
              validator: field.validator,
              onFieldSubmitted: (value) {
                if (field.lines <= 1 && widget.submitOnLastFieldSubmitted) {
                  submit();
                }
                field.onFieldSubmitted(value);
              },
              onChanged: field.onChanged,
              focusNode: !field.disabled && _focusNodes.length > 1
                  ? _focusNodes[fieldIndex - 1]
                  : FocusNode(),
              textInputAction: field.lines > 1
                  ? TextInputAction.newline
                  : TextInputAction.done,
              onSaved: (value) {
                _formData[field.id] = value;
              },
            )));
          } else if (fieldIndex == 0) {
            /// Add the first `field` in the [Form]
            final actualFieldIndex = fieldIndex;
            _children.add(widget.textFieldBuilder(TextFieldOptions(
              id: field.id,
              title: field.title,
              value: field.value,
              disabled: field.disabled,
              lines: field.lines,
              keyboardType: field.lines > 1
                  ? TextInputType.multiline
                  : field.keyboardType,
              validator: field.validator,
              onFieldSubmitted: (value) {
                if (field.lines <= 1) {
                  FocusScope.of(context)
                      .requestFocus(_focusNodes[actualFieldIndex]);
                }
                field.onFieldSubmitted(value);
              },
              onChanged: field.onChanged,
              focusNode: FocusNode(),
              textInputAction: field.lines > 1
                  ? TextInputAction.newline
                  : TextInputAction.next,
              onSaved: (value) {
                _formData[field.id] = value;
              },
            )));
          } else {
            /// Add the other `fields` in the [Form]
            final actualFieldIndex = fieldIndex;
            _children.add(widget.textFieldBuilder(TextFieldOptions(
              id: field.id,
              title: field.title,
              value: field.value,
              disabled: field.disabled,
              lines: field.lines,
              keyboardType: field.lines > 1
                  ? TextInputType.multiline
                  : field.keyboardType,
              validator: field.validator,
              onFieldSubmitted: (value) {
                if (field.lines <= 1) {
                  FocusScope.of(context)
                      .requestFocus(_focusNodes[actualFieldIndex]);
                }
                field.onFieldSubmitted(value);
              },
              onChanged: field.onChanged,
              focusNode: !field.disabled && _focusNodes.length > 1
                  ? _focusNodes[fieldIndex - 1]
                  : FocusNode(),
              textInputAction: field.lines > 1
                  ? TextInputAction.newline
                  : TextInputAction.next,
              onSaved: (value) {
                _formData[field.id] = value;
              },
            )));
          }

          /// Ignore `field` if it's disabled to skip its [FocusNode]
          if (!field.disabled) {
            fieldIndex++;
          }
        } else {
          /// Add the other [Widget]s to the [Form]
          _children.add(field);
        }
      });

      _init = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    /// Close the `keyboard` when clicking outside of a [TextField]
    return GestureDetector(
      onTap: () {
        if (widget.closeableKeyboard) {
          FocusScope.of(context).requestFocus(FocusNode());
        }
      },
      child: Container(
        width: widget.width,
        color: widget.color ?? Color(0xFFFFFFFF),
        padding: widget.padding,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: _children,
          ),
        ),
      ),
    );
  }

  /// `Submit` the [Form]
  void submit() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      if (widget.onSubmit != null) {
        widget.onSubmit(_formData.entries
            .map((entry) => TextFieldResult(entry.key, entry.value))
            .toList());
      }
    }
  }

  /// `Clear` the [Form]s `fields`
  void reset() {
    _formKey.currentState.reset();
  }
}
