import 'package:app_demo/screens/screens.dart';

class SelectorOcupacion extends StatefulWidget {
  const SelectorOcupacion({super.key});

  @override
  State<SelectorOcupacion> createState() => _SelectorOcupacionState();
}

class _SelectorOcupacionState extends State<SelectorOcupacion> {
  Ocupacion? _ocupacionElegida;

  @override
  Widget build(BuildContext context) {
    return Consumer<OcupacionProvider>(
      builder: (context, provider, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Ocupaciones',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.black87,
                letterSpacing: 0.3,
              ),
            ),
            const SizedBox(height: 12),

            // Dropdown con botón agregar
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<Ocupacion>(
                        value: _ocupacionElegida,
                        hint: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            'Selecciona una ocupación',
                            style: TextStyle(color: Colors.grey, fontSize: 15),
                          ),
                        ),
                        isExpanded: true,
                        icon: const Padding(
                          padding: EdgeInsets.only(right: 12),
                          child: Icon(Icons.keyboard_arrow_down, size: 20),
                        ),
                        items: provider.ocupaciones.map((ocupacion) {
                          final isSelected =
                              provider.isOcupacionSelected(ocupacion.id);
                          return DropdownMenuItem<Ocupacion>(
                            value: ocupacion,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Row(
                                children: [
                                  if (isSelected)
                                    Icon(Icons.check,
                                        size: 16, color: Colors.blue.shade300),
                                  if (isSelected) const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      ocupacion.name,
                                      style: TextStyle(
                                        color: isSelected
                                            ? Colors.grey
                                            : Colors.black87,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() => _ocupacionElegida = value);
                        },
                      ),
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 30,
                    color: Colors.grey.shade200,
                  ),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: _ocupacionElegida == null
                          ? null
                          : () {
                              if (!provider
                                  .isOcupacionSelected(_ocupacionElegida!.id)) {
                                provider.addOcupacion(_ocupacionElegida!);
                              }
                              setState(() => _ocupacionElegida = null);
                            },
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(12),
                        bottomRight: Radius.circular(12),
                      ),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        child: Icon(
                          Icons.add,
                          color: _ocupacionElegida == null
                              ? Colors.grey.shade400
                              : Colors.blue,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Chips de ocupaciones seleccionadas
            if (provider.ocupacionesElegidas.isNotEmpty) ...[
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: provider.ocupacionesElegidas.map((ocupacion) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.blue.shade100),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          ocupacion.name,
                          style: TextStyle(
                            color: Colors.blue.shade900,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(width: 6),
                        GestureDetector(
                          onTap: () => provider.removeOcupacion(ocupacion.id),
                          child: Icon(
                            Icons.close,
                            size: 16,
                            color: Colors.blue.shade700,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],
          ],
        );
      },
    );
  }
}
