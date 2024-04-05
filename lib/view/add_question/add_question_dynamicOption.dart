import 'package:e_learning_app/detabase/db_helper.dart';
import 'package:e_learning_app/model/question.dart';
import 'package:flutter/material.dart';

class AddQuestionDynamic extends StatefulWidget {
  Question? question;

  AddQuestionDynamic({this.question});

  @override
  State<AddQuestionDynamic> createState() => _AddQuestionDynamicState();
}

class _AddQuestionDynamicState extends State<AddQuestionDynamic> {
  final _GlobelKay = GlobalKey<FormState>();
  DbHelper _dbHelper = DbHelper();

  int selectedOption = 1;

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    addLisTile();
  }

  List<Widget> listTiles = [];

/*
  void addLisTile() {
    setState(() {
      listTiles.add(ListTile(
        title: buildOptionForm(listTiles.length + 1),
        leading: Radio(
          value: 1,
          groupValue: selectedOption,
          onChanged: (value) {
            setState(() {
              selectedOption = value!;
              print(selectedOption);
            });
          },
        ),
      ));
    });
  }
*/
  void addLisTile() {
    setState(() {
      int newOptionNumber = listTiles.length + 1;
      listTiles.add(ListTile(
        title: buildOptionForm(newOptionNumber),
        leading: Radio(
          value: newOptionNumber,
          groupValue: selectedOption,
          onChanged: (value) {
            newOptionNumber =value!;
            setState(() {
              selectedOption = value!;
              print('value : ${selectedOption}');
              print('groupvalue : ${newOptionNumber}');
            });
          },
        ),
      ));
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
                SizedBox(
                  height: size.height * 0.02,
                ),
                buildQuestionForm(),
                SizedBox(
                  height: size.height * 0.02,
                ),
                Column(
                  children: [
                    Column(
                      children: listTiles,
                    ),
                    ElevatedButton(
                      onPressed: addLisTile,
                      child: Text('Add Options'),
                    ),
                  ],
                ),
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
}
