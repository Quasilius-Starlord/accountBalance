class User{
  // {
  // "id": 1,
  // "name": "name",
  // "email": "email.com",
  // "username": "username",
  // "guid": "ab8558ae-deb1-4a2e-80b9-4c08b6ae3bdd",
  // "image_id": "img",
  // "phone": "911",
  // "created_at": "2024-08-04T15:42:29.573+00:00",
  // "monthly_salary": 100,
  // "salary_credit_date": "2000-11-10T15:42:29.573+00:00",
  // "account_balance": 100,
  // "hashed_password": "password"
  // }
  final String name;
  final String email;
  final String username;
  final int monthlySalary;
  final int accountBalance;

  User(this.name, this.email,this.username, this.monthlySalary, this.accountBalance);
  factory User.fromMap(Map<String, dynamic> json){
    return User(json['name'], json['email'], json['username'], json['monthly_salary'], json['account_balance']);
  }

  @override
  String toString() {
    // TODO: implement toString
     return "$username $email $name $monthlySalary $accountBalance";
  }
}