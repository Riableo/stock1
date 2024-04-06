class Iconprods {
  static final Map<String, String> imageMap = {
    'hamburger': 'assets/images/burger.png',
    'soda' : 'assets/images/soda.png',
    'pizza' : 'assets/images/pizza.png',
    'hotdog' : 'assets/images/hotdog.png',
    'taco' : 'assets/images/taco.png'
  };

  static String getImage(String name) {

    if (imageMap.containsKey(name)) {

      return imageMap[name]!;

    } else {

      return '';
    }
  }
}