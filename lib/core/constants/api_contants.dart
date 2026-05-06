class ApiConstants {
  static const String baseUrl = 'https://www.themealdb.com/api//json/v1/1';

  // endpoint
  static String filterByCategory(String category) => '$baseUrl/filter.php?c=$category';
  static String searchByLetter(String letter) => '$baseUrl/search.php?f=$letter';
  static String searchByName(String name) => '$baseUrl/search.php?s=$name';
  static String mealDetail(String id) => '$baseUrl/lookup.php?i=$id';

  static const String defaultCategory = 'Seafood';
}
