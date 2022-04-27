String translateToLatin(String value) {
  String translate = '';

  value.runes.forEach((element) {
    var character = getTranslatedChar(String.fromCharCode(element), false);
    translate = translate + character;
  });

  return translate;
}

String translateToCyrillic(String value) {
  String translate = '';

  value.runes.forEach((element) {
    var character = getTranslatedChar(String.fromCharCode(element), true);
    translate = translate + character;
  });

  return translate;
}

String getTranslatedChar(String string, bool isLatin) {
  if(string == '\n')
    return '\n';
  if(string == ' ')
    return ' ';
  if(string.contains(RegExp(r'[\\n0-9&={}\[\]\./_\-+,<>\$%|\?!"@()]')))
    return string == 'n'? 'н': string;

  String firstLetter = string;

  if(firstLetter.toUpperCase() == string)
    {
      if(isLatin)
        return latinToCyrillic['${string.toLowerCase()}'].toUpperCase();
      else
        return cyrillicToLatin['${string.toLowerCase()}'].toUpperCase();
    }
  else
    {
      if(isLatin)
        return latinToCyrillic[string];
      else
        return cyrillicToLatin[string];
    }
}

Map<String, String> latinToCyrillic = {
'a':'а',
'ä':'ә',
'b':'б',
'd':'д',
'e':'е',
'f':'ф',
'g':'г',
'ğ':'ғ',
'h':'х',
'i':'и',
'ı':'і',
'j':'ж',
'k':'к',
'l':'л',
'm':'м',
'n':'н',
'ŋ':'ң',
'o':'о',
'ö':'ө',
'p':'п',
'q':'қ',
'r':'р',
's':'с',
'ş':'ш',
't':'т',
'u':'у',
'ū':'ұ',
'ü':'ү',
'v':'в',
'y':'ы',
'z':'з',
};

Map<String, String> cyrillicToLatin = {
'а':'a',
'ә':'ä',
'б':'b',
'в':'v',
'г':'g',
'ғ':'ğ',
'д':'d',
'е':'e',
'ж':'j',
'з':'z',
'и':'i',
'й':'i',
'к':'k',
'қ':'q',
'л':'l',
'м':'m',
'н':'n',
'ң':'ŋ',
'о':'o',
'ө':'ö',
'п':'p',
'р':'r',
'с':'s',
'т':'t',
'у':'u',
'ұ':'ū',
'ү':'ü',
'ф':'f',
'х':'h',
'һ':'h',
'ц':'s',
'ч':'ş',
'ш':'ş',
'щ':'ş',
'ъ':'',
'ы':'y',
'і':'ı',
'ь':'',
'э':'e',
'ю':'iu',
'я':'ia',
};