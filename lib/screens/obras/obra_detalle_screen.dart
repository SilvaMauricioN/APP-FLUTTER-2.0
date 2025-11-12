import '../screens.dart';

class ObraDetalleScreen extends StatefulWidget {
  const ObraDetalleScreen({super.key});

  @override
  State<ObraDetalleScreen> createState() => _ObraDetalleState();
}

class _ObraDetalleState extends State<ObraDetalleScreen> {
  @override
  void initState() {
    super.initState();
    final handler = Provider.of<PaginaHandler>(context, listen: false);
    final obraDetalleProvider =
        Provider.of<ObraDetalleProvider>(context, listen: false);

    String idObjeto = handler.numeroObjeto;
    Future.microtask(() => obraDetalleProvider.getObraDetalle(idObjeto));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Consumer<ObraDetalleProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return const Loading();
        }
        if (provider.hasError) {
          final error = provider.errorMsg;
          final objError = provider.error;
          if (objError is EntidadNoEncontradaException) {
            return RecursoNoEncontrado(
              mensaje: objError.detail,
              onVolver: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const ObraDetalleScreen())),
            );
          } else {
            return WidgetError(errorMsg: error.toString());
          }
        }

        if (provider.listaObraDetalle.isEmpty) {
          return const WidgetError(errorMsg: 'Error interno');
        }
        final List<ObraDetalle> obras = provider.listaObraDetalle;
        final ObraDetalle obraDetalle = obras[0];

        return _contenidoPantalla(context, obraDetalle);
      },
    ));
  }

  Widget _contenidoPantalla(BuildContext context, ObraDetalle obraDetalle) {
    return CustomScrollView(
      slivers: [
        // App Bar con imagen de fondo
        ObraAppBar(obraDetalle: obraDetalle),

        // Contenido
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Cabecera(obraDetalle: obraDetalle),
              ListaInfo(obraDetalle: obraDetalle),

              if (obraDetalle.description.isNotEmpty)
                Seccion(
                  titulo: 'Descripción',
                  icono: Icons.article_outlined,
                  color: Colors.blue,
                  child: Text(
                    obraDetalle.description,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          height: 1.4,
                          color: Colors.grey[600],
                        ),
                  ),
                ),

              if (obraDetalle.historicalDescription?.isNotEmpty ?? false)
                Seccion(
                  titulo: 'Historia',
                  icono: Icons.account_balance_outlined,
                  color: Colors.green,
                  child: Text(
                    obraDetalle.historicalDescription!,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          height: 1.4,
                          color: Colors.grey[600],
                        ),
                  ),
                ),

              if (obraDetalle.plaqueDescription.isNotEmpty)
                Seccion(
                  titulo: 'Placa',
                  icono: Icons.history_edu,
                  color: Colors.purple,
                  child: Text(
                    obraDetalle.plaqueDescription,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          height: 1.4,
                          color: Colors.grey[600],
                        ),
                  ),
                ),

              ExtraInfo(
                  icono: Icons.style_rounded,
                  titulo: 'Materiales',
                  items: obraDetalle.materials!,
                  color: Colors.orange),

              ExtraInfo(
                  icono: Icons.brush_outlined,
                  titulo: 'Tipo de Objeto',
                  items: obraDetalle.objectTypes ?? ['Desconcido'],
                  color: Colors.blue),

              // Títulos alternativos
              TituloExtra(
                  icono: Icons.list_outlined,
                  titulo: 'Titulos Alternativos',
                  items: obraDetalle.otherTitles!,
                  color: Colors.green),

              const SizedBox(height: 32),
            ],
          ),
        ),
      ],
    );
  }
}
