import 'package:flutter/material.dart';
import 'package:notes_app/inherited_widgets/note_inherited_widget.dart';
import 'package:notes_app/views/note_list.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return NoteInheritedWidget(
      MaterialApp(
        debugShowCheckedModeBanner: false,
      title: 'notes',
      home: NoteList(),
        ),
    );
  }
}
