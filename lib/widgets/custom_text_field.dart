import 'package:easy_container/easy_container.dart';
import 'package:flutter/material.dart';
import 'package:happy_us/utils/constants.dart';

class CustomTextField extends StatefulWidget {
  static const id = 'CustomTextField';

  final bool autofocus;
  final Color color;
  final int? maxLines;
  final int? maxLength;
  final String? hintText;
  final EdgeInsets? contentPadding;
  final void Function(String)? onChanged;
  final bool isPasswordField;
  final String? Function(String?)? validator;

  const CustomTextField({
    Key? key,
    this.onChanged,
    this.validator,
    this.maxLines,
    this.maxLength,
    this.contentPadding,
    this.hintText,
    this.color = kAccentColor,
    this.autofocus = false,
    this.isPasswordField = false,
  }) : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _obscureText;

  @override
  void initState() {
    _obscureText = widget.isPasswordField;
    super.initState();
  }

  void toggleShowPassword() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return EasyContainer(
      color: this.widget.color,
      padding: 0,
      borderRadius: 10,
      margin: 0,
      elevation: 0,
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              autofocus: this.widget.autofocus,
              validator: this.widget.validator,
              onChanged: this.widget.onChanged,
              style: TextStyle(color: kFocusColor),
              cursorColor: kFocusColor,
              obscureText: _obscureText,
              maxLines: this.widget.maxLines,
              maxLength: this.widget.maxLength,
              decoration: InputDecoration(
                hintText: this.widget.hintText,
                border: InputBorder.none,
                contentPadding:
                    this.widget.contentPadding ?? EdgeInsets.only(left: 10),
                hintStyle: TextStyle(
                  color: kFocusColor.withOpacity(0.4),
                ),
              ),
            ),
          ),
          if (this.widget.isPasswordField)
            IconButton(
              icon: _obscureText
                  ? Icon(Icons.visibility_off)
                  : Icon(Icons.visibility),
              color: Colors.black,
              iconSize: 25,
              onPressed: toggleShowPassword,
            ),
        ],
      ),
    );
  }
}
