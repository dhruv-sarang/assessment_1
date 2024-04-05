class Category {
  int? id;
  String CategoryName;

  Category({required this.CategoryName});

  Map<String, dynamic> toMap() {
    return {"CategoryName": this.CategoryName, "cid": this.id};
  }

  Category.withId({this.id, required this.CategoryName});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category.withId(
      id: json['cid'] as int,
      CategoryName: json['CategoryName'] as String? ?? '',
    );
  }
}
