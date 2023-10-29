import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery/features/cart/ui/cart.dart';
import 'package:grocery/features/home/bloc/home_bloc.dart';
import 'package:grocery/features/wishlist/ui/wishlist.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final HomeBloc homeBloc = HomeBloc();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is! HomeActionState,
      listener: (context, state) {
        if (state is HomeNavigateToCartPageActionState) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Cart(),
            ),
          );
        }
        else if (state is HomeNavigateToWishlistPageActionState) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Wishlist(),
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Grocery App"),
            actions: [
              IconButton(
                onPressed: () {
                  homeBloc.add(HomeCartButtonNavigateEvent());
                },
                icon: Icon(Icons.favorite_border_outlined),
              ),
              IconButton(
                onPressed: () {
                  homeBloc.add(HomeWishlistButtonNavigateEvent());
                },
                icon: Icon(Icons.shopping_cart),
              ),
            ],
          ),
        );
      },
    );
  }
}
