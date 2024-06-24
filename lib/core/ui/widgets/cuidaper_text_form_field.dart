

import 'package:cuidapet/core/ui/extensions/theme_extension.dart';
import 'package:flutter/material.dart';
    
class CuidaperTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final String label;
  final bool obscureText;
  final ValueNotifier<bool> _obscureTextVN;
   CuidaperTextFormField({ 
    Key? key ,
    required this.label, 
     this.obscureText = false,
     this.controller,
     this.validator
     }) :
     _obscureTextVN = ValueNotifier<bool>(obscureText), 
     super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return  ValueListenableBuilder<bool>(
        valueListenable:_obscureTextVN,
         builder: (_, obscureTextVnValue, __) {
       return TextFormField(
        controller: controller,
        validator: validator,
        obscureText : obscureTextVnValue,
        decoration:  InputDecoration(
          label:  Text(label),
          labelStyle: const TextStyle(
            fontSize: 15,
            color: Colors.black
          ),
          border: OutlineInputBorder(
             borderRadius: BorderRadius.circular(15)
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Colors.grey)
          ),
          suffixIcon: obscureText ?  IconButton(
          color: context.primaryColor,
          onPressed: (){
              _obscureTextVN.value = !obscureTextVnValue;
          }, 
          icon: Icon( obscureTextVnValue ? Icons.lock : Icons.lock_open )
          ) : null,
        ) ,
      );
      },
    );
  }
}