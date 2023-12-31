import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery/features/cart/ui/cart.dart';
import 'package:grocery/features/home/bloc/home_bloc.dart';
import 'package:grocery/features/home/ui/product_tile_widget.dart';
import 'package:grocery/features/wishlist/ui/wishlist.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final HomeBloc homeBloc = HomeBloc();

  @override
  void initState() {
    homeBloc.add(HomeInitEvent());
    super.initState();
  }

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
              builder: (context) => const Wishlist(),
            ),
          );
        } else if (state is HomeNavigateToWishlistPageActionState) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const Cart(),
            ),
          );
        } else if (state is HomeProductItemCartedActionState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Item Carted"),
            ),
          );
        } else if (state is HomeProductItemWishlistedActionState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Item Wishlisted"),
            ),
          );
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case HomeLoadingState: //Loading Screen
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          case HomeLoadedSuccessState: //Loaded Successfully
            final successState = state as HomeLoadedSuccessState;
            return Scaffold(
              appBar: AppBar(
                title: const Text("Grocery App"),
                actions: [
                  IconButton(
                    onPressed: () {
                      homeBloc.add(HomeCartButtonNavigateEvent());
                    },
                    icon: const Icon(Icons.favorite_border_outlined),
                  ),
                  IconButton(
                    onPressed: () {
                      homeBloc.add(HomeWishlistButtonNavigateEvent());
                    },
                    icon: const Icon(Icons.shopping_cart),
                  ),
                ],
              ),
              body: ListView.builder(
                  itemCount: successState.products.length,
                  itemBuilder: (context, index) => ProductTileWidget(
                      homeBloc: homeBloc,
                      productDataModel: successState.products[index])),
            );
          case HomeErrorState:
            return const Scaffold(
              body: Center(child: Text("Error in Loading Products")),
            );
          default:
            return const SizedBox();
        }
      },
    );
  }
}


// return Scaffold(
//           appBar: AppBar(
//             title: const Text("Grocery App"),
//             actions: [
//               IconButton(
//                 onPressed: () {
//                   homeBloc.add(HomeCartButtonNavigateEvent());
//                 },
//                 icon: Icon(Icons.favorite_border_outlined),
//               ),
//               IconButton(
//                 onPressed: () {
//                   homeBloc.add(HomeWishlistButtonNavigateEvent());
//                 },
//                 icon: Icon(Icons.shopping_cart),
//               ),
//             ],
//           ),
//         );