abstract class AppUtil {
  static bool isStringEmpty(String? str) {
    if (str != null && str.isNotEmpty && str.trim().isNotEmpty) {
      return false;
    }
    return true;
  }
}
