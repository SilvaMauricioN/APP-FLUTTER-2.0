import 'package:app_demo/screens/screens.dart';

class TituloExtra extends StatelessWidget {
  final IconData icono;
  final String titulo;
  final List<TituloAlternativo> items;
  final Color color;

  const TituloExtra({
    super.key,
    required this.icono,
    required this.titulo,
    required this.items,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 32, right: 16, bottom: 0),
      child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            // color: color.withOpacity(1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: color.withOpacity(1)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(icono, color: color),
                  const SizedBox(width: 12),
                  Text(
                    titulo,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              ...items.map((title) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.chevron_right_sharp, size: 18, color: color),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          title.alternativeTitle
                              .toString(), // Ajusta según tu modelo
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
              // Wrap(
              //   spacing: 8,
              //   runSpacing: 8,
              //   children: items.map((item) {
              //     return Chip(
              //       label: Text(item.alternativeTitle),
              //       backgroundColor: color.withOpacity(0.1),
              //       labelStyle: TextStyle(
              //         color: color.withOpacity(0.9),
              //         fontWeight: FontWeight.w500,
              //       ),
              //       side: BorderSide(color: color.withOpacity(0.3)),
              //     );
              //   }).toList(),
              // ),
            ],
          )),
    );
  }
}
