class UserAccount {
  String uiid;
  String email;
  String phonenumber;
  String displayname;
  String password;
  String userToken;
  UserAccount(this.uiid, this.email, this.phonenumber, this.password,
      this.displayname, this.userToken);

  Map<String, dynamic> createMap() {
    return {
      'uid': uiid,
      'email': email,
      'phone': phonenumber,
      'displayname': displayname
    };
  }

  // UserAccount.fromFirestore(Map<String, dynamic> firestoreMap)
  //     : productId = firestoreMap['productId'],
  //       productName = firestoreMap['productName'],
  //       price = firestoreMap['productPrice'];
}
