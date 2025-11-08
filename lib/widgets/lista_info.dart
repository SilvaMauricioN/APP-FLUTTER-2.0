import 'package:app_demo/screens/screens.dart';

class ListaInfo extends StatelessWidget {
  final ObraDetalle obraDetalle;

  const ListaInfo({super.key, required this.obraDetalle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (obraDetalle.datings?.yearEarly != null)
            InfoCard(
              icono: Icons.hourglass_full,
              texto: 'Año',
              valor: obraDetalle.datings!.yearEarly.toString(),
              color: Colors.blue,
            ),
          const SizedBox(height: 12),
          InfoCard(
            icono: Icons.location_on,
            texto: 'Lugar',
            valor: obraDetalle.productionPlaces!.first,
            color: Colors.green,
          ),
          const SizedBox(height: 12),
          if (obraDetalle.physicalMedium.isNotEmpty)
            InfoCard(
              icono: Icons.palette,
              texto: 'Medio',
              valor: obraDetalle.physicalMedium,
              color: Colors.purple,
            ),
          if (obraDetalle.physicalMedium.isNotEmpty) const SizedBox(height: 12),
          InfoCard(
            icono: Icons.label_important_rounded,
            texto: 'Etiqueta',
            valor: obraDetalle.sclabelline,
            color: Colors.orange,
          ),
        ],
      ),
    );
  }
}
