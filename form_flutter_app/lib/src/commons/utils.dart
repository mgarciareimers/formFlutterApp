// Method that evaluates if the input value is a number.
bool isNumber(String value) {
  return value.isNotEmpty && num.tryParse(value) != null;
}