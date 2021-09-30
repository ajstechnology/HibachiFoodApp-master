class LanguageModel {
  String code;
  String englishName;
  String localName;
  String flag;
  bool selected;

  LanguageModel(this.code, this.englishName, this.localName, this.flag,
      {this.selected = false});
}

class LanguagesList {
  List<LanguageModel> _languages;

  LanguagesList() {
    this._languages = [
      new LanguageModel("en", "English", "English",
          "assets/img/united-states-of-america.png"),
      new LanguageModel(
          "ar", "Arabic", "العربية", "assets/img/united-arab-emirates.png"),
      new LanguageModel("es", "Spanish", "Spana", "assets/img/spain.png"),
      new LanguageModel("fr", "French (France)", "Français - France",
          "assets/img/france.png"),
      new LanguageModel("fr_CA", "French (Canada)", "Français - Canadien",
          "assets/img/canada.png"),
      new LanguageModel(
          "pt_BR", "Portugese (Brazil)", "Brazilian", "assets/img/brazil.png"),
      new LanguageModel(
          "ko", "Korean", "Korean", "assets/img/united-states-of-america.png"),
    ];
  }

  List<LanguageModel> get languages => _languages;
}
