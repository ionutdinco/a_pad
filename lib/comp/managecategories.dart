import 'dart:ffi';

import 'package:a_pad/dataPersistence/data_persistence.dart';
import 'package:flutter/material.dart';
import 'sidemenu.dart';
import 'package:drift/drift.dart' as d;

class Categories extends StatefulWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  final TextEditingController _controllerCategory = TextEditingController();

  Future<List<CategoriesDData>> _loadData() async {
    return await DatabaseHelper().allCategoryEntries;
  }

  void _updateCategory(int id) async {
    bool existsEntry = await _alreadyThere();
    if (existsEntry) {
      return;
    }
    setState(() {
      DatabaseHelper().updateCategory(
          CategoriesDData(id: id, category: _controllerCategory.text));
    });
  }

  void _addCategory() async {
    bool existsEntry = await _alreadyThere();
    if (existsEntry) {
      return;
    }
    setState(() {
      DatabaseHelper().addCategory(
          CategoriesDCompanion(category: d.Value(_controllerCategory.text)));
    });
  }

  Future<bool> _alreadyThere() async {
    var cat = await DatabaseHelper().getCategByCat(_controllerCategory.text);
    if (cat == null) {
      return false;
    }
    return true;
  }

  void _deleteCategory(int id) {
    setState(() {
      DatabaseHelper().deleteCategory(id);
    });
  }

  void _displayDialog(BuildContext context, String event, int id) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Category name'),
            content: TextField(
              controller: _controllerCategory,
              decoration: const InputDecoration(hintText: "category"),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('SUBMIT'),
                onPressed: () {
                  if (_controllerCategory.text.isNotEmpty) {
                    print("yesss");
                    if (event == "new") {
                      _addCategory();
                      Navigator.of(context).pop();
                    }
                    if (event == "update") {
                      _updateCategory(id);
                      Navigator.of(context).pop();
                    }
                  }
                },
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => {_displayDialog(context, "new", 0)},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
        elevation: 12,
        backgroundColor: Colors.amber,
      ),
      drawer: const NavDrawer(),
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text("aPad"),
        centerTitle: true,
      ),
      body: FutureBuilder<List<CategoriesDData>>(
          future: _loadData(),
          builder: (context, category) {
            return ListView.builder(
                itemCount: category.data?.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: const EdgeInsets.only(top: 10),
                    height: 50,
                    color: Colors.amber,
                    child: Row(
                      children: <Widget>[
                        const Expanded(
                          flex: 1,
                          child: Icon(Icons.subdirectory_arrow_right),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            category.data![index].category.toString(),
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 17.0,
                                letterSpacing: 2.0),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () => {
                              _displayDialog(
                                  context, "update", category.data![index].id)
                            },
                            color: const Color.fromARGB(255, 91, 30, 25),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () =>
                                {_deleteCategory(category.data![index].id)},
                            color: const Color.fromARGB(255, 91, 30, 25),
                          ),
                        ),
                      ],
                    ),
                  );
                });
          }),
    );
  }
}
