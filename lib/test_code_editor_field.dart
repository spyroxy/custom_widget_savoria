import 'package:flutter/material.dart';
import 'package:flutter_code_editor/flutter_code_editor.dart';
import 'package:flutter_highlight/themes/monokai-sublime.dart';

Widget buildEditor(CodeController controller) {
  return CodeTheme(
    data: CodeThemeData(styles: monokaiSublimeTheme),
    child: CodeField(
      controller: controller,
      textStyle: const TextStyle(fontFamily: 'monospace', fontSize: 13),
    ),
  );
}
