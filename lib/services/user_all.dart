class User_all{
  int id;
  String username;
  String email;
  String password;

  User_all({
    required this.id,
    required this.username,
    required this.email,
    required this.password
  });

  factory User_all.fromJson(Map<String, dynamic>json){
    return switch(json){
      {
      'id' : int id,
      'username' : String username,
      'email' : String email,
      'password' : String password
      } =>
          User_all(
              id: id,
              username: username,
              email: email,
              password: password
          ),
      _ => throw const FormatException('Failed to users')
    };
  }
}