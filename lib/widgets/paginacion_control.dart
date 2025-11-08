import '../screens/screens.dart';

class PaginacionControl extends StatelessWidget {
  final ObraProvider provider;
  final VoidCallback? onPreviousPage;
  final VoidCallback? onNextPage;

  const PaginacionControl({
    super.key,
    required this.provider,
    this.onPreviousPage,
    this.onNextPage,
  });

  @override
  Widget build(BuildContext context) {
    final paginacion = provider.paginacion;
    final paginaActual = provider.paginaActual;

    final bool hayAnterior = paginaActual > 1;
    final bool haySiguiente = paginacion?.hayPaginaSiguiente ?? true;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Botón anterior
          IconButton(
            onPressed: hayAnterior
                ? (onPreviousPage ?? provider.irAPaginaAnterior)
                : null,
            icon: const Icon(Icons.chevron_left),
            iconSize: 24,
            style: IconButton.styleFrom(
              backgroundColor: hayAnterior
                  ? const Color(0xFF43656E)
                  : Colors.grey.withOpacity(0.1),
            ),
          ),

          const SizedBox(width: 16),

          // Indicador de página
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Colors.blue,
              ),
            ),
            child: Text(
              paginacion != null
                  ? '${paginacion.paginaActual} / ${paginacion.paginasTotales}'
                  : '$paginaActual',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
          ),

          const SizedBox(width: 16),

          // Botón siguiente
          IconButton(
            onPressed: haySiguiente
                ? (onNextPage ?? provider.irAPaginaSiguiente)
                : null,
            icon: const Icon(Icons.chevron_right),
            iconSize: 24,
            style: IconButton.styleFrom(
              backgroundColor: haySiguiente
                  ? const Color(0xFF43656E)
                  : Colors.grey.withOpacity(0.1),
            ),
          ),
        ],
      ),
    );
  }
}
