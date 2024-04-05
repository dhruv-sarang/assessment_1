import 'package:e_learning_app/preference/pref_manager.dart';
import 'package:e_learning_app/view/add_question/add_question.dart';
import 'package:e_learning_app/view/category/category_view.dart';
import 'package:e_learning_app/view/login/loginView.dart';
import 'package:e_learning_app/view/quiz/quizView.dart';
import 'package:e_learning_app/view/read_question/readQuestionView.dart';
import 'package:e_learning_app/view/read_question/select_category_read.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    loadData();
    super.initState();
    print('Home : ${PrefManager.getLoginStatus()}');
  }

  String name = '';

  void loadData() {
    setState(() {
      PrefManager.getName(name);
    });
  }

  void status(st, BuildContext context) {
    st = !st;
    PrefManager.statusChange(st);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ECORP'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (String result) {},
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              PopupMenuItem<String>(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CategoryView()
                      ));
                },
                child: Text('Manage Category'),
              ),
              PopupMenuItem<String>(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddQuestion()
                      ));
                },
                child: Text('Add Question'),
              ),
              PopupMenuItem<String>(
                onTap: () {
                  // ProfileDialog(context);
                },
                child: Text('About Us'),
              ),
              PopupMenuItem<String>(
                onTap: () {},
                child: Text('Contact Us'),
              ),
              PopupMenuItem<String>(
                onTap: () {
                  showAlertDialog(context);
                },
                child: Text('Logout'),
              ),
            ],
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: GridView.extent(
            // scrollDirection: Axis.horizontal,
            maxCrossAxisExtent: MediaQuery.of(context).size.width * 0.5,
            childAspectRatio: 1,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => QuizView(),
                      ));
                },
                child: Card(
                    child: Center(
                        child:
                            Text('Play Quiz', style: TextStyle(fontSize: 28))),
                    color: Colors.purpleAccent.shade100),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SelectCategoryReadView(),
                      ));
                },
                child: Card(
                    child: Center(
                      child: Text('Read Questions',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 28)),
                    ),
                    color: Colors.purpleAccent.shade100),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> showAlertDialog(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Alert'),
        content: Text('Are you sure you want to Logout'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context, false);
            },
            child: Text('No'),
          ),
          TextButton(
            onPressed: () {
              status(PrefManager.getLoginStatus(), context);
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginView(),
                  ),
                  (route) => false);
            },
            child: Text('Yes'),
          )
        ],
      ),
    );
  }
}
