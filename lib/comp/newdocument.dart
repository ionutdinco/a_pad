import 'package:flutter/material.dart';

class DocumentView extends StatefulWidget {
  const DocumentView({Key? key, required this.document}) : super(key: key);

  final Map document;

  @override
  _DocumentState createState() => _DocumentState();
}

class _DocumentState extends State<DocumentView> {
  final TextEditingController _controllerTitle = TextEditingController();
  final TextEditingController _controllerContent = TextEditingController();
  int selectionStart = -1;
  int selectionEnd = -1;
  int offsetBase = -1;
  int offsetExtent = -1;

  void _backToMenu() {
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    _controllerContent.addListener(() {
      TextSelection selection = _controllerContent.selection;
      if (selection.start > -1) selectionStart = selection.start;
      if (selection.end > -1) selectionEnd = selection.end;
      offsetBase = selection.baseOffset;
      offsetExtent = selection.extentOffset;
      print(selectionStart);
      print(selectionEnd);
      print(offsetBase);
      print(offsetExtent);
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
                  onTap: () {},
                  child: const Text(
                    "SAVE",
                    textScaleFactor: 1.2,
                  ),
                )),
          ]),
      body: Container(
        color: const Color.fromARGB(255, 110, 25, 25),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: TextFormField(
                style: const TextStyle(color: Color.fromARGB(255, 0, 185, 182)),
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
                  labelStyle:
                      const TextStyle(color: Color.fromARGB(255, 0, 185, 182)),
                ),
                controller: _controllerTitle
                  ..text = widget.document["title"].toString(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                style: const TextStyle(color: Color.fromARGB(255, 0, 185, 182)),
                decoration: const InputDecoration(
                  labelText: 'Content',
                  labelStyle:
                      TextStyle(color: Color.fromARGB(255, 0, 185, 182)),
                ),
                minLines: 10,
                maxLines: 23, // allow user to enter 5 line in textfield
                keyboardType: TextInputType.multiline,
                controller: _controllerContent
                  ..text = widget.document["content"].toString(),
                enableInteractiveSelection: true,
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                margin: const EdgeInsets.only(right: 20),
                child: TextButton(
                  onPressed: () => {},
                  child: const Text("Default"),
                  style: TextButton.styleFrom(
                      primary: Colors.black, backgroundColor: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
