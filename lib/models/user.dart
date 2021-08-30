class CustomUser {
  late String uid;
  final String tenantId;
  final String email;
  final String password;
  final String name;
  final String phoneNumber;
  bool isAdmin = false;

  CustomUser(
      {required this.tenantId,
      required this.email,
      required this.password,
      required this.name,
      required this.phoneNumber});

  Map<String, dynamic> toMap() => {
        'uid': this.uid,
        'tenantId': this.tenantId,
        'email': this.email,
        'name': this.name,
        'isAdmin': this.isAdmin,
        'phoneNumber': this.phoneNumber
      };

  factory CustomUser.fromMap(Map<String, dynamic> firestoreObj) {
    CustomUser user = CustomUser(
        tenantId: firestoreObj['tenantId'],
        email: firestoreObj['email'],
        password: 'null',
        name: firestoreObj['name'],
        phoneNumber: firestoreObj['phoneNumber']);

    return user;
  }
}
