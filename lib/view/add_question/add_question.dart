import 'package:e_learning_app/detabase/db_helper.dart';
import 'package:e_learning_app/model/category.dart';
import 'package:e_learning_app/model/question.dart';
import 'package:flutter/material.dart';

class AddQuestion extends StatefulWidget {
  Question? question;

  AddQuestion({this.question});

  @override
  State<AddQuestion> createState() => _AddQuestionState();
}

class _AddQuestionState extends State<AddQuestion> {
  final _GlobelKay = GlobalKey<FormState>();
  DbHelper _dbHelper = DbHelper();

  int selectedOption = 1;

  int categoryId = -1;
  List<Category> categoryList = [];


  String? _question, _op1, _op2, _op3, _op4;
  String? answer;

  Future<void> addQuestion(Question question, BuildContext context) async {
    int result = await _dbHelper.insertQuestion(question);
    if (result != -1) {
      question.qid = result;
      // Fluttertoast.showToast(msg: 'Record save successfully..');
      print('$result - Recored save successfully');
      Navigator.pop(context, question);
    } else {
      print('$result - Error');
      Navigator.pop(context, null);
    }
  }

  List<Category> categotysData = [];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadCategory();
  }

  Future<void> loadCategory() async {
    var tempList = await _dbHelper.read_category();
    setState(() {
      categoryList.addAll(tempList);
    });
  }


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create A Question"),
      ),
      body: SingleChildScrollView(
        reverse: true,
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
          child: Form(
            key: _GlobelKay,
            child: Column(
              children: [
                buildcategoryFormFiled(),
                SizedBox(
                  height: size.height * 0.02,
                ),
                buildQuestionForm(),
                SizedBox(
                  height: size.height * 0.02,
                ),
                ListTile(
                  title: buildOptionForm(1),
                  leading: Radio(
                    value: 1,
                    groupValue: selectedOption,
                    onChanged: (value) {
                      setState(() {
                        selectedOption = value!;
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                ListTile(
                  title: buildOptionForm(2),
                  leading: Radio(
                    value: 2,
                    groupValue: selectedOption,
                    onChanged: (value) {
                      setState(() {
                        selectedOption = value!;
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                ListTile(
                  title: buildOptionForm(3),
                  leading: Radio(
                    value: 3,
                    groupValue: selectedOption,
                    onChanged: (value) {
                      setState(() {
                        selectedOption = value!;
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                ListTile(
                  title: buildOptionForm(4),
                  leading: Radio(
                    value: 4,
                    groupValue: selectedOption,
                    onChanged: (value) {
                      setState(() {
                        selectedOption = value!;
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                // buildAnsform(),
                SizedBox(
                  height: size.height * 0.02,
                ),
                MaterialButton(
                  color: Colors.purpleAccent.shade200,
                  minWidth: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28),
                  ),
                  onPressed: () {
                    // print('C : ${categotysData[4].CategoryName}');
                    print('C : ${categoryList.length}');
                    if (_GlobelKay.currentState!.validate()) {
                      _GlobelKay.currentState!.save();
                      print('Question : ${_question} '
                          '\n op1 : ${_op1}'
                          '\n op2 : ${_op2}'
                          '\n op3 : ${_op3}'
                          '\n op4 : ${_op4}'
                          '\n ans : ${selectedOption}');

                      Question question = Question(
                          que: _question!,
                          op1: _op1!,
                          op2: _op2!,
                          op3: _op3!,
                          op4: _op4!,
                          ans: selectedOption,
                          cid: categoryId,
                          createdAt: DateTime.now().millisecondsSinceEpoch);
                      addQuestion(question, context);
                    }
                  },
                  child: const Text(
                    "Submit the Question",
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  buildcategoryFormFiled() {
    return Container(
      width: MediaQuery.of(context).size.width, // Full-width container
      // Adjust the padding values as needed
      child: DropdownButtonFormField(
        // Assigning the default value
        iconEnabledColor: Colors.black45,
        validator: (value) {
          if (value == null) {
            return 'Select user type';
          } else {
            return null;
          }
        },
        onSaved: (newValue) {},
        onChanged: (value) {
          setState(() {
            categoryId = value!;
          });
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          labelText: "Category",
          hintText: 'Select Category',
          floatingLabelBehavior: FloatingLabelBehavior.auto,
        ),
        items: categoryList.map((cate) {
          return DropdownMenuItem(
              value: cate.id, child: Text('${cate.CategoryName}'));
        }).toList(),
      ),
    );
  }

  buildQuestionForm() {
    return TextFormField(
      keyboardType: TextInputType.multiline,
      maxLines: 3,
      onSaved: (newValue) {
        _question = newValue.toString();
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Enter the Question';
        } else {
          return null;
        }
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        labelText: "Question",
        hintText: 'Question',
        alignLabelWithHint: true,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
      ),
    );
  }


  Widget buildOptionForm(int optionNumber) {
    return TextFormField(
      keyboardType: TextInputType.multiline,
      onSaved: (newValue) {
        switch (optionNumber) {
          case 1:
            _op1 = newValue.toString();
            break;
          case 2:
            _op2 = newValue.toString();
            break;
          case 3:
            _op3 = newValue.toString();
            break;
          case 4:
            _op4 = newValue.toString();
            break;
        }
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Enter Option $optionNumber';
        } else {
          return null;
        }
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        labelText: "Option $optionNumber",
        hintText: 'Option $optionNumber',
        alignLabelWithHint: true,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
      ),
    );
  }


/*
  buildOption1Form() {
    return TextFormField(
      keyboardType: TextInputType.multiline,
      onSaved: (newValue) {
        _op1 = newValue.toString();
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Enter the Option 1';
        } else {
          return null;
        }
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        labelText: "Option 1",
        hintText: 'Option 1',
        alignLabelWithHint: true,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
      ),
    );
  }

  buildOption2Form() {
    return TextFormField(
      keyboardType: TextInputType.multiline,
      onSaved: (newValue) {
        _op2 = newValue.toString();
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Enter the Option 2';
        } else {
          return null;
        }
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        labelText: "Option 2",
        hintText: 'Option 2',
        alignLabelWithHint: true,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
      ),
    );
  }

  buildOption3Form() {
    return TextFormField(
      keyboardType: TextInputType.multiline,
      onSaved: (newValue) {
        _op3 = newValue.toString();
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Enter the Option 3';
        } else {
          return null;
        }
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        labelText: "Option 3",
        hintText: 'Option 3',
        alignLabelWithHint: true,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
      ),
    );
  }

  buildOption4Form() {
    return TextFormField(
      keyboardType: TextInputType.multiline,
      onSaved: (newValue) {
        _op4 = newValue.toString();
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Enter the Option 4';
        } else {
          return null;
        }
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        labelText: "Option 4",
        hintText: 'Option 4',
        alignLabelWithHint: true,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
      ),
    );
  }*/
}
