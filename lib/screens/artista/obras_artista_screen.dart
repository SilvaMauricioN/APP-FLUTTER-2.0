import 'package:app_demo/screens/screens.dart';
import 'package:app_demo/widgets/tarjeta_artista2.dart';
import 'package:app_demo/widgets/card_img.dart';

class ObrasArtistaScreen extends StatelessWidget {
  const ObrasArtistaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final handler = Provider.of<PaginaHandler>(context, listen: false);
    final museumService = Provider.of<MuseumService>(context, listen: false);
    Artista? artista = handler.artistaSeleccionado2;

    return FutureBuilder<List<Obra>>(
      future: museumService.getObrasPorArtista(artista.name),
      builder: (BuildContext context, AsyncSnapshot<List<Obra>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Loading();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          List<Obra> listaObras = snapshot.data!;

          return Scaffold(
            backgroundColor: const Color(0xFFF5F5F5),
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Color(0xFF1a1a1a)),
                onPressed: () => {},
              ),
              title: const Text(
                'Artista',
                style: TextStyle(
                  color: Color(0xFF1a1a1a),
                  fontWeight: FontWeight.w600,
                ),
              ),
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
                  Icons.person_add_alt,
                ),
              ),
            ),
            body: CustomScrollView(
              slivers: [
                // Widget del Artista - Se desplaza con el scroll
                SliverToBoxAdapter(
                  child: ArtistaCard(artista: artista),
                ),

                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
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
                            child: ObraCard(obra: listaObras[index]),
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
        }
      },
    );
  }
}
