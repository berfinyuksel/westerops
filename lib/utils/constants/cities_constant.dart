class CitiesConstant {
  static List<String> citiesIndexes() {
    List<String> citiesIndexes = [];
    for (int i = 1; i < 82; i++) {
      citiesIndexes.add("${i < 10 ? 0 : ""}$i");
    }
    return citiesIndexes;
  }

  static const cities = [
    'Istanbul',
  ];
}
