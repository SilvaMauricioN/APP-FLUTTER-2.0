import 'package:app_demo/screens/screens.dart';

class Cabecera extends StatelessWidget {
  final ObraDetalle obraDetalle;

  const Cabecera({super.key, required this.obraDetalle});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Título
          Text(
            obraDetalle.title,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[900],
                ),
          ),

          const SizedBox(height: 8),

          // Título largo (si es diferente)
          if (obraDetalle.longTitle != obraDetalle.title &&
              obraDetalle.longTitle.isNotEmpty)
            Text(
              obraDetalle.longTitle,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.grey[600],
                    fontStyle: FontStyle.italic,
                  ),
            ),

          const SizedBox(height: 16),

          // Autor
          if (obraDetalle.principalOrFirstMaker?.name.isNotEmpty ?? false)
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.person,
                    color: Theme.of(context).primaryColor,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Artista',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.black,
                            ),
                      ),
                      Text(
                        obraDetalle.principalOrFirstMaker!.name,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
