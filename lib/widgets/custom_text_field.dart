import 'package:flutter/material.dart';

import '../constants.dart';


class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final Function onSubmitted;
  final Function onChanged;
  final Widget suffixIcon;
  final bool secureText;
  final int maxLines;
  final Function validator;
  final String label;
  final String initialValue;
  const CustomTextField({Key key,this.onChanged, this.hintText, this.controller, this.onSubmitted, this.validator, this.initialValue, this.suffixIcon, this.secureText, this.maxLines, this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 40,top: 15,right: 40),
      child: Column(

        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label),
          TextFormField(
            onChanged: onChanged,
            maxLines: maxLines,
            initialValue: initialValue,
            controller: controller,
            cursorColor: Colors.grey,
            textAlign: TextAlign.left,
            obscureText: secureText??false,
            textDirection: TextDirection.ltr,
            decoration: InputDecoration(
                suffixIcon: suffixIcon,
                hintText: hintText,hintStyle: const TextStyle(color: textColor,),

            ),
          ),
        ],
      ),
    );
  }

}
