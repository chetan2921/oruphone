import 'package:flutter/material.dart';

class HomepageModel {
  TextEditingController? textController;
  FocusNode? textFieldFocusNode;

  /// Constructor
  HomepageModel() {
    textController = TextEditingController();
    textFieldFocusNode = FocusNode();
  }

  /// Dispose method to clean up controllers
  void dispose() {
    textController?.dispose();
    textFieldFocusNode?.dispose();
  }
}
