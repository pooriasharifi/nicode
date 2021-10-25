import 'package:flutter/material.dart';

import '../constans.dart';

class txtForm extends StatelessWidget {
  final action;
  final onSave;
  final onCheng;
  final TextStyle txtStyle;
  final bool obsecureTxt;
  final String lableTxt;
  final Color bgColor;
  final Color txtColor;
  final icon;
  final suffixIcon;
  final Color siffixColor;
  final validate;
  final bool customBr;
  final BorderSide crBorder;
  final TextInputType keyType;
  const txtForm(
      {Key? key,
      this.action,
      this.onSave,
      this.onCheng,
      required this.txtStyle,
      required this.obsecureTxt,
      required this.lableTxt,
      required this.bgColor,
      required this.txtColor,
      this.icon,
      required this.keyType,
      required this.siffixColor,
      required this.suffixIcon,
      this.validate,
      this.customBr = true,
      this.crBorder = const BorderSide()})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: new TextFormField(
        textInputAction: action,
        keyboardType: keyType,
        onSaved: onSave,
        onChanged: onCheng,
        validator: validate,
        style: txtStyle,
        cursorColor: gry.withOpacity(1),
        maxLength: 10,
        textAlign: TextAlign.left,
        // textAlign: TextAlign.left,
        obscureText: obsecureTxt,
        decoration: new InputDecoration(
          hintText: lableTxt,
          fillColor: bgColor,
          labelStyle: new TextStyle(color: txtColor),
          filled: true,
          enabledBorder: new OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide:
                customBr ? (BorderSide(color: gry.withOpacity(1))) : crBorder,
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: customBr ? (BorderSide(color: gry)) : crBorder),
          prefixIcon: Icon(
            icon,
            size: 16,
            color: gry.withOpacity(1),
          ),
          suffixIcon: Icon(
            suffixIcon,
            size: 16,
            color: siffixColor,
          ),
          // contentPadding: EdgeInsets.symmetric(horizontal: 55, vertical: 60)
        ),
      ),
    );
  }
}
