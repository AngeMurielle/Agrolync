class UserModel {
  final String uid;
  final String fullName;
  final String email;
  final String phoneNumber;
  final String profileImage;
  final String address;
  final double walletBalance; // XAF
  final List<String> favoriteProductIds;

  UserModel({
    required this.uid,
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.profileImage,
    required this.address,
    this.walletBalance = 0.0,
    this.favoriteProductIds = const [],
  });

  // Quick factory for a mock user (useful for the Profile Screen)
  factory UserModel.mock() {
    return UserModel(
      uid: "USER123",
      fullName: "Ange Murielle",
      email: "murielle@agrolync.cm",
      phoneNumber: "+237 600 000 000",
      profileImage: "assets/images/user_avatar.png", // Download: user_avatar.png
      address: "Douala, Cameroon",
      walletBalance: 250000.0,
    );
  }
}