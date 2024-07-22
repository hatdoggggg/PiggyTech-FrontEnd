class UserDetail{
  final String email;
  final String phone;
  final String address;
  final String gender;

  UserDetail({
    required this.email,
    required this.phone,
    required this.address,
    required this.gender
  });

  Map<String, dynamic> toJson() =>{
    'email' : email,
    'phone' : phone,
    'address' : address,
    'gender' : gender
  };

}