import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery/features/cart/bloc/cart_bloc.dart';
import 'package:grocery/features/cart/ui/cart_tile_widget.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  void initState() {
    cartBloc.add(CartInitialEvent());
    super.initState();
  }

  final CartBloc cartBloc = CartBloc();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartBloc, CartState>(
      bloc: cartBloc,
      listener: (context, state) {
        if (state is CartRemovedActionState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Item Removed"),
            ),
          );
        }
      },
      listenWhen: (previous, current) => current is CartActionState,
      buildWhen: (previous, current) => current is! CartActionState,
      builder: (context, state) {
        switch (state.runtimeType) {
          case CartSuccessState:
            final successState = state as CartSuccessState;
            return Scaffold(
              appBar: AppBar(
                title: const Center(
                  child: Text("Cart"),
                ),
              ),
              body: ListView.builder(
                itemCount: successState.cartItems.length,
                itemBuilder: (context, index) => CartTileWidget(
                  cartBloc: cartBloc,
                  productDataModel: successState.cartItems[index],
                ),
              ),
              bottomSheet: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                alignment: Alignment.center,
                width: double.infinity,
                height: 50,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "\$${cartBloc.totalPrice.toStringAsPrecision(3).toString()}",
                      style: const TextStyle(
                          fontSize: 35, fontWeight: FontWeight.bold),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {},
                      style: const ButtonStyle(),
                      label: const Text("Check Out"),
                      icon: const Icon(Icons.shopping_cart_checkout),
                    ),
                  ],
                ),
              ),
            );

          default:
        }
        return Container();
      },
    );
  }
}
// Container(
//             padding: const EdgeInsets.symmetric(horizontal: 20),
//             alignment: Alignment.center,
//             width: double.infinity,
//             height: 100,
//             decoration: const BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(10), topRight: Radius.circular(10)),
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   "bloc price",
//                   style: const TextStyle(
//                       fontSize: 35, fontWeight: FontWeight.bold),
//                 ),
//                 ElevatedButton.icon(
//                   onPressed: () {},
//                   style: const ButtonStyle(),
//                   label: const Text("Check Out"),
//                   icon: const Icon(Icons.shopping_cart_checkout),
//                 ),
//               ],
//             ),
//           );