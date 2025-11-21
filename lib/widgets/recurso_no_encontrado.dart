import 'package:app_demo/screens/screens.dart';

import 'package:flutter/material.dart';

class RecursoNoEncontrado extends StatelessWidget {
  final String message;
  final VoidCallback? onVolver;

  const RecursoNoEncontrado({
    super.key,
    this.message = 'Recurso no encontrado',
    this.onVolver,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Ícono ilustrativo
            const Icon(Icons.search_off, size: 90, color: Colors.grey),
            const SizedBox(height: 16),

            // Mensaje principal
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[700],
                  ),
            ),

            const SizedBox(height: 12),

            // Descripción más humana
            Text(
              'No hay datos para recurso solicitado.\n',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[600],
                  ),
            ),

            const SizedBox(height: 24),

            // Botón de acción opcional
            if (onVolver != null)
              ElevatedButton.icon(
                onPressed: onVolver,
                icon: const Icon(Icons.arrow_back),
                label: const Text('Volver'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey[700],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
