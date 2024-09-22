import 'package:flutter/material.dart';

extension BuildContextExtensionFunctions on BuildContext {
  void removeSnackBar() {
    ScaffoldMessenger.of(this).removeCurrentSnackBar();
  }

  showSnackBar(String text) {
    ScaffoldMessenger.of(this).showSnackBar(SnackBar(content: Text(text)));
  }
}
