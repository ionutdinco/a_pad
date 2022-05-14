import 'package:flutter/material.dart';
import 'comp/sidemenu.dart';
import 'comp/newdocument.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
  List<dynamic> infos = [
    {"id": 1, "title": "tttt", "content": "rrrr", "last_update": "ieri"},
    {
      "id": 2,
      "title": "ttrwer6nkllkntt",
      "content": "rrjnlerrr",
      "last_update": "azi"
    },
    {
      "id": 2,
      "title": "ttrwe5knknrtt",
      "content": "rrelnrrr",
      "last_update": "azi"
    },
    {
      "id": 2,
      "title": "ttrwer1tt",
      "content": "rrerrooor",
      "last_update": "azi"
    },
    {
      "id": 2,
      "title": "ttrwe2rtt",
      "content": "rrerkmrr",
      "last_update": "azi"
    },
    {
      "id": 2,
      "title": "ttrwe3rtt",
      "content": "rrelnlkrrr",
      "last_update": "azi"
    },
    {
      "id": 2,
      "title": "ttrwe4rtt",
      "content": "rrenlrrr",
      "last_update": "azi"
    },
  ];
  List<Color> widgetColor =
      List.generate(100, (index) => const Color.fromARGB(255, 110, 25, 25));
  List<bool> isSelected = List.generate(100, (index) => false);
  List<AppBar> appBars = [];

  _MyHomePageState() {
    appBars.addAll([
      AppBar(title: const Text("aPad"), centerTitle: true, actions: <Widget>[
        Padding(
            padding: const EdgeInsets.only(right: 35.0),
            child: GestureDetector(
              onTap: () {},
              child: const Icon(Icons.more_vert),
            )),
      ]),
      AppBar(
          title: const Text("aPad"),
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
                padding: const EdgeInsets.only(right: 35.0),
                child: GestureDetector(
                  onTap: () {},
                  child: const Icon(Icons.more_vert),
                )),
          ]),
    ]);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: () => {},
          tooltip: 'Increment',
          child: const Icon(Icons.add),
          elevation: 12,
        ),
        drawer: const NavDrawer(),
        appBar: appBars[0],
        body: ListView(
            padding: const EdgeInsets.only(top: 20),
            children: <Widget>[
              Column(
                //mainAxisAlignment: MainAxisAlignment.center,
                //crossAxisAlignment: CrossAxisAlignment.center,
                children: infos.map((document) {
                  return InkWell(
                    onLongPress: () =>
                        {_toggleDocument(infos.indexOf(document))},
                    onTap: () => {
                      if (isSelected.contains(true))
                        {
                          if (isSelected[infos.indexOf(document)] == true)
                            {_unToggleDocument(infos.indexOf(document))}
                          else
                            {_toggleDocument(infos.indexOf(document))}
                        }
                      else
                        {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DocumentView(
                                      document: document,
                                    )),
                          ),
                        }
                    },
                    child: Container(
                      padding: const EdgeInsets.only(left: 20),
                      margin:
                          const EdgeInsets.only(left: 15, right: 15, top: 20),
                      height: 80,
                      decoration: BoxDecoration(
                        color: widgetColor[infos.indexOf(document)],
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
                              Text(document["title"].toString(),
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
                                      document["title"].toString() != ""
                                          ? document["title"].toString()
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
                            padding: const EdgeInsets.only(top: 50, right: 20),
                            child: Text(document["last_update"].toString(),
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
                }).toList(),
              ),
            ]));
  }
}
