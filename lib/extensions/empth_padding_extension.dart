import 'package:flutter/material.dart';

extension EmptyPadding on num {
  pw() => SizedBox(
        width: toDouble(),
      );
  ph() => SizedBox(
        height: toDouble(),
      );
}
