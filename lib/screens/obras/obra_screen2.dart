import 'package:app_demo/widgets/lista_info.dart';

import '../screens.dart';

class ObraScreen2 extends StatelessWidget {
  const ObraScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    final handler = Provider.of<PaginaHandler>(context, listen: false);
    final obraDetalleProvider =
        Provider.of<ObraDetalleProvider>(context, listen: false);
    String idObjeto = handler.numeroObjeto;

    return Scaffold(
      body: FutureBuilder<ObraDetalle>(
        future: obraDetalleProvider.getObraPorId(idObjeto),
        builder: (BuildContext context, AsyncSnapshot<ObraDetalle> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Loading();
          } else if (snapshot.hasError) {
            print(snapshot.hasError);
            return ErrorMsg(msgError: snapshot.error.toString());
          } else if (!snapshot.hasData) {
            return const ErrorMsg(msgError: 'No se encontró la obra');
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

  Widget _buildError(BuildContext context, String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 64,
            color: Colors.red[300],
          ),
          const SizedBox(height: 16),
          Text(
            'Error',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey[600]),
            ),
          ),
        ],
      ),
    );
  }
}
