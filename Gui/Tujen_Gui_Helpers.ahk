hexArrToStr(array){
  Str := ""
  For Index, Value In array
    {
    value := Format("0x{1:06X}", value)
    Str .= "," . Value
    }
  Str := LTrim(Str, ",")
  return Str
}
; Check if a specific value is part of an array and return the index
indexOf(var, Arr, fromIndex:=1){
  for index, value in Arr {
    if (index < fromIndex){
      Continue
    }else if (value = var){
      return index
    }
  }
}
; Check if a specific value is part of an array's array and return the parent index
indexOfArr(var, Arr, fromIndex:=1){
  for index, a in Arr 
  {
    if (index < fromIndex)
      Continue
    for k, value in a
      if (value = var)
        return index
  }
  Return False
}