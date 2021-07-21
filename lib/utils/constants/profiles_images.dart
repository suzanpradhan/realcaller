import 'dart:math';

class ProfileImages {
  final List<String> _profileImages = [
    "assets/images/icons/profiles/profile_black.png",
    "assets/images/icons/profiles/profile_dark_blue.png",
    "assets/images/icons/profiles/profile_dark_green.png",
    "assets/images/icons/profiles/profile_light_blue.png",
    "assets/images/icons/profiles/profile_light_green.png",
    "assets/images/icons/profiles/profile_pink.png",
    "assets/images/icons/profiles/profile_purple.png",
    "assets/images/icons/profiles/profile_red.png",
    "assets/images/icons/profiles/profile_white.png",
    "assets/images/icons/profiles/profile_yellow.png"
  ];

  String getRandomImage() {
    var random = Random();
    int number = random.nextInt(9);
    return _profileImages[number];
  }
}
