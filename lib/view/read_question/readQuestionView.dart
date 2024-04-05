import 'package:e_learning_app/detabase/db_helper.dart';
import 'package:e_learning_app/model/question.dart';
import 'package:flutter/material.dart';

class ReadQuestionView extends StatefulWidget {
  int id;
  String name;

  ReadQuestionView(this.id, this.name);

  @override
  State<ReadQuestionView> createState() => _ReadQuestionViewState(id, name);
}

class _ReadQuestionViewState extends State<ReadQuestionView> {
  int? id;
  String name;

  _ReadQuestionViewState(this.id, this.name);

  List<Question> _question = [];

  DbHelper _dbHelper = DbHelper();

  Future<void> deleteQuestions(Question question, BuildContext context) async {
    int result = await _dbHelper.deleteQuestion(question.qid);
    if (result > 0) {
      setState(() {
        _question.removeWhere((element) => element.qid == question.qid);
      });
      print('$result - Recored Delete successfully');
    } else {
      print('$result - Error');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchQuestionList();
  }

  Future<void> fetchQuestionList() async {
    var tempList = await _dbHelper.getCategoryQuestion(id);
    setState(() {
      _question.addAll(tempList);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Questions of $name'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(right: 8, left: 8),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: _question.length,
          itemBuilder: (context, index) {
            Question question = _question[index];
            return Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Card(
                color: Colors.purpleAccent.shade100,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ListTile(
                      leading:
                          Text('${index + 1}.', style: TextStyle(fontSize: 20)),
                      title: Text('${question.que}',
                          style: TextStyle(fontSize: 20)),
                      trailing: IconButton(
                          onPressed: () {
                            setState(() {
                              showAlertDialog(question, context);
                              print(question.qid);

                            });
                          },
                          icon: Icon(Icons.delete)),
                    ),
                    ListTile(
                      leading: Radio(
                        value: 1,
                        groupValue: question.ans,
                        onChanged: (value) {},
                      ),
                      title: Text(question.op1),
                    ),
                    ListTile(
                      leading: Radio(
                        value: 2,
                        groupValue: question.ans,
                        onChanged: (value) {},
                      ),
                      title: Text(question.op2),
                    ),
                    ListTile(
                      leading: Radio(
                        value: 3,
                        groupValue: question.ans,
                        onChanged: (value) {},
                      ),
                      title: Text(question.op3),
                    ),
                    ListTile(
                      leading: Radio(
                        value: 4,
                        groupValue: question.ans,
                        onChanged: (value) {},
                      ),
                      title: Text(question.op4),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> showAlertDialog(Question question, BuildContext context) async {
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
              deleteQuestions(question, context);
              Navigator.pop(context, false);
              print("Qid:${question.qid}");
            },
            child: Text('Yes'),
          )
        ],
      ),
    );
  }
}
