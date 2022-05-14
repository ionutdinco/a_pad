import 'package:flutter/material.dart';
import 'sidemenu.dart';

class Categories extends StatefulWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  List<String> cat = ["a", "b"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavDrawer(),
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text("aPad"),
        centerTitle: true,
      ),
      body: ListView(
          padding: const EdgeInsets.only(top: 50, left: 10, right: 10),
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: TextField(
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(left: 10),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color.fromARGB(255, 72, 45, 43),
                            width: 3.0,
                          ),
                          borderRadius: BorderRadius.circular(25.0)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color.fromARGB(255, 72, 45, 43),
                            width: 3.0,
                          ),
                          borderRadius: BorderRadius.circular(25.0)),
                      labelText: 'New category name',
                      labelStyle: const TextStyle(
                          color: Color.fromARGB(255, 72, 45, 43)),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  flex: 1,
                  child: Ink(
                    height: 60,
                    width: 60,
                    decoration: const ShapeDecoration(
                      color: Color.fromARGB(255, 72, 45, 43),
                      shape: CircleBorder(),
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.add,
                        size: 30,
                      ),
                      onPressed: () => {},
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            Divider(
              color: Colors.grey[700],
              height: 50,
            ),
            Column(
              children: cat.map((categorie) {
                return Row(
                  children: <Widget>[
                    const Expanded(
                      flex: 1,
                      child: Icon(Icons.subdirectory_arrow_right),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text(categorie, textAlign: TextAlign.start),
                    ),
                    Expanded(
                      flex: 1,
                      child: IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () => {},
                        color: const Color.fromARGB(255, 72, 45, 43),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => {},
                        color: const Color.fromARGB(255, 72, 45, 43),
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ]),
    );
  }
}
