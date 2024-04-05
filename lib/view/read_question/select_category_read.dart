import 'package:e_learning_app/detabase/db_helper.dart';
import 'package:e_learning_app/model/category.dart';
import 'package:e_learning_app/view/read_question/readQuestionView.dart';
import 'package:flutter/material.dart';

class SelectCategoryReadView extends StatefulWidget {
  const SelectCategoryReadView({super.key});

  @override
  State<SelectCategoryReadView> createState() => _SelectCategoryReadViewState();
}

class _SelectCategoryReadViewState extends State<SelectCategoryReadView> {
  DbHelper _dbHelper = DbHelper();

  List<Category> _category = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchCategoryList();
  }

  Future<void> _fetchCategoryList() async {
    var tempList = await _dbHelper.read_category();
    setState(() {
      _category = tempList.cast<Category>();
    });
  }

  @override
  Widget build(BuildContext context) {

    List<Widget> listTiles = _category.map((category) {
      return Card(
        color: Colors.purpleAccent.shade100,
        child: ListTile(
          onTap: () async {
            Navigator.push(context, MaterialPageRoute(builder: (context) => ReadQuestionView(category.id!, category.CategoryName),));
          },
          title: Text(category.CategoryName),
          leading: Text("${category.id}"),
        ),
      );
    }).toList();

    var selectedIndex =0;
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Categroy"),
      ),
      body: ListView.builder(
        itemCount: _category.length,
        itemBuilder: (context, index) {
          return listTiles[index];

          /*    return ListTile(
            onTap: () async {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ReadQuestionView(),));
            },
            title: Text(_category[index].CategoryName),
            leading: Text("${index+1}    ${_category[index].id}"),
          );*/
        },
      ),
    );
  }
}
