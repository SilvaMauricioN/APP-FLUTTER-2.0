import 'package:flutter/services.dart';

class DateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // deja solo dígitos.
    final String digitsOnly = newValue.text.replaceAll(RegExp(r'[^\d]'), '');

    String formattedText = '';

    // longitud máxima de la entrada a 8 dígitos (YYYYMMDD).
    final int inputLength = digitsOnly.length;
    if (inputLength > 8) {
      return oldValue;
    }

    //inserta guiones:
    if (inputLength > 0) {
      // YYYY
      formattedText += digitsOnly.substring(0, inputLength.clamp(0, 4));
    }
    if (inputLength > 4) {
      // -MM
      formattedText += '-';
      formattedText += digitsOnly.substring(4, inputLength.clamp(4, 6));
    }
    if (inputLength > 6) {
      // -DD
      formattedText += '-';
      formattedText += digitsOnly.substring(6, inputLength.clamp(6, 8));
    }

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}
