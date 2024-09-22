import 'dart:math';

class Pictures {
  static const appicon = "assets/appicon/appicon.png";

  static const apple = "assets/icons/apple.png";
  static const cam000 = "assets/icons/cam000.png";
  static const gall000 = "assets/icons/gall000.png";
  static const avt000 = "assets/icons/avt000.png";
  static const add000 = "assets/icons/add000.png";
  static const List<String> proimgoptio000list = [cam000, gall000, avt000];

  static const bottomNav000Icons = [
    "assets/app_icons/explore.png",
    "assets/app_icons/wishlist.png",
    "assets/app_icons/listing.png",
    "assets/app_icons/messages.png",
    "assets/app_icons/bookings.png",
  ];

  static const calendr000 = "assets/app_icons/calendr000.png";

  static const liked = "assets/app_icons/liked.png";
  static const notliked = "assets/app_icons/notwish.png";

  static const pin = "assets/app_icons/pin.png";
  static const dummysport = "assets/app_icons/dummysport.png";
  static const star = "assets/app_icons/star.png";

  ///

  static String get random000ProfIcon =>
      Pictures.maleOwnersImgs[Random().nextInt(Pictures.maleOwnersImgs.length)];

  static const List<String> femaleOwnersImgs = [
    "assets/userprofiles_000/femaleowners/app000femaleowner_1.png",
    "assets/userprofiles_000/femaleowners/app000femaleowner_2.png",
    "assets/userprofiles_000/femaleowners/app000femaleowner_3.png",
    "assets/userprofiles_000/femaleowners/app000femaleowner_4.png",
    "assets/userprofiles_000/femaleowners/app000femaleowner_5.png",
  ];
  static const List<String> maleOwnersImgs = [
    "assets/userprofiles_000/maleowners/app000maleowner_1.png",
    "assets/userprofiles_000/maleowners/app000maleowner_2.png",
    "assets/userprofiles_000/maleowners/app000maleowner_3.png",
    "assets/userprofiles_000/maleowners/app000maleowner_4.png",
    "assets/userprofiles_000/maleowners/app000maleowner_5.png",
    "assets/userprofiles_000/maleowners/app000maleowner_6.png",
    "assets/userprofiles_000/maleowners/app000maleowner_7.png",
    "assets/userprofiles_000/maleowners/app000maleowner_8.png",
    "assets/userprofiles_000/maleowners/app000maleowner_9.png",
    "assets/userprofiles_000/maleowners/app000maleowner_10.png",
    "assets/userprofiles_000/maleowners/app000maleowner_11.png",
    "assets/userprofiles_000/maleowners/app000maleowner_12.png",
    "assets/userprofiles_000/maleowners/app000maleowner_13.png",
    "assets/userprofiles_000/maleowners/app000maleowner_14.png",
    "assets/userprofiles_000/maleowners/app000maleowner_15.png",
    "assets/userprofiles_000/maleowners/app000maleowner_16.png",
    "assets/userprofiles_000/maleowners/app000maleowner_17.png",
    "assets/userprofiles_000/maleowners/app000maleowner_18.png",
    "assets/userprofiles_000/maleowners/app000maleowner_19.png",
    "assets/userprofiles_000/maleowners/app000maleowner_20.png",
    "assets/userprofiles_000/maleowners/app000maleowner_21.png",
    "assets/userprofiles_000/maleowners/app000maleowner_22.png",
    "assets/userprofiles_000/maleowners/app000maleowner_23.png",
    "assets/userprofiles_000/maleowners/app000maleowner_24.png",
    "assets/userprofiles_000/maleowners/app000maleowner_25.png",
  ];

