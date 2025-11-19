import 'package:app_demo/screens/screens.dart';

class ArtistaFormScreen extends StatefulWidget {
  const ArtistaFormScreen({super.key});

  @override
  State<ArtistaFormScreen> createState() => _ArtistaFormScreenState();
}

class _ArtistaFormScreenState extends State<ArtistaFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _placeOfBirthController = TextEditingController();
  final _dateOfBirthController = TextEditingController();
  final _dateOfDeathController = TextEditingController();
  final _placeOfDeathController = TextEditingController();
  final _nationalityController = TextEditingController();

  Artista? _artistaInicial;
  bool get isEditMode => _artistaInicial != null;
  bool _isInitialized = false;

// acceder al context para leer los Providers, y context no está disponible en initState().
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    //evita que se ejecute múltiples veces
    if (!_isInitialized) {
      final paginaHandler = context.read<PaginaHandler>();
      _artistaInicial = paginaHandler.artistaParaEditar;

      if (isEditMode) {
        _cargarDatosArtista();
      }

      final ocupacionProvider = context.read<OcupacionProvider>();
      ocupacionProvider.getOcupaciones().then((_) {
        if (isEditMode) {
          ocupacionProvider
              .setSelectedFromExisting(_artistaInicial!.occupations);
        }
      });

      _isInitialized = true;
    }
  }

  void _cargarDatosArtista() {
    final artista = _artistaInicial!;
    _nameController.text = artista.name;
    _placeOfBirthController.text = artista.placeOfBirth ?? '';
    _dateOfBirthController.text = artista.dateOfBirth ?? '';
    _dateOfDeathController.text = artista.dateOfDeath ?? '';
    _placeOfDeathController.text = artista.placeOfDeath ?? '';
    _nationalityController.text = artista.nationality ?? '';
  }

  @override
  void dispose() {
    _resetForm();

    _nameController.dispose();
    _placeOfBirthController.dispose();
    _dateOfBirthController.dispose();
    _dateOfDeathController.dispose();
    _placeOfDeathController.dispose();
    _nationalityController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    final paginaProvider = context.read<PaginaHandler>();

    if (!_formKey.currentState!.validate()) {
      MensajeApi.showError(context, 'Completa todos los campos');
      return;
    }

    final ocupacionProvider = context.read<OcupacionProvider>();
    final artistaProvider = context.read<ArtistaProvider>();

    if (ocupacionProvider.ocupacionesElegidas.isEmpty) {
      MensajeApi.showError(context, 'Selecciona al menos una ocupación');
      return;
    }

    final artista = Artista(
        idPrincipalMaker: _artistaInicial?.idPrincipalMaker,
        name: _nameController.text.trim(),
        placeOfBirth: _placeOfBirthController.text.trim(),
        dateOfBirth: _dateOfBirthController.text.trim(),
        dateOfDeath: _dateOfDeathController.text.trim(),
        placeOfDeath: _placeOfDeathController.text.trim(),
        nationality: _nationalityController.text.trim(),
        occupations: ocupacionProvider.getSelectedOcupacionesAsObjects());

    bool success;
    if (isEditMode) {
      success = await artistaProvider.updateArtista(artista);
      paginaProvider.limpiarArtistaAEditar();
      _resetForm();
    } else {
      success = await artistaProvider.postArtista(artista);
      paginaProvider.limpiarArtistaAEditar();
      _resetForm();
    }

    if (!mounted) return;
    if (success) {
      MensajeApi.showSuccess(
          context, isEditMode ? 'Artista actualizado' : 'Artista creado');
      await Future.delayed(const Duration(milliseconds: 2000));
      paginaProvider.paginaActual = 1;
    } else {
      MensajeApi.showError(context, artistaProvider.errorMessage ?? 'Error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          isEditMode ? 'Editar Artista' : 'Nuevo Artista',
          style: const TextStyle(
            color: Colors.black87,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Consumer2<OcupacionProvider, ArtistaProvider>(
        builder: (context, ocupacionProvider, artistaProvider, child) {
          // Estado de carga de ocupaciones
          if (ocupacionProvider.isLoadingPeticionBase) {
            return const Loading();
          }

          // Error al cargar ocupaciones
          if (ocupacionProvider.ocupaciones.isEmpty &&
              ocupacionProvider.errorMsg != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline,
                      size: 48, color: Colors.red.shade300),
                  const SizedBox(height: 12),
                  const Text('Error al cargar ocupaciones'),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () => ocupacionProvider.getOcupaciones(),
                    child: const Text('Reintentar'),
                  ),
                ],
              ),
            );
          }

          // Formulario
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Nombre
                    CustomCampoTexto(
                      controller: _nameController,
                      label: 'Nombre completo',
                      hint: 'Rembrandt van Rijn',
                      validator: (v) => v == null || v.trim().length < 3
                          ? 'Mínimo 3 caracteres'
                          : null,
                    ),
                    const SizedBox(height: 24),

                    // Fechas
                    Row(
                      children: [
                        Expanded(
                            child: CampoFecha(
                                controller: _dateOfBirthController,
                                label: 'Fecha Nac.',
                                hint: '1606-12-23')),
                        const SizedBox(width: 16),
                        Expanded(
                            child: CampoFecha(
                                controller: _dateOfDeathController,
                                label: 'Fecha Fall.',
                                hint: '1669-11-24 o vacio',
                                isOptional: true)),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Lugares
                    Row(
                      children: [
                        Expanded(
                          child: CustomCampoTexto(
                            controller: _placeOfBirthController,
                            label: 'Lugar nac.',
                            hint: 'Leiden',
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: CustomCampoTexto(
                            controller: _placeOfDeathController,
                            label: 'Lugar fall.',
                            hint: 'Ámsterdam',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Nacionalidad
                    CustomCampoTexto(
                      controller: _nationalityController,
                      label: 'Nacionalidad',
                      hint: 'Holandés',
                    ),
                    const SizedBox(height: 32),

                    // Selector de ocupaciones
                    const SelectorOcupacion(),
                    const SizedBox(height: 120),

                    // Botón guardar
                    SizedBox(
                      height: 60,
                      child: ElevatedButton(
                        onPressed:
                            artistaProvider.isLoading ? null : _submitForm,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black87,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: artistaProvider.isLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : Text(
                                isEditMode ? 'Actualizar' : 'Guardar',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.5,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _resetForm() {
    _formKey.currentState?.reset();

    _nameController.clear();
    _placeOfBirthController.clear();
    _dateOfBirthController.clear();
    _dateOfDeathController.clear();
    _placeOfDeathController.clear();
    _nationalityController.clear();

    context.read<OcupacionProvider>().clearSelectedOcupaciones();
  }
}
