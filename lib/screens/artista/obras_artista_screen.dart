import 'package:app_demo/screens/screens.dart';

class ObrasArtistaScreen extends StatefulWidget {
  const ObrasArtistaScreen({super.key});

  @override
  State<ObrasArtistaScreen> createState() => _ObrasArtistaScreenState();
}

class _ObrasArtistaScreenState extends State<ObrasArtistaScreen> {
  @override
  void initState() {
    super.initState();

    final handler = Provider.of<PaginaHandler>(context, listen: false);
    final providerArtista =
        Provider.of<ArtistaProvider>(context, listen: false);

    final artista = handler.artistaSeleccionado2;

    providerArtista.limpiarEstado();
    Future.microtask(
      () => providerArtista.getObrasArtistaPorNombre(artista.name),
    );
  }

  @override
  Widget build(BuildContext context) {
    final handler = context.watch<PaginaHandler>();
    // final providerArtista =
    //     Provider.of<ArtistaProvider>(context, listen: false);
    Artista artista = handler.artistaSeleccionado2;
    // if (providerArtista.isLoadingBase) {
    //   debugPrint('loading artista screen ${providerArtista.isLoading}');
    //   return const Loading();
    // }

    return Consumer<ArtistaProvider>(
      builder: (context, provider, child) {
        if (provider.isLoadingPeticionBase) {
          return const Loading();
        }

        if (provider.hasError) {
          final objError = provider.error;
          if (objError is! EntidadNoEncontradaException) {
            return WidgetError(errorMsg: provider.errorMsg!);
          }
        }

        List<Obra> listaObras = provider.listaObrasDeArtista;

        return Scaffold(
          backgroundColor: const Color(0xFFF5F5F5),
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            title: const Text(
              'Artista',
              style: TextStyle(
                fontSize: 20,
                color: Color(0xFF1a1a1a),
                fontWeight: FontWeight.w600,
              ),
            ),
            actions: const [],
          ),
          floatingActionButton: Container(
            margin: const EdgeInsets.only(bottom: 20, right: 12),
            child: FloatingActionButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              backgroundColor: Colors.blue,
              elevation: 0,
              onPressed: () => {},
              tooltip: 'Agregar Artista',
              child: const Icon(
                Icons.edit_square,
              ),
            ),
          ),
          body: CustomScrollView(
            slivers: [
              // Widget del Artista - Se desplaza con el scroll
              SliverToBoxAdapter(
                child: TarjetaArtistaDetalle(artista: artista),
              ),
              if (listaObras.isEmpty)
                ArtistaSinObras(name: artista.name)
              else
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  sliver: SliverGrid(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.75,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => FullScreen(
                                        url: listaObras[index].webImage.url,
                                        context: context)));
                          },
                          child: Hero(
                            tag: 'imageHero$index',
                            child: ObraCardImg(obra: listaObras[index]),
                          ),
                        );
                        //ObraCard(obra: listaObras[index]);
                      },
                      childCount: listaObras.length,
                    ),
                  ),
                ),

              const SliverToBoxAdapter(
                child: SizedBox(height: 24),
              ),
            ],
          ),
        );
      },
    );
  }
}
