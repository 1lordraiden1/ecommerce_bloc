import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery/features/cart/bloc/cart_bloc.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text("Cart"),
        ),
      ),
      body: BlocConsumer<CartBloc, CartState>(
        listener: (context, state) {},
        listenWhen: (previous, current) => current is CartActionState,
        buildWhen: (previous, current) => current is! CartActionState,
        builder: (context, state) {
          switch (state.runtimeType) {
            case fgh:
              
              break;
            default:
          }
          return Container();
        },
      ),
    );
  }
}
