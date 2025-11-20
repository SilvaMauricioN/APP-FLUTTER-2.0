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

    final paginaHandler = Provider.of<PaginaHandler>(context, listen: false);
    final providerArtista =
        Provider.of<ArtistaProvider>(context, listen: false);

    final nombreArtista = paginaHandler.artistaSeleccionado;

    providerArtista.limpiarEstado();
    Future.microtask(
      () => providerArtista.getObrasArtistaPorNombre(nombreArtista),
    );
  }

  @override
  Widget build(BuildContext context) {
    final paginaHandler = context.watch<PaginaHandler>();
    Artista? artista = paginaHandler.artistaParaEditar;

    return Consumer<ArtistaProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return const Loading();
        }

        if (provider.hasError) {
          final objError = provider.error;
          if (objError is! EntidadNoEncontradaException) {
            return WidgetError(errorMsg: provider.errorMessage!);
          }
        }

        if (artista == null) {
          return const ArtistaNoElegido();
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
              onPressed: () {
                paginaHandler.navegarAArtistaFormulario(artista: artista);
              },
              tooltip: 'Editar Artista',
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
