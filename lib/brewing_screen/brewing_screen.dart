import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/brewing_bloc.dart';

class BrewingScreen extends StatelessWidget {
  const BrewingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Brewing Page'),
      ),
      body: Center(
        child: Column(children: [
          BlocBuilder<BrewingBloc, BrewingState>(builder: (context, state) {
            if (state is BrewingInitial) {
              return const Text('Press the button to get brewing!');
              //return const CircularProgressIndicator();
            } else if (state is BrewingLoaded) {
              return Image.network(state.imageUrl);
            } else if (state is BrewingError) {
              return Text('Error:; ${state.errorMessage}');
            }
            return Container();
          }),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        child: Text('Brew Me Some Coffee'),
        onPressed: () => {
          //brewingBloc.add(FetchImage())
          BlocProvider.of<BrewingBloc>(context).add(LoadButtonPressed())
          // context.read<BrewingBloc>().add(LoadButtonPressed())
        },
      ),
    );
  }
}
