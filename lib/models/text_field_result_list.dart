part of '../text_form_builder.dart';

class TextFieldResultList {
  final List<TextFieldResult> results;

  TextFieldResultList(this.results);

  TextFieldResult find(String id) {
    return results.firstWhere(
      (result) => result.id == id,
      orElse: () => TextFieldResult(id, null),
    );
  }

  bool contains(String id) {
    bool exists = false;

    for (final result in results) {
      if (result.id == id) {
        exists = true;
        break;
      }
    }

    return exists;
  }
}
