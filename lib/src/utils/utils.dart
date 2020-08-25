bool isNumeric(String s){
  if(s.isEmpty && s == '0') return false;
  final n = num.tryParse(s);
  return (n==null)?false:true;
}

bool isEmpty(String s){
  return s.isEmpty?false:true;
}