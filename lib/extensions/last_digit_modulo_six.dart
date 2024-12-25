extension LastDigitModuloSix on int {
  int get lastDigitModuloSix {
    int lastDigit = this % 10;
    int result = lastDigit % 6;
    return result == 0 ? 6 : result;
  }
}
