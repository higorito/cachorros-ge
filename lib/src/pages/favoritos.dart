import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auau_gerador/src/cubit/dogs_cubit.dart';
import 'package:url_launcher/url_launcher.dart';

class FavoritosPage extends StatelessWidget {
  const FavoritosPage({super.key});

  @override
  Widget build(BuildContext context) {
    final dogsCubit = BlocProvider.of<DogsCubit>(context)..getFavoritos();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favoritos'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Chame a função getFavoritos aqui
                      dogsCubit.getFavoritos();
                    },
                    child: const Text('Buscar Favoritos'),
                  ),
                  Container(
                    // width: MediaQuery.of(context).size.width * 0.2,
                    height: 60,
                    margin: const EdgeInsets.all(20),
                    child: ElevatedButton(
                      onPressed: () async {
                        await launchUrl(
                            Uri.parse(dogsCubit.state.message.toString()));
                      },
                      child: const Icon(
                        Icons.share,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              flex: 8,
              child: BlocBuilder<DogsCubit, DogsState>(
                builder: (context, state) {
                  if (state.status == DogsStatus.loading) {
                    return const Dialog(
                      child: SizedBox(
                        height: 100,
                        width: 100,
                        child: Center(
                          child: CircularProgressIndicator.adaptive(),
                        ),
                      ),
                    );
                  } else if (state.status == DogsStatus.success) {
                    final fotoFavorita = state.message.toString();
                    return Image.network(
                      fotoFavorita,
                      fit: BoxFit.fill,
                      scale: 1,
                    );
                  } else if (state.status == DogsStatus.failure) {
                    return const Text('Falha ao buscar favoritos');
                  } else {
                    return const Text('Nenhum favorito encontrado');
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
