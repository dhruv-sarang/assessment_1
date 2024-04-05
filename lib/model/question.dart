class Question {
  int? qid;
  String que;
  String op1;
  String op2;
  String op3;
  String op4;
  int? cid;
  int ans;
  int createdAt;

  Question(
      {this.qid,
      required this.que,
      required this.op1,
      required this.op2,
      required this.op3,
      required this.op4,
      required this.ans,
      this.cid,
      required this.createdAt});

  Map<String, dynamic> toMap() {
    return {
      'qid': qid,
      'que': que,
      'op1': op1,
      'op2': op2,
      'op3': op3,
      'op4': op4,
      'answer': ans,
      'cids': cid,
      'createdAt': createdAt
    };
  }

  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
        qid: map['qid'],
        que: map['que'],
        op1: map['op1'],
        op2: map['op2'],
        op3: map['op3'],
        op4: map['op4'],
        ans: map['answer'],
        cid: map['cids'],
        createdAt: map['createdAt']);
  }
}
