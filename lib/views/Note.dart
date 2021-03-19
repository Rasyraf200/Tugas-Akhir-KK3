import 'package:flutter/material.dart';
import 'package:notes_app/inherited_widgets/note_inherited_widget.dart';
import 'package:notes_app/providers/note_provider.dart';

enum NoteMode{
  Editing,
  Adding
}

class Note extends StatefulWidget {

  final NoteMode noteMode;
  final Map<String, dynamic> note;

  Note(this.noteMode, this.note);

  @override
  _NoteState createState() => _NoteState();
}

class _NoteState extends State<Note> {

  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _jumlahController = TextEditingController();

  List<Map<String, String>> get _notes => NoteInheritedWidget.of(context).notes;

  @override
  void didChangeDependencies() {
    if(widget.noteMode == NoteMode.Editing){
      _namaController.text = widget.note['nama'];
      _jumlahController.text = widget.note['jumlah'];
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            widget.noteMode == NoteMode.Adding ? 'Utang Baru' : 'Edit'
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _namaController,
              decoration: InputDecoration(
                hintText: 'Masukan Nama'
              ),
            ),
            Container(height: 8,),
            TextField(
              controller: _jumlahController,
              decoration: InputDecoration(
                  hintText: 'Masukan Nominal'
              ),
            ),
            Container(height: 16.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _NoteButton('Simpan', Colors.blue, (){
                  final nama = _namaController.text;
                  final jumlah = _jumlahController.text;

                  if(widget?.noteMode == NoteMode.Adding){
                    NoteProvider.insertNote({
                      'nama' : nama,
                      'jumlah' : jumlah
                    });
                  } else if (widget?.noteMode == NoteMode.Editing){
                    NoteProvider.updateNote({
                      'id' : widget.note['id'],
                      'nama' : _namaController.text,
                      'jumlah' : _jumlahController.text
                    });
                  }
                  Navigator.pop(context);
                }),
                _NoteButton('Discard', Colors.grey, (){
                  Navigator.pop(context);
                }),
                widget.noteMode == NoteMode.Editing ?
                    Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _NoteButton('Delete', Colors.red, () async{
                      await NoteProvider.deleteNote(widget.note['id']);
                      Navigator.pop(context);
                    }),
                    )
                    : Container()
            ],
            )
          ],
        ),
      ),
    );
  }
}

class _NoteButton extends StatelessWidget {

  final String _text;
  final Color _color;
  final Function _onPressed;

  _NoteButton(this._text, this._color, this._onPressed);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: _onPressed,
      child: Text(
        _text,
        style: TextStyle(color: Colors.white),
      ),
      color: _color,
    );
  }
}

