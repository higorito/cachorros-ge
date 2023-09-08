import 'package:flutter/material.dart';

import '../data/model/cachorros_model.dart';
import '../data/repository/cachorro_repo.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool carregando = false;
  var cachorrosModel = CachorrosModel();
  var cachorroRepo = CachorroRepo();

  // @override
  // void initState() async {
  //   super.initState();
  //   cachorrosModel = await cachorroRepo.getDoguinhos();
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: Drawer(
          child: Column(
            children: [
              UserAccountsDrawerHeader(
                accountName: const Text("Nome do Usuário"),
                accountEmail: const Text(""),
              ),
              ListTile(
                leading: const Icon(Icons.home),
                title: const Text("Home"),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.favorite),
                title: const Text("Favoritos"),
                onTap: () {},
              ),
            ],
          ),
        ),
        appBar: AppBar(
          title: const Text('Gerador de Cachorros'),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.favorite,
                color: Colors.redAccent,
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            (cachorrosModel.status == "success")
                ? Expanded(
                    flex: 3,
                    child: SizedBox(
                      width: double.infinity,
                      child: Image.network(
                        cachorrosModel.message.toString(),
                        scale: 1,
                        fit: BoxFit.fill,
                      ),
                    ))
                : Expanded(
                    flex: 3,
                    child: Container(
                      color: Colors.greenAccent[100],
                    ),
                  ),
            (carregando)
                ? Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    height: 60,
                    margin: EdgeInsets.all(20),
                    child: const CircularProgressIndicator())
                : Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    height: 60,
                    margin: EdgeInsets.all(20),
                    child: FloatingActionButton(
                        onPressed: () async {
                          setState(() {
                            carregando = true;
                          });
                          cachorrosModel = await cachorroRepo.getDoguinhos();
                          setState(
                            () {
                              carregando = false;
                            },
                          );
                        },
                        child: Text("CLIQUE PARA GERAR DOGS")),
                  ),
          ],
        ),
      ),
    );
  }
}
