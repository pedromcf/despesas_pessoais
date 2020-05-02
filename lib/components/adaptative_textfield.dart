import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptativeTextfield extends StatelessWidget {
  final String label;
  final Function(String) onSubmitted;
  final TextEditingController valorController;
  final TextInputType keyboardType;

  AdaptativeTextfield({
    this.label,
    this.onSubmitted,
    this.valorController,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
    ? Padding(
      padding: const EdgeInsets.only(
        bottom:10,
      ),
      child: CupertinoTextField(   
        placeholder: label,   
        controller: valorController,
        keyboardType: keyboardType,
        onSubmitted: onSubmitted,
        padding: EdgeInsets.symmetric(
          horizontal: 6,
          vertical: 12,
       ),      
      ),
    )
    
    : TextField(
      controller: valorController,
      keyboardType: keyboardType,
      onSubmitted: onSubmitted,
      decoration: InputDecoration(
        labelText: label,
      ),
    );
  }
}