import 'package:form_builder_multi_dropdown/form_builder_multi_dropdown.dart';

class ProgrammingLanguage {
  final int id;
  final String name;
  final String creator;

  const ProgrammingLanguage({
    required this.id,
    required this.name,
    required this.creator,
  });
}

class Country {
  final String code;
  final String name;

  const Country({required this.code, required this.name});
}

/// Static data sources utilized across the multi-dropdown demo pages
class MockData {
  static const List<ProgrammingLanguage> languages = [
    ProgrammingLanguage(id: 1, name: 'Dart', creator: 'Google'),
    ProgrammingLanguage(id: 2, name: 'Kotlin', creator: 'JetBrains'),
    ProgrammingLanguage(id: 3, name: 'Swift', creator: 'Apple'),
    ProgrammingLanguage(id: 4, name: 'TypeScript', creator: 'Microsoft'),
    ProgrammingLanguage(id: 5, name: 'Rust', creator: 'Mozilla / Foundation'),
    ProgrammingLanguage(id: 6, name: 'Go', creator: 'Google'),
  ];

  static const List<Country> countries = [
    Country(code: 'VN', name: 'Vietnam'),
    Country(code: 'US', name: 'United States'),
    Country(code: 'JP', name: 'Japan'),
    Country(code: 'KR', name: 'South Korea'),
    Country(code: 'DE', name: 'Germany'),
  ];

  static const List<String> frameworks = [
    'Flutter',
    'React Native',
    'NativeScript',
    'Ionic',
    'Xamarin',
  ];

  static Future<List<DropdownItem<ProgrammingLanguage>>>
  fetchLanguagesAsync() async {
    await Future.delayed(const Duration(milliseconds: 600));
    return languages
        .map(
          (lang) =>
              DropdownItem<ProgrammingLanguage>(label: lang.name, value: lang),
        )
        .toList();
  }
}
