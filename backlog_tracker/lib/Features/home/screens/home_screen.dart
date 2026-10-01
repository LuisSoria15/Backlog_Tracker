import 'package:backlog_tracker/Features/home/models/item.dart';
import 'package:backlog_tracker/Features/home/widgets/item_card.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var txt1 = TextEditingController();
  var txt2 = TextEditingController();

  List<Item> itemList = [
    Item(
      titulo: "Actividad de ejemplo",
      categoria: "Categoria",
      completado: true,
    ),
  ];

  String dropdownvalue = 'Libros';
  List<String> listCategorias = <String>[
    'Libros',
    'Videojuegos',
    'Tareas',
    'Recetas',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Nuestra pantalla scaffold
      appBar: appBar(), //el appbar
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(5),
                itemCount: itemList.length,
                itemBuilder: (context, index) {
                  final currentItem = itemList[index];
                  return Dismissible(
                    key: ValueKey(currentItem.titulo),

                    onDismissed: (DismissDirection direction) {
                      setState(() {
                        itemList.removeAt(index);
                      });
                      final snackBar = SnackBar(
                        content: Text("Se elimino correctamente el bloque"),
                        action: SnackBarAction(
                          label: 'dismiss',
                          onPressed: () {},
                        ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    },
                    
                    child: ItemCard(
                      item: currentItem,
                      onCheckboxChanged: (bool? nuevoValor) {
                        setState(() {
                          itemList[index] = Item(
                            titulo: currentItem.titulo,
                            categoria: currentItem.categoria,
                            completado: nuevoValor ?? false,
                          );
                        });
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),

      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton.large(
            onPressed: () => showDialog<String>(
              context: context,
              builder: (BuildContext context) {
                // 1. Envolvemos el AlertDialog con StatefulBuilder
                return StatefulBuilder(
                  builder: (context, setDialogState) {
                    return AlertDialog(
                      title: Text("Actividad"),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("Ingresa una actividad: "),
                          TextField(controller: txt1),
                          SizedBox(height: 10),
                          Text("A que categoria va a pertenecer: "),
                          SizedBox(
                            width: 200,
                            child: DropdownButton(
                              isExpanded: true,
                              value: dropdownvalue,
                              icon: Icon(Icons.keyboard_arrow_down),
                              items: listCategorias.map((String items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Text(items),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                // 2. Usamos setDialogState en lugar del setState normal
                                setDialogState(() {
                                  dropdownvalue = newValue!;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'Cancelar'),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            String texto1 = txt1.text;
                            String texto2 = dropdownvalue;

                            // 3. Este setState se queda normal porque actualiza tu lista principal
                            setState(() {
                              itemList.add(
                                Item(
                                  titulo: texto1,
                                  categoria: texto2,
                                  completado: false,
                                ),
                              );
                            });
                            Navigator.pop(context, 'Aceptar');
                            txt1.clear();
                            // txt2.clear(); // Si ya no usas txt2 para la categoría, puedes borrar esta línea
                          },
                          child: const Text('OK'),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
            foregroundColor: const Color.fromARGB(130, 34, 86, 129),
            backgroundColor: const Color.fromARGB(200, 112, 213, 231),
            child: const Icon(Icons.add),
          ),
          const SizedBox(height: 20),
          DecoratedBox(
            decoration: BoxDecoration(
              color: const Color.fromARGB(47, 130, 178, 255),
              borderRadius: BorderRadius.circular(
                4,
              ), // Corregí esto: le faltaba la palabra BorderRadius
            ),
            child: Text("Agregar item", style: TextStyle(color: Colors.black)),
          ),
        ],
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      title: Text(
        "Backlog Tracker",
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: const Color.fromARGB(92, 179, 229, 252),
      centerTitle: true,
      elevation: 2,
    );
  }
}
