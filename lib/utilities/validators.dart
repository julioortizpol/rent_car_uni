bool validateEmail(String value) {
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = new RegExp(pattern);
  return (!regex.hasMatch(value)) ? false : true;
}

bool validateDominicanId(String dominicanId) {
  int checkerDigit;
  int sum = 0;
  try {
    if (dominicanId.length != 11) {
      return false;
    }
    checkerDigit = int.parse(dominicanId.substring(10, 11));

    dominicanId = dominicanId.substring(0, 10);
    dominicanId.split("").asMap().forEach((i, element) {
      int mod = ((i % 2) == 0) ? 1 : 2;
      int res = int.parse(element) * mod;
      if (res > 9) {
        String resString = res.toString();
        int uno = int.parse(resString.substring(0, 1));
        int dos = int.parse(resString.substring(1, 2));
        res = uno + dos;
      }
      sum += res;
    });
    var el_numero = (10 - (sum % 10)) % 10;
    if (el_numero == checkerDigit && dominicanId.substring(0, 3) != "000") {
      return true;
    }
  } catch (e) {
    print(e);
  }
  return false;
}
