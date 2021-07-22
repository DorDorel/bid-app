class CustomUser {
  late String uid;
  final String tenantId;
  final String email;
  final String password;
  final String name;
  bool isAdmin = false;

  CustomUser({
    required this.tenantId,
    required this.email,
    required this.password,
    required this.name,
  });

  Map<String, dynamic> toMap() => {
        'uid': this.uid,
        'tenantId': this.tenantId,
        'email': this.email,
        'name': this.name,
        'isAdmin': this.isAdmin
      };

  factory CustomUser.fromMap(Map<String, dynamic> firestoreObj) {
    CustomUser user = CustomUser(
        tenantId: firestoreObj['tenantId'],
        email: firestoreObj['email'],
        password: 'null',
        name: firestoreObj['name']);

    return user;
  }
}
