class Character{
  late int char_id;
  late String name;
  late List<dynamic> occupation;
  late String img;
  late String status;
  late String nickname;
  late List <dynamic> appearance;
  late String portrayed;
  late  String category;
  late List <dynamic> better_call_saul_appearance;

  Character.fromJson(Map <String, dynamic> json){
    char_id = json["char_id"];
    name = json["name"];
    occupation = json["occupation"];
    img = json["img"].toString();
    status = json["status"];
    nickname = json["nickname"];
    appearance = json["appearance"];
    portrayed = json["portrayed"];
    category = json["category"];
    better_call_saul_appearance = json["better_call_saul_appearance"];
  }
}