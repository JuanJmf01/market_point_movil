import 'dart:io';

import 'package:etfi_point/Components/Data/EntitiModels/categoriaTb.dart';
import 'package:etfi_point/Components/Data/Entities/categoriaDb.dart';
import 'package:etfi_point/Components/Utils/ButtonMenu.dart';
import 'package:etfi_point/Components/Utils/roundedSearchBar.dart';
import 'package:etfi_point/Pages/categorie.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(115.0),
        child: AppBar(
          backgroundColor: Colors.grey[200],
          title: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TabBar(
                      controller: _tabController,
                      indicatorSize: TabBarIndicatorSize.label,
                      indicatorColor: Colors.grey[800],
                      isScrollable: true,
                      tabs: const [
                        Tab(
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text('Productos',
                                style: TextStyle(color: Colors.black)),
                          ),
                        ),
                        Tab(
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text('Ofertas',
                                style: TextStyle(color: Colors.black)),
                          ),
                        ),
                        Tab(
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text('Domiciliarios',
                                style: TextStyle(color: Colors.black)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
            ],
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: IconButton(
                onPressed: () {
                  showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    builder: (BuildContext context) => ButtonMenu(),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        topRight: Radius.circular(10.0),
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.menu, color: Colors.black, size: 35),
              ),
            ),
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(50.0),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: RoundedSearchBar(
                controller: searchController,
              ),
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        physics:
            const NeverScrollableScrollPhysics(), // Evita el desplazamiento horizontal
        children: [
          ListView(
            children: [
              HorizontalList(),
              HorizontalCategories(),
              //RowProducts(producto: producto)
            ],
          ),
          // Agrega aquí el contenido de la pestaña "Ofertas"
          Ofertas(),
          // Agrega aquí el contenido de la pestaña "Nuevos"
          Container(
            child: Center(
              child: Text('Nuevos'),
            ),
          ),
        ],
      ),
    );
  }
}

class Ofertas extends StatelessWidget {
  const Ofertas({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [HorizontalList(), HorizontalCategories()],
    );
  }
}

class HorizontalList extends StatelessWidget {
  const HorizontalList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 255,
      child: ListView.separated(
        padding: EdgeInsets.all(15.0),
        scrollDirection: Axis.horizontal,
        itemCount: 6,
        separatorBuilder: (context, _) => SizedBox(width: 12),
        itemBuilder: (context, index) => buildCard(),
      ),
    );
  }

  Widget buildCard() => Container(
        width: 200,
        //color: Colors.redAccent.shade200,
        child: Column(
          children: [
            Expanded(
                child: AspectRatio(
                    aspectRatio: 4 / 3,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(33.0),
                      child: Container(
                        color:
                            Colors.grey[200], //Intercambior por iamgen  (abajo)
                      ),
                      // child: Material(
                      //   child: Ink.image(
                      //     image: AssetImage('lib/images/PapasSaladas.jpg'),
                      //     fit: BoxFit.cover,
                      //     child: InkWell(
                      //       onTap: (){},
                      //     ),
                      //   ),
                      // )
                    ))),
            const Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Text(
                'Prueba title',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
              ),
            )
          ],
        ),
      );
}

class HorizontalCategories extends StatelessWidget {
  HorizontalCategories({super.key});

  List<CategoriaTb> categorias = [];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CategoriaTb>>(
        future: CategoriaDb.categorias(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            categorias = snapshot.data!;
            return SizedBox(
                height: 95.0,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categorias.length,
                    itemBuilder: (BuildContext context, int index) {
                      final CategoriaTb categoria = categorias[index];
                      return Container(
                        padding: const EdgeInsets.all(10.0),
                        width: 100.0,
                        child: Column(
                          children: [
                            Container(
                              padding:
                                  const EdgeInsets.fromLTRB(0.0, 1.0, 0.0, 0.0),
                              child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Categorie(
                                                idCategoria:
                                                    categoria.idCategoria!)));
                                  },
                                  child: SizedBox(
                                    height: 48.0,
                                    child:
                                        Image.file(File(categoria.imagePath!)),
                                  )),
                            ),
                            Container(
                              padding: const EdgeInsets.only(top: 3.0),
                              child: Text(
                                categoria.nombre,
                                style: const TextStyle(
                                    fontSize: 14.5,
                                    fontWeight: FontWeight.w500),
                              ),
                            )
                          ],
                        ),
                      );
                    }));
          } else if (snapshot.hasError) {
            return Text('Error al cargas las categorias');
          }
          return const Center(child: CircularProgressIndicator());
        });
  }
}
