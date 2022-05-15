import 'package:a_pad/main.dart';
import 'package:drift/drift.dart' as d;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../dataPersistence/data_persistence.dart';

class DocumentView extends StatefulWidget {
  const DocumentView({Key? key, required this.id}) : super(key: key);

  final int id;

  @override
  _DocumentState createState() => _DocumentState();
}

class _DocumentState extends State<DocumentView> {
  final TextEditingController _controllerTitle = TextEditingController();
  final TextEditingController _controllerContent = TextEditingController();
  bool hasData = false;
  int selectionStart = -1;
  int selectionEnd = -1;

  void _backToMenu() {
    //Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => const MyHomePage(
                title: "aPAd",
              )),
    );
  }

  Future<Note> _getNote() async {
    var x = await DatabaseHelper().getEntryById(widget.id);
    print(x);
    return x;
  }

  void _addNote() async {
    setState(() async {
      if (hasData) {
        Note note = Note(
            id: widget.id,
            title: _controllerTitle.text,
            content: _controllerContent.text,
            lastUpdate: 12,
            category: "cat");
        await DatabaseHelper().updateNote(note);
      } else {
        await DatabaseHelper().addNote(NotesCompanion(
          title: d.Value(_controllerTitle.text),
          content: d.Value(_controllerContent.text),
        ));
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _controllerContent.addListener(() {
      TextSelection selection = _controllerContent.selection;
      if (selection.start > -1) selectionStart = selection.start;
      if (selection.end > -1) selectionEnd = selection.end;
      print(selectionStart);
      print(selectionEnd);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text("aPad"),
            leading: GestureDetector(
              onTap: () {
                _backToMenu();
              },
              child: const Icon(
                Icons.arrow_back, // add custom icons also
              ),
            ),
            centerTitle: true,
            actions: <Widget>[
              Padding(
                  padding: const EdgeInsets.only(right: 50.0, top: 18),
                  child: GestureDetector(
                    onTap: _addNote,
                    child: const Text(
                      "SAVE",
                      textScaleFactor: 1.2,
                    ),
                  )),
            ]),
        body: FutureBuilder<Note>(
          future: _getNote(),
          builder: (context, document) {
            document.hasData ? hasData = true : hasData = false;
            return Container(
              color: const Color.fromARGB(255, 110, 25, 25),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: TextFormField(
                      style: const TextStyle(
                          color: Color.fromARGB(255, 0, 185, 182)),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(left: 10),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color.fromARGB(255, 0, 185, 182),
                              width: 4.0,
                            ),
                            borderRadius: BorderRadius.circular(25.0)),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color.fromARGB(255, 0, 185, 182),
                              width: 4.0,
                            ),
                            borderRadius: BorderRadius.circular(25.0)),
                        labelText: 'Title',
                        labelStyle: const TextStyle(
                            color: Color.fromARGB(255, 0, 185, 182)),
                      ),
                      controller: _controllerTitle
                        ..text =
                            (document.hasData ? document.data?.title : "pula")!,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      style: const TextStyle(
                          color: Color.fromARGB(255, 0, 185, 182)),
                      decoration: const InputDecoration(
                        labelText: 'Content',
                        labelStyle:
                            TextStyle(color: Color.fromARGB(255, 0, 185, 182)),
                      ),
                      minLines: 10,
                      maxLines: 15, // allow user to enter 5 line in textfield
                      keyboardType: TextInputType.multiline,
                      controller: _controllerContent
                        ..text = (document.hasData
                            ? document.data?.content
                            : "pula")!,
                      enableInteractiveSelection: true,
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      margin: const EdgeInsets.only(right: 20),
                      child: TextButton(
                        onPressed: () => {},
                        child: const Text("Classic"),
                        style: TextButton.styleFrom(
                            primary: Colors.black,
                            backgroundColor: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ));
  }
}
