import 'package:flutter/material.dart';
import 'package:eat_well/theme/color_codes.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {Key? key,
      this.height,
      this.hintTitle,
      this.textEditingController,
      this.validator,
      this.keyboardType})
      : super(key: key);
  final double? height;
  final String? hintTitle;
  final String? validator;
  final String? keyboardType;

  final TextEditingController? textEditingController;
  @override
  Widget build(BuildContext context) {
    String validateEmail(
      String? value,
    ) {
      Pattern pattern =
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      RegExp regex = RegExp(pattern.toString());
      if (!regex.hasMatch(value!)) {
        return "enter_valid_email";
      } else {
        return '';
      }
    }

    return Padding(
      padding: EdgeInsets.only(
        top: height! * 0.0,
      ),
      child: SizedBox(
        // height: height! * 0.06,
        child: TextFormField(
          controller: textEditingController,
          keyboardType: keyboardType == "numeric"
              ? TextInputType.number
              : TextInputType.multiline,
          obscureText: hintTitle == "Password" ? true : false,
          style: TextStyle(
            color: Colors.black,
            fontSize: height! * 0.015,
          ),
          cursorColor: primaryColor,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                vertical: height! * 0.02, horizontal: height! * 0.01),
            isDense: true,
            fillColor: lightbackground,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide: const BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
            ),
            hoverColor: primaryColor,
            focusColor: primaryColor,
            hintText: hintTitle,
            hintStyle: TextStyle(
              color: Colors.grey[600],
              fontSize: height! * 0.015,
            ),
          ),
          validator: validator == "email"
              ? validateEmail
              : validator == 'no'
                  ? null
                  : (value) {
                      if (value!.isEmpty) {
                        return validator;
                      } else {}

                      return null;
                    },
        ),
      ),
    );
  }
}
