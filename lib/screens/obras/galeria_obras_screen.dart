import '../screens.dart';

class GaleriaObrasScreen extends StatelessWidget {
  const GaleriaObrasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Cargar obras
    final obraProvider = Provider.of<ObraProvider>(context, listen: false);
    const double padding = 2;
    if (obraProvider.obras.isEmpty &&
        !obraProvider.isLoading &&
        obraProvider.hasError == false) {
      Future.microtask(() => obraProvider.getColeccionObras());
    }

    return Consumer<ObraProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return const Loading();
        }

        if (provider.hasError) {
          final objError = provider.error;
          if (objError is EntidadNoEncontradaException) {
            return RecursoNoEncontrado(
              mensaje: objError.detail,
            );
          } else {
            return WidgetError(errorMsg: objError.toString());
          }
        }

        if (provider.obras.isEmpty) {
          return const WidgetError(errorMsg: 'Error interno');
        }
        List<Obra> listaColeccion = provider.obras;

        return Column(
          children: [
            // _buildPaginationControls(context, provider),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(padding),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisExtent: 300,
                    crossAxisSpacing: padding,
                    mainAxisSpacing: padding),
                itemCount: listaColeccion.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => FullScreen(
                              url: listaColeccion[index].webImage.url,
                              context: context)));
                    },
                    child: Hero(
                      tag: 'imageHero$index',
                      child: GaleriaCard(
                          titulo: limitarTexto(listaColeccion[index].title),
                          subTitulo: limitarTexto(
                              listaColeccion[index].principalOrFirstMaker),
                          url: listaColeccion[index].webImage.url,
                          objectNumber: listaColeccion[index].objectNumber,
                          context: context),
                    ),
                  );
                },
              ),
            ),
            PaginacionControl(provider: provider),
          ],
        );
      },
    );
  }

  String limitarTexto(String texto) {
    const int maxNombre = 28;
    return texto.length > maxNombre
        ? '${texto.substring(0, maxNombre)}..'
        : texto;
  }
}
