extension StringNullExtension on String? {
  bool get isNotEmptyNull => this != null && this!.isNotEmpty;
}

extension StringExtension on String {
  String addIfNotEmpty(String? value) {
    return isNotEmpty ? this + (value ?? '') : this;
    // On-liners are gold -loool
    //if (isNotEmpty) {
    //  return this + value;
    //} else {
    //  return this;
    //}
  }

  String addIfEmpty(String? value) {
    return isEmpty ? this + (value ?? '') : this;
  }
}
