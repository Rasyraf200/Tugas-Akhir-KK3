import 'package:flutter/material.dart';
import 'package:notes_app/providers/note_provider.dart';
import 'package:notes_app/views/Note.dart';
import 'package:notes_app/inherited_widgets/note_inherited_widget.dart';

class NoteList extends StatefulWidget {
  @override
  _NoteListState createState() {
    return new _NoteListState();
  }
}

class _NoteListState extends State<NoteList> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dela Dela'),
      ),
      body: FutureBuilder(
        future: NoteProvider.getNoteList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done){
            final notes = snapshot.data;
          return ListView.builder(
            itemBuilder: (context, index){
              return GestureDetector(
                onTap: () async{
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Note(NoteMode.Editing, notes[index])));
                    setState(() {});
                  },
                  child: Card(
                    child : Padding(
                      padding: const EdgeInsets.only(top: 30.0, bottom: 30, left: 13.0, right: 22.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          _NoteNama(notes[index]['nama']),
                          Container(height: 4,),
                          _NoteJumlah(notes[index]['jumlah'])
                        ],
                      ),
                    ),
                  ),
                );
              },
              itemCount: notes.length,
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
          floatingActionButton: FloatingActionButton(
              onPressed: () async {
                await Navigator.push(context, MaterialPageRoute(builder: (context) => Note(NoteMode.Adding, null)));
                setState(() {});
              },
              child: Icon(Icons.add),
          ),
    );
  }
}

class _NoteNama extends StatelessWidget {
  final String _nama;
  _NoteNama(this._nama);

  @override
  Widget build(BuildContext context) {
    return Text(
      _nama,
      style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold
      ),
    );
  }
}

class _NoteJumlah extends StatelessWidget {
  final String _jumlah;
  _NoteJumlah(this._jumlah);

  @override
  Widget build(BuildContext context) {
    return Text(
      _jumlah,
      style: TextStyle(
          color: Colors.grey.shade600
      ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }
}

