import 'package:auau_gerador/src/cubit/dogs_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import 'favoritos.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // void _favoritar(context) async {
  //   final status = context.read<DogsCubit>().state.status;
  //   if (status == DogsStatus.success) {
  //     final foto = context.watch<DogsCubit>().state.message.toString();
  //     await context.watch<DogsCubit>().favoritar(foto);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: Drawer(
          child: Column(
            children: [
              ListTile(
                leading: const Icon(Icons.home),
                title: const Text("Home"),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.favorite),
                title: const Text("Favoritos"),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BlocProvider.value(
                        value: context.read<DogsCubit>(),
                        child: const FavoritosPage(),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        appBar: AppBar(
          title: const Text('Gerador de Cachorros'),
          centerTitle: true,
          actions: [
            BlocBuilder<DogsCubit, DogsState>(
              builder: (context, state) {
                return IconButton(
                  onPressed: () {
                    if (state.status == DogsStatus.success) {
                      final foto = state.message.toString();
                      context.read<DogsCubit>().favoritar(foto);
                    }
                  },
                  icon: const Icon(
                    Icons.favorite,
                    color: Colors.redAccent,
                  ),
                );
              },
            ),
          ],
        ),
        body: Center(
          child: Column(
            children: [
              const Expanded(flex: 3, child: _Conteudo()),
              BlocBuilder<DogsCubit, DogsState>(
                builder: (context, state) {
                  return Row(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.6,
                        height: 60,
                        margin: const EdgeInsets.all(20),
                        child: ElevatedButton(
                            onPressed: (state.status == DogsStatus.loading)
                                ? null
                                : () {
                                    context.read<DogsCubit>().getDog();
                                  },
                            child: const Text(
                              "Gerar Cachorro",
                              style: TextStyle(fontSize: 22),
                            )),
                      ),
                      Container(
                        // width: MediaQuery.of(context).size.width * 0.2,
                        height: 60,
                        margin: const EdgeInsets.all(20),
                        child: ElevatedButton(
                          onPressed: () async {
                            await launchUrl(
                                Uri.parse(state.message.toString()));
                          },
                          child: const Icon(
                            Icons.share,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Conteudo extends StatelessWidget {
  const _Conteudo({super.key});

  @override
  Widget build(BuildContext context) {
    final status = context.select((DogsCubit cubit) => cubit.state.status);

    switch (status) {
      case DogsStatus.initial:
        return const SizedBox();
      case DogsStatus.loading:
        return const Center(
            child: CircularProgressIndicator.adaptive(
          backgroundColor: Colors.blue,
        ));
      case DogsStatus.failure:
        return const Center(child: Text('Falha ao buscar cachorros'));
      case DogsStatus.favoritado:
        return const Center(
            child: Text(
          'Cachorro favoritado!',
          style: TextStyle(
              fontSize: 28, fontWeight: FontWeight.bold, color: Colors.green),
        ));
      case DogsStatus.success:
        final fotos = context.select((DogsCubit cubit) => cubit.state.message);
        return Container(
          child: Image.network(
            fotos.toString(),
            fit: BoxFit.fill,
            scale: 1,
          ),
        );
    }
  }
}
