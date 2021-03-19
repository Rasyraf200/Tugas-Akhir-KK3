
import 'package:flutter/material.dart';

class NoteInheritedWidget extends InheritedWidget {

  final notes = [
    {
      'nama' : 'asep',
      'jumlah' : '10000'
    },
    {
      'nama' : 'jupri',
      'jumlah' : '50000'
    },
    {
      'nama' : 'sarwen',
      'jumlah' : '25000'
    }
  ];

  NoteInheritedWidget(Widget child) : super(child: child);

  static NoteInheritedWidget of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(NoteInheritedWidget) as NoteInheritedWidget;
  }

  @override
  bool updateShouldNotify(NoteInheritedWidget oldWidget) {
    return oldWidget.notes != notes;
  }
}