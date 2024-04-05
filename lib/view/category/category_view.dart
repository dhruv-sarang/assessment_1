import 'package:e_learning_app/detabase/db_helper.dart';
import 'package:e_learning_app/model/category.dart';
import 'package:flutter/material.dart';

class CategoryView extends StatefulWidget {
  const CategoryView({super.key});

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  DbHelper _dbHelper = DbHelper();

  List<Category> _category = [];

  final _globelKey = GlobalKey<FormState>();
  final _tital = TextEditingController();

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

  Future<void> addCategory(Category category, BuildContext context) async {
    int result = await _dbHelper.insert_category(category);
    if (result != -1) {
      print('$result - Successfully');
      category.id = result;
      Navigator.pop(context, category);
    } else {
      print('$result - Error');
      Navigator.pop(context, null);
    }
  }

  Future<void> updateCategory(Category category, BuildContext context) async {
    var id = await _dbHelper.updateCategory(category);
    if (id != -1) {
      print("Category Updated");
      print(category.id);
      Navigator.pop(context, category);
    } else {
      print("getting Error while adding category");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Manage Categroy"),
      ),
      body: ListView.builder(
        itemCount: _category.length,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () async {
              Category category = _category[index];

              Category? Cates =
                  await openModelBottSheet(context, category) as Category;
              if (Cates != null) {
                setState(() {
                  var index =
                      _category.indexWhere((element) => element.id == Cates.id);
                  _category[index] = Cates;
                });
              }
            },
            trailing: IconButton(
                onPressed: () {
                  Category category = _category[index];
                  setState(() {
                    /* _category
                        .removeWhere((element) => element.id == category!.id);
                    _dbHelper.deleteCategory(category.id);*/
                    showAlertDialog(category, context);
                  });
                },
                icon: Icon(Icons.delete)),
            title: Text(_category[index].CategoryName),
            leading: Text("${_category[index].id}"),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          Category? category = await openModelBottSheet(context, null);
          setState(() {
            _category.add(category!);
          });
        },
      ),
    );
  }

  openModelBottSheet(BuildContext context, Category? category) {
    if (category == null) {
      _tital.text = "";
      return showModalBottomSheet(
        isDismissible: false,
        enableDrag: false,
        context: context,
        builder: (context) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Form(
                      key: _globelKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Insert The Category",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                          TextFormField(
                            controller: _tital,
                            validator: (value) {
                              if (value == null || value!.isEmpty) {
                                return "Enter the tital";
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                                hintText: "Title",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )),
                          ),
                          SizedBox(
                            height: 13,
                          ),
                          Divider(),
                          MaterialButton(
                            onPressed: () async {
                              String title = _tital.text.trim().toString();
                              if (_globelKey.currentState!.validate()) {
                                Category category =
                                    Category(CategoryName: title);
                                addCategory(category, context);
                              }
                            },
                            minWidth: double.infinity,
                            color: Colors.purple.shade100,
                            padding: EdgeInsets.all(10),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: Text("Add Category"),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      );
    } else {
      _tital.text = category.CategoryName;
      return showModalBottomSheet(
        isDismissible: false,
        enableDrag: false,
        context: context,
        builder: (context) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Form(
                      key: _globelKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Update The Category",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                          TextFormField(
                            controller: _tital,
                            validator: (value) {
                              if (value == null || value!.isEmpty) {
                                return "Enter the tital";
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                                hintText: "Title",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )),
                          ),
                          SizedBox(
                            height: 13,
                          ),
                          Divider(),
                          MaterialButton(
                            onPressed: () async {
                              String title = _tital.text.trim().toString();
                              if (_globelKey.currentState!.validate()) {
                                Category catesId = Category.withId(
                                    CategoryName: title, id: category.id);
                                updateCategory(catesId, context);
                              }
                            },
                            minWidth: double.infinity,
                            color: Colors.purple.shade100,
                            padding: EdgeInsets.all(10),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: Text("Update Category"),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      );
    }
  }

  Future<void> showAlertDialog(Category category, BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Alert'),
        content: Text('Are you sure you want to Delete'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context, false);
            },
            child: Text('No'),
          ),
          TextButton(
            onPressed: () {
              deleteCategory(category, context);
              Navigator.pop(context, false);
            },
            child: Text('Yes'),
          )
        ],
      ),
    );
  }

  Future<void> deleteCategory(Category category, BuildContext context) async {
    int result = await _dbHelper.deleteCategory(category.id);
    if (result > 0) {
      setState(() {
        _category.removeWhere((element) => element.id == category!.id);
      });
      print('$result - Recored Delete successfully');
    } else {
      print('$result - Error');
    }
  }
}
