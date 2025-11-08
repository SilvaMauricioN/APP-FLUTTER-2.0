import '../screens.dart';

class ObraScreen extends StatelessWidget {
  const ObraScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final handler = Provider.of<PaginaHandler>(context, listen: false);
    final obraDetalleProvider =
        Provider.of<ObraDetalleProvider>(context, listen: false);
    String idObjeto = handler.numeroObjeto;

    final Future<ObraDetalle> obraFuture =
        obraDetalleProvider.getObraPorId(idObjeto);

    return Scaffold(
      body: FutureBuilder<ObraDetalle>(
        future: obraFuture, //obraDetalleProvider.getObraPorId(idObjeto),
        builder: (BuildContext context, AsyncSnapshot<ObraDetalle> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Loading();
          } else if (snapshot.hasError) {
            final error = snapshot.error;
            if (error is ObraNoEncontradaException) {
              return RecursoNoEncontrado(
                mensaje: 'Obra no encontrada',
                onVolver: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const ObraScreen())),
              );
            } else {
              return WidgetErrorServer(errorMsg: error.toString());
            }
          } else if (!snapshot.hasData) {
            return const WidgetErrorServer(errorMsg: 'No se encontró la obra');
          }

          ObraDetalle obraDetalle = snapshot.data!;
          return _contenidoPantalla(context, obraDetalle);
        },
      ),
    );
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
                  items: obraDetalle.objectTypes,
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
