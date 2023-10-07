class VendorUserModel {
  final bool approved;
  // final String cityValue;
  // final String countryValue;
  final String emailAddress;
  final String phoneNumber;
  final String shopName;
  // final String stateValue;
  final String storeImage;
  final String vendorId;
  final bool status;

  VendorUserModel(
      {required this.approved,
      // required this.cityValue,
      // required this.countryValue,
      required this.emailAddress,
      required this.phoneNumber,
      required this.shopName,
      // required this.stateValue,
      required this.storeImage,
      required this.vendorId,
      required this.status});

  VendorUserModel.fromJson(Map<String, Object?> json)
      : this(
          approved: json['approved']! as bool,
          // cityValue: json['cityValue']! as String,
          // countryValue: json['countryValue']! as String,
          emailAddress: json['emailAddress']! as String,
          phoneNumber: json['phoneNumber']! as String,
          shopName: json['shopName']! as String,
          // stateValue: json['stateValue']! as String,
          storeImage: json['storeImage']! as String,
          vendorId: json['vendorId']! as String,
          status: json['status']! as bool,
        );

  Map<String, Object?> toJson() {
    return {
      'approved': approved,
      // 'cityValue': cityValue,
      // 'countryValue': countryValue,
      'emailAddress': emailAddress,
      'phoneNumber': phoneNumber,
      'shopName': shopName,
      // 'stateValue': stateValue,
      'storeImage': storeImage,
      'vendorId': vendorId,
      'status':status,
    };
  }
}