  static const List<String> soccerfemaleCoaches = [
    "assets/coaches/soccer_female_coaches/app000_femalesoccercoach_1.png",
    "assets/coaches/soccer_female_coaches/app000_femalesoccercoach_2.png",
    "assets/coaches/soccer_female_coaches/app000_femalesoccercoach_3.png",
    "assets/coaches/soccer_female_coaches/app000_femalesoccercoach_4.png",
    "assets/coaches/soccer_female_coaches/app000_femalesoccercoach_5.png",
  ];
  static const List<String> soccermaleCoaches = [
    "assets/coaches/soccer_male_coaches/app000_malesoccercoach_1.png",
    "assets/coaches/soccer_male_coaches/app000_malesoccercoach_2.png",
    "assets/coaches/soccer_male_coaches/app000_malesoccercoach_3.png",
    "assets/coaches/soccer_male_coaches/app000_malesoccercoach_4.png",
    "assets/coaches/soccer_male_coaches/app000_malesoccercoach_5.png",
    "assets/coaches/soccer_male_coaches/app000_malesoccercoach_6.png",
    "assets/coaches/soccer_male_coaches/app000_malesoccercoach_7.png",
    "assets/coaches/soccer_male_coaches/app000_malesoccercoach_8.png",
    "assets/coaches/soccer_male_coaches/app000_malesoccercoach_9.png",
    "assets/coaches/soccer_male_coaches/app000_malesoccercoach_10.png",
    "assets/coaches/soccer_male_coaches/app000_malesoccercoach_11.png",
    "assets/coaches/soccer_male_coaches/app000_malesoccercoach_12.png",
    "assets/coaches/soccer_male_coaches/app000_malesoccercoach_13.png",
    "assets/coaches/soccer_male_coaches/app000_malesoccercoach_14.png",
    "assets/coaches/soccer_male_coaches/app000_malesoccercoach_15.png",
    "assets/coaches/soccer_male_coaches/app000_malesoccercoach_16.png",
    "assets/coaches/soccer_male_coaches/app000_malesoccercoach_17.png",
    "assets/coaches/soccer_male_coaches/app000_malesoccercoach_18.png",
  ];
  static const List<String> basketballfemaleCoaches = [
    "assets/coaches/basketball_female_coaches/app000_femalebasketballcoach_1.png",
    "assets/coaches/basketball_female_coaches/app000_femalebasketballcoach_2.png",
    "assets/coaches/basketball_female_coaches/app000_femalebasketballcoach_3.png",
    "assets/coaches/basketball_female_coaches/app000_femalebasketballcoach_4.png",
    "assets/coaches/basketball_female_coaches/app000_femalebasketballcoach_5.png",
    "assets/coaches/basketball_female_coaches/app000_femalebasketballcoach_6.png",
    "assets/coaches/basketball_female_coaches/app000_femalebasketballcoach_7.png",
  ];
  static const List<String> basketballmaleCoaches = [
    "assets/coaches/basketball_male_coaches/app000_malebasketballcoach_1.png",
    "assets/coaches/basketball_male_coaches/app000_malebasketballcoach_2.png",
    "assets/coaches/basketball_male_coaches/app000_malebasketballcoach_3.png",
    "assets/coaches/basketball_male_coaches/app000_malebasketballcoach_4.png",
    "assets/coaches/basketball_male_coaches/app000_malebasketballcoach_5.png",
    "assets/coaches/basketball_male_coaches/app000_malebasketballcoach_6.png",
    "assets/coaches/basketball_male_coaches/app000_malebasketballcoach_7.png",
    "assets/coaches/basketball_male_coaches/app000_malebasketballcoach_8.png",
    "assets/coaches/basketball_male_coaches/app000_malebasketballcoach_9.png",
    "assets/coaches/basketball_male_coaches/app000_malebasketballcoach_10.png",
    "assets/coaches/basketball_male_coaches/app000_malebasketballcoach_11.png",
    "assets/coaches/basketball_male_coaches/app000_malebasketballcoach_12.png",
    "assets/coaches/basketball_male_coaches/app000_malebasketballcoach_13.png",
    "assets/coaches/basketball_male_coaches/app000_malebasketballcoach_14.png",
    "assets/coaches/basketball_male_coaches/app000_malebasketballcoach_15.png",
    "assets/coaches/basketball_male_coaches/app000_malebasketballcoach_16.png",
    "assets/coaches/basketball_male_coaches/app000_malebasketballcoach_17.png",
    "assets/coaches/basketball_male_coaches/app000_malebasketballcoach_18.png",
    "assets/coaches/basketball_male_coaches/app000_malebasketballcoach_19.png",
    "assets/coaches/basketball_male_coaches/app000_malebasketballcoach_20.png",
    "assets/coaches/basketball_male_coaches/app000_malebasketballcoach_21.png",
    "assets/coaches/basketball_male_coaches/app000_malebasketballcoach_22.png",
    "assets/coaches/basketball_male_coaches/app000_malebasketballcoach_23.png",
  ];
  static const List<String> tennisfemaleCoaches = [
    "assets/coaches/tennis_female_coaches/app000_femaletenniscoach_1.png",
    "assets/coaches/tennis_female_coaches/app000_femaletenniscoach_2.png",
    "assets/coaches/tennis_female_coaches/app000_femaletenniscoach_3.png",
    "assets/coaches/tennis_female_coaches/app000_femaletenniscoach_4.png",
    "assets/coaches/tennis_female_coaches/app000_femaletenniscoach_5.png",
    "assets/coaches/tennis_female_coaches/app000_femaletenniscoach_6.png",
    "assets/coaches/tennis_female_coaches/app000_femaletenniscoach_7.png",
    "assets/coaches/tennis_female_coaches/app000_femaletenniscoach_8.png",
    "assets/coaches/tennis_female_coaches/app000_femaletenniscoach_9.png",
    "assets/coaches/tennis_female_coaches/app000_femaletenniscoach_10.png",
    "assets/coaches/tennis_female_coaches/app000_femaletenniscoach_11.png",
  ];
  static const List<String> tennismaleCoaches = [
    "assets/coaches/tennis_male_coaches/app000_maletenniscoach_1.png",
    "assets/coaches/tennis_male_coaches/app000_maletenniscoach_2.png",
    "assets/coaches/tennis_male_coaches/app000_maletenniscoach_3.png",
    "assets/coaches/tennis_male_coaches/app000_maletenniscoach_4.png",
    "assets/coaches/tennis_male_coaches/app000_maletenniscoach_5.png",
    "assets/coaches/tennis_male_coaches/app000_maletenniscoach_6.png",
    "assets/coaches/tennis_male_coaches/app000_maletenniscoach_7.png",
    "assets/coaches/tennis_male_coaches/app000_maletenniscoach_8.png",
    "assets/coaches/tennis_male_coaches/app000_maletenniscoach_9.png",
    "assets/coaches/tennis_male_coaches/app000_maletenniscoach_10.png",
    "assets/coaches/tennis_male_coaches/app000_maletenniscoach_11.png",
    "assets/coaches/tennis_male_coaches/app000_maletenniscoach_12.png",
    "assets/coaches/tennis_male_coaches/app000_maletenniscoach_13.png",
    "assets/coaches/tennis_male_coaches/app000_maletenniscoach_14.png",
    "assets/coaches/tennis_male_coaches/app000_maletenniscoach_15.png",
    "assets/coaches/tennis_male_coaches/app000_maletenniscoach_16.png",
    "assets/coaches/tennis_male_coaches/app000_maletenniscoach_17.png",
    "assets/coaches/tennis_male_coaches/app000_maletenniscoach_18.png",
  ];
}
