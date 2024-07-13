import 'package:flutter/material.dart';
import 'package:imc_flutter_app/models/imc.dart';
import 'package:imc_flutter_app/repository/imc_repository.dart';
import 'package:imc_flutter_app/shared/widgets/imc_item_detail.dart';
import 'package:imc_flutter_app/shared/widgets/imc_list_item.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<IMC> imcItems = [];
  ImcRepository imcRepository = ImcRepository();
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchImcItems();
  }

  void fetchImcItems() async {
    imcItems = await imcRepository.fetch();
    setState(() {});
  }

  void addNewItem(IMC item) async {
    showDialog(
        context: context,
        builder: (BuildContext bc) {
          return AlertDialog(
            title: const Text(
              'O resultado do cálculo foi:',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
            ),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                ImcItemDetail(
                  content: item.imcClassification(),
                  label: "Classificação",
                ),
                ImcItemDetail(content: item.imcIndex(), label: "Indice"),
                ImcItemDetail(content: "${item.height} m", label: "Altura:"),
                ImcItemDetail(content: "${item.weight} Kg", label: "Peso"),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  fetchImcItems();
                },
                child: const Text("OK"),
              )
            ],
          );
        });
    await imcRepository.add(item);
    fetchImcItems();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Calculadora de IMC"),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          child: imcItems.isEmpty
              ? const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Você ainda não tem nenhum cálculo no histórico"),
                      Text("Clique no botão '+' para adicionar!")
                    ],
                  ),
                )
              : Expanded(
                  child: ListView.builder(
                      itemCount: imcItems.length,
                      itemBuilder: (BuildContext bc, int index) {
                        var item = imcItems[index];
                        return Dismissible(
                          onDismissed: (DismissDirection direction) async {
                            await imcRepository.remove(item.id);
                            fetchImcItems();
                          },
                          key: Key(item.id),
                          child: ImcListItem(
                            title: item.imcClassification(),
                            id: item.id,
                            height: item.height,
                            weight: item.weight,
                            creationDate: item.creationDate,
                          ),
                        );
                      }),
                ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet<void>(
              context: context,
              isScrollControlled: true,
              builder: (BuildContext context) {
                return Padding(
                  padding: EdgeInsets.only(
                      left: 15,
                      right: 15,
                      top: 20,
                      bottom: MediaQuery.of(context).viewInsets.bottom + 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const Text(
                        'Insira os dados:',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 18),
                      ),
                      const Divider(),
                      const SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: heightController,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                          labelText: "Altura",
                          // hintText: "1,65 m",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: weightController,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.done,
                        decoration: const InputDecoration(
                          labelText: "Peso",
                          hintText: "65,2 Kg",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          OutlinedButton(
                            onPressed: () {
                              heightController.text = "";
                              weightController.text = "";
                              Navigator.pop(context);
                            },
                            child: const Text("Cancelar"),
                          ),
                          FilledButton(
                            child: const Text('Calcular IMC'),
                            onPressed: () {
                              IMC imc = IMC(
                                double.parse(
                                    heightController.text.replaceAll(",", ".")),
                                double.parse(
                                    weightController.text.replaceAll(",", ".")),
                              );
                              heightController.text = "";
                              weightController.text = "";
                              Navigator.pop(context);
                              addNewItem(imc);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
