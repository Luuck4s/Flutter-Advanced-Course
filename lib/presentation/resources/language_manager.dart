enum LanguageType{
  ENGLISH,
  PORTUGUESE
}

const String ENGLISH = "en";
const String PORTUGUESE = "pt-br";

extension LanguageTypeExtesion on LanguageType{
  String getValue(){
    switch(this){
      case LanguageType.ENGLISH:
        return ENGLISH;
      case LanguageType.PORTUGUESE:
        return PORTUGUESE;
    }
  }
}