import 'package:app_demo/screens/screens.dart';

class WidgetError extends StatelessWidget {
  final String errorMsg;

  const WidgetError({super.key, required this.errorMsg});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 60,
            ),
            const SizedBox(height: 16),
            Text(
              '¡Ups! Un problema ha ocurrido',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.black87,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              errorMsg,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            // Opcional: botón para reintentar (requeriría pasar un callback)
            // const SizedBox(height: 20),
            // ElevatedButton(onPressed: () { /* reintentar */ }, child: const Text('Reintentar')),
          ],
        ),
      ),
    );
  }
}
