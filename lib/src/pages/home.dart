import 'package:auau_gerador/src/cubit/dogs_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
        body: Center(
          child: Column(
            children: [
              const Expanded(flex: 3, child: _Conteudo()),
              BlocBuilder<DogsCubit, DogsState>(
                builder: (context, state) {
                  return Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    height: 60,
                    margin: const EdgeInsets.all(20),
                    child: ElevatedButton(
                        onPressed: (state.status == DogsStatus.loading)
                            ? null
                            : () {
                                context.read<DogsCubit>().getDog();
                              },
                        child: const Text("Gerar Cachorro")),
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
          backgroundColor: Colors.amber,
        ));
      case DogsStatus.failure:
        return const Center(child: Text('Falha ao buscar cachorros'));
      case DogsStatus.success:
        final fotos = context.select((DogsCubit cubit) => cubit.state.message);
        return Container(
          child: Image.network(
            fotos.toString(),
            fit: BoxFit.fill,
          ),
        );
    }
  }
}
