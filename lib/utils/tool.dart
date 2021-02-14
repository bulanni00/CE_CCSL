bool isEmpty(Object object) {
  print('11');
  print(object);
  if (object == null) return true;
  print('222');
  if (object is String && object.isEmpty) {
    return true;
  } else if (object is List && object.isEmpty) {
    return true;
  } else if (object is Map && object.isEmpty) {
    return true;
  }
  return false;
}

int stringToInt(String str) {
  if (str == null) {
    return 0;
  } else {
    return int.parse(str);
  }
}
