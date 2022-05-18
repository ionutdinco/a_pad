// ignore_for_file: prefer_const_constructors
import 'package:a_pad/dataPersistence/data_persistence.dart';
import 'package:a_pad/main.dart';
import 'package:flutter/material.dart';
import 'managecategories.dart';

class NavDrawer extends StatefulWidget {
  const NavDrawer({Key? key}) : super(key: key);

  @override
  _NavDrawerState createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  List<String> categories = ["work1", "work2"];

  Future<List<CategoriesDData>> _loadData() async {
    return await DatabaseHelper().allCategoryEntries;
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              "aPad",
              textAlign: TextAlign.start,
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 255, 255),
                image: DecorationImage(
                    fit: BoxFit.contain,
                    image: AssetImage("assets\\images\\notepad.png"))),
          ),
          ListTile(
            leading: Icon(Icons.note_rounded),
            title: Text("Notes"),
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const MyHomePage(
                          title: 'aPad',
                        )),
              ),
            },
          ),
          Divider(
            color: Colors.grey[500],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text("Categories"),
          ),
          SizedBox(
            height: 10,
          ),
          FutureBuilder<List<CategoriesDData>>(
            future: _loadData(),
            builder: (context, category) {
              return ListView(
                shrinkWrap: true,
                children: category.data!
                    .map(
                      (data) => ListTile(
                        leading: Icon(Icons.label),
                        title: Text(data.category.toString()),
                        onTap: () => {},
                      ),
                    )
                    .toList(),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.edit_note),
            title: Text("Edit Categories"),
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Categories()),
              ),
            },
          ),
          Divider(
            color: Colors.grey[500],
          ),
        ],
      ),
    );
  }
}
