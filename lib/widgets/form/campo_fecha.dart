import 'package:app_demo/screens/screens.dart';
import 'package:flutter/services.dart';

class CampoFecha extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final String? Function(String?)? validator;
  final bool isOptional;
  final bool enabled;

  const CampoFecha({
    super.key,
    required this.controller,
    required this.label,
    required this.hint,
    this.validator,
    this.isOptional = false,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
                letterSpacing: 0.3,
              ),
            ),
            if (isOptional) ...[
              const SizedBox(width: 4),
              Text(
                '(opcional)',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey.shade600,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ],
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          enabled: enabled,
          style: TextStyle(
            fontSize: 15,
            color: enabled ? Colors.black87 : Colors.grey.shade400,
            fontWeight: FontWeight.w500,
          ),
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[0-9\-]')),
            LengthLimitingTextInputFormatter(20),
            DateInputFormatter(),
          ],
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              color: Colors.grey.shade400,
              fontSize: 15,
              fontWeight: FontWeight.normal,
            ),
            filled: true,
            fillColor: enabled ? Colors.white : Colors.grey.shade100,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade200),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade200),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade200),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.black87, width: 1.5),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.red.shade300),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.red.shade400, width: 1.5),
            ),
            suffixIcon: Icon(
              Icons.calendar_today,
              size: 18,
              color: enabled ? Colors.grey.shade400 : Colors.grey.shade300,
            ),
          ),
          validator: validator ?? (isOptional ? null : _defaultValidator),
        ),
      ],
    );
  }

  String? _defaultValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return isOptional ? null : 'Requerido';
    }

    final String trimmedValue = value.trim();

    final yearRegex = RegExp(r'^\d{4}$');
    final fullDateRegex = RegExp(r'^\d{4}-\d{2}-\d{2}$');

    if (!yearRegex.hasMatch(trimmedValue) &&
        !fullDateRegex.hasMatch(trimmedValue)) {
      return 'Formato: AAAA o AAAA-MM-DD';
    }

    if (fullDateRegex.hasMatch(trimmedValue)) {
      final date = DateTime.tryParse(trimmedValue);

      if (date == null) {
        return 'Fecha inválida (Día/Mes incorrecto)';
      }
    }

    if (yearRegex.hasMatch(trimmedValue)) {
      final year = int.tryParse(trimmedValue);
      if (year == null || year < 1000 || year > 9999) {
        return 'Año inválido (1000-9999)';
      }
    }

    return null;
  }
}
