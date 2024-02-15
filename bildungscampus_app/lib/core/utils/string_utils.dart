class StringUtils {
  static String enumName(String enumToString) {
    List<String> paths = enumToString.split(".");
    return paths[paths.length - 1];
  }

  static bool isNewestVersion(String baseVersion, String toCompareVersion) {
    List<String> base = baseVersion.split(".");
    List<String> toCompare = toCompareVersion.split(".");

    for (var i = 0; i < base.length; i++) {
      final baseInt = int.tryParse(base[i]) ?? 0;
      final toCompareInt =
          i < toCompare.length ? int.tryParse(toCompare[i]) ?? 0 : 0;
      if (baseInt > toCompareInt) {
        return false;
      }
    }

    return true;
  }
}

extension IsNullOrEmptyCompare on String? {
  bool isEmptyOrNull() {
    if (this == null) {
      return true;
    }
    return this!.isEmpty;
  }
}
