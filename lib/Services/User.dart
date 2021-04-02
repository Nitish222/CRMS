class User{
  String userID;
  String password;
  String rank;

  User({this.userID,this.password, this.rank});

  factory User.fromJson(Map<String,dynamic> json){
    return User(
      userID: json['user_id'] as String,
      password: json['user_password'] as String,
      rank: json['user_rank'] as String,
    );
  }
}