class Iconprods {
  static final Map<String, String> imageMap = {
    'hamburguer': '../../assets/images/burger.png',
  };

  static String getImage(String name) {

    if (imageMap.containsKey(name)) {

      return imageMap[name]!;

    } else {

      return '';
    }
  }
}