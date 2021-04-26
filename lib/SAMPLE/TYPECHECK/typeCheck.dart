
String typeOf(dynamic obj){
  String tp = '';
  if (obj.runtimeType == String){
    //print("-it's a String");
    tp = 'String';
  }else if (obj.runtimeType == int){
    //print("-it's a Int");
    tp = 'int';
  }else if (obj.runtimeType == [].runtimeType){
    //print("-it's a List/Array");
    tp = '[]';
  }else if (obj.runtimeType == {}.runtimeType){
    //print("-it's a Map/Object/Dict");
    tp = '{}';
  }else {
    //print("\n>> See this type is not their .\n");
  }
  return tp;
}