import 'package:bytebank/screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

bool featureItemMatcher(Widget widget,
    {required IconData icon, required String title}) {
  if (widget is FeatureItem) {
    return widget.title == title && widget.icon == icon;
  }
  return false;
}

bool textFieldMatcher(Widget widget, String labelText) {
  if (widget is TextField && widget.decoration != null) {
    return widget.decoration!.labelText == labelText;
  }
  return false;
}
