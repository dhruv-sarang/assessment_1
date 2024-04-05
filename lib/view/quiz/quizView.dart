import 'dart:math';

import 'package:e_learning_app/detabase/db_helper.dart';
import 'package:e_learning_app/model/question.dart';
import 'package:e_learning_app/preference/pref_manager.dart';
import 'package:flutter/material.dart';

class QuizView extends StatefulWidget {
  @override
  State<QuizView> createState() => _QuizViewState();
}

class _QuizViewState extends State<QuizView> {
  final List<Question> questions = [];
  int currentQuestionIndex = 0;
  bool showResult = false;
  int selectedAnswers = 0;
  List<int> correctAnswers = [];
  int correctAnswerCount = 0;
  DbHelper dbHelper = DbHelper();

  @override
  void initState() {
    super.initState();
    loadQuestions();
  }

  String name = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // timer
        title: Text('Welcome ${PrefManager.getName(name).split(' ').first}'),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: showResult
            ? showQuizResult() // Display quiz result if showResult is true
            : questions.isEmpty
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : buildQuizScreen(), // Display quiz screen otherwise
      ),
    );
  }

  Widget buildQuizScreen() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          height: 130,
          decoration: BoxDecoration(
              color: Colors.purpleAccent.shade100,
              borderRadius: BorderRadius.circular(20),
              border: Border.all()),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${currentQuestionIndex}/${questions.length}",
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    "Questions",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        Container(
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            children: [
              Text(
                "Question ${currentQuestionIndex + 1}",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Text(
                '${questions[currentQuestionIndex].que}',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 10),
              ListTile(
                leading: Radio(
                  value: 1,
                  groupValue: selectedAnswers,
                  onChanged: (value) {
                    setState(() {
                      selectedAnswers = value!;
                    });
                  },
                ),
                title: Text(questions[currentQuestionIndex].op1),
              ),
              ListTile(
                leading: Radio(
                  value: 2,
                  groupValue: selectedAnswers,
                  onChanged: (value) {
                    setState(() {
                      selectedAnswers = value!;
                    });
                  },
                ),
                title: Text(questions[currentQuestionIndex].op2),
              ),
              ListTile(
                leading: Radio(
                  value: 3,
                  groupValue: selectedAnswers,
                  onChanged: (value) {
                    setState(() {
                      selectedAnswers = value!;
                    });
                  },
                ),
                title: Text(questions[currentQuestionIndex].op3),
              ),
              ListTile(
                leading: Radio(
                  value: 4,
                  groupValue: selectedAnswers,
                  onChanged: (value) {
                    setState(() {
                      selectedAnswers = value!;
                    });
                  },
                ),
                title: Text(questions[currentQuestionIndex].op4),
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.purpleAccent.shade200)),
          onPressed: () {
            if (selectedAnswers == 0) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Please select an answer!')),
              );
              return;
            }
            if (selectedAnswers == questions[currentQuestionIndex].ans) {
              correctAnswerCount++;
              print("Current");
            }
            if (currentQuestionIndex < questions.length - 1) {
              setState(() {
                currentQuestionIndex++;
                selectedAnswers = 0;
              });
            } else {
              setState(() {
                showResult = true;
              });
            }
          },
          child: Text(currentQuestionIndex == questions.length - 1
              ? 'Finish Quiz'
              : 'Next'),
        ),
      ],
    );
  }

  Widget showQuizResult() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Quiz Completed!',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        Text(
          'Your Correct Answers: $correctAnswerCount/${questions.length}',
          style: TextStyle(fontSize: 18),
        ),
      ],
    );
  }

  Future<void> loadQuestions() async {
    var lists = await dbHelper.getAllQuestion();
    lists.shuffle();

    // Select only the first 5 questions
    setState(() {
      questions.addAll(lists.sublist(0, min(5, lists.length)));
    });
  }
}