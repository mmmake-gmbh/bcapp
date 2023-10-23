import 'package:bildungscampus_app/core/enums/user_type.dart';

class UserTypeUtils {
  static bool isUserTypedAllowed(
      UserType allowedUserType, UserType currentUserType) {
    if (allowedUserType == UserType.notLoggedIn ||
        currentUserType == UserType.admin ||
        allowedUserType == currentUserType) {
      return true;
    }

    if (allowedUserType == UserType.loggedIn &&
        currentUserType == UserType.fourtyTwo) {
      return true;
    }

    return false;
  }
}
