import 'package:flutter/material.dart';
import 'comp/sidemenu.dart';
import 'comp/newdocument.dart';
import 'dataPersistence/data_persistence.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const MyHomePage(title: 'aPad'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool firstChange = true;
  Map<int, Color> widgetColor = {};
  Map<int, bool> isSelected = {};
  List<AppBar> appBars = [];
  bool hideBtn = false;

  _MyHomePageState() {
    _pupulate();
    appBars.addAll([
      AppBar(
          title: const Text("aPad"),
          centerTitle: true,
          shadowColor: const Color.fromARGB(255, 25, 76, 110),
          backgroundColor: Colors.amber,
          elevation: 10,
          actions: <Widget>[
            Padding(
                padding: const EdgeInsets.only(right: 35.0),
                child: GestureDetector(
                  onTap: () {},
                  child: const Icon(Icons.more_vert),
                )),
          ]),
      AppBar(
          title: const Text("aPad"),
          shadowColor: const Color.fromARGB(255, 25, 76, 110),
          elevation: 10,
          backgroundColor: Colors.amber,
          leading: GestureDetector(
            onTap: () {
              _undoAllSelections();
            },
            child: const Icon(
              Icons.arrow_back, // add custom icons also
            ),
          ),
          centerTitle: true,
          actions: <Widget>[
            Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () async {
                    final ConfirmAction action =
                        (await _asyncConfirmDialog(context)) as ConfirmAction;
                    if (action.name == "Accept") {
                      _deleteSelectedNotes();
                      setState(() {});
                    }
                    print(action.name);
                  },
                  child: const Icon(Icons.delete),
                )),
            Padding(
                padding: const EdgeInsets.only(right: 40.0),
                child: GestureDetector(
                  onTap: () async {},
                  child: const Icon(Icons.more_vert),
                )),
          ]),
    ]);
  }

  void _pupulate() async {
    List<NotesDData> notes = await DatabaseHelper().allNoteEntries;
    for (var element in notes) {
      widgetColor[element.id] = const Color.fromARGB(255, 110, 25, 25);
      isSelected[element.id] = false;
    }
  }

  void _toggleDocument(index) {
    setState(() {
      widgetColor[index] = const Color.fromARGB(255, 25, 76, 110);
      isSelected[index] = true;
      if (firstChange == true) {
        firstChange = false;
        _swapAppBar();
      }
    });
  }

  void _unToggleDocument(index) {
    setState(() {
      widgetColor[index] = const Color.fromARGB(255, 110, 25, 25);
      isSelected[index] = false;
    });
  }

  void _swapAppBar() {
    var aux = appBars[0];
    appBars[0] = appBars[1];
    appBars[1] = aux;
    hideBtn = !hideBtn;
  }

  void _undoAllSelections() {
    setState(() {
      firstChange = true;
      _swapAppBar();
      for (var i = 0; i < isSelected.length; i++) {
        isSelected[i] = false;
        widgetColor[i] = const Color.fromARGB(255, 110, 25, 25);
      }
    });
  }

  void _deleteSelectedNotes() {
    isSelected.forEach((key, value) {
      if (value == true) {
        DatabaseHelper().deleteNote(key);
      }
    });
  }

  Future<List<NotesDData>> _loadData() async {
    List<NotesDData> list = await DatabaseHelper().allNoteEntries;
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: hideBtn
              ? null
              : () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const DocumentView(
                                id: -1,
                              )),
                    ),
                  },
          tooltip: 'Increment',
          child: const Icon(Icons.add),
          elevation: 12,
          backgroundColor: hideBtn ? Colors.grey[600] : Colors.amber,
        ),
        drawer: const NavDrawer(),
        appBar: appBars[0],
        body: FutureBuilder<List<NotesDData>>(
          future: _loadData(),
          builder: (context, document) {
            if (document.hasData) {
              return ListView.builder(
                  itemCount: document.data?.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onLongPress: () =>
                          {_toggleDocument(document.data![index].id)},
                      onTap: () => {
                        if (isSelected.containsValue(true))
                          {
                            if (isSelected[document.data![index].id] == true)
                              {_unToggleDocument(document.data![index].id)}
                            else
                              {_toggleDocument(document.data![index].id)}
                          }
                        else
                          {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DocumentView(
                                      id: document.data![index].id)),
                            ),
                          }
                      },
                      child: Container(
                        padding: const EdgeInsets.only(left: 20),
                        margin:
                            const EdgeInsets.only(left: 15, right: 15, top: 20),
                        height: 80,
                        decoration: BoxDecoration(
                          color: Color(
                              widgetColor[document.data![index].id] != null
                                  ? widgetColor[document.data![index].id]!.value
                                  : Colors.amber.value),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: const Color.fromARGB(255, 7, 124, 135)
                                  .withOpacity(0.5),
                              blurRadius: 7,
                              spreadRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Text(document.data![index].title.toString(),
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w300,
                                        fontSize: 15),
                                    textScaleFactor: 1.5),
                                Row(
                                  children: <Widget>[
                                    const Icon(Icons.account_tree_rounded),
                                    const SizedBox(width: 10),
                                    Text(
                                        document.data![index].title != ""
                                            ? document.data![index].title
                                                .toString()
                                            : "",
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w300,
                                            fontSize: 15),
                                        textScaleFactor: 1.0),
                                  ],
                                )
                              ],
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 50, right: 20),
                              child: Text(
                                  document.data![index].lastUpdate.toString(),
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w100,
                                      fontSize: 10),
                                  textScaleFactor: 1.5),
                            )
                          ],
                        ),
                      ),
                    );
                  });
            } else if (document.hasError) {
              return const Text("Ooops");
            }
            return const CircularProgressIndicator();
          },
        ));
  }
}

enum ConfirmAction { Cancel, Accept }
Future<ConfirmAction?> _asyncConfirmDialog(BuildContext context) async {
  return showDialog<ConfirmAction>(
    context: context,
    barrierDismissible: false, // user must tap button for close dialog!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Delete This Contact?'),
        content: const Text('This will delete the contact from your device.'),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop(ConfirmAction.Cancel);
            },
          ),
          TextButton(
            child: const Text('Delete'),
            onPressed: () {
              Navigator.of(context).pop(ConfirmAction.Accept);
            },
          )
        ],
      );
    },
  );
}
