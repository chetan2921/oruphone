import 'package:flutter/material.dart';

class Loginpage1Model {
  TextEditingController? textController;
  FocusNode? textFieldFocusNode;
  bool? checkboxValue = false;

  void dispose() {
    textController?.dispose();
    textFieldFocusNode?.dispose();
  }
}
