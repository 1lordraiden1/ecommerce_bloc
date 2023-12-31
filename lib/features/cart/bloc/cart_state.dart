part of 'cart_bloc.dart';

@immutable
sealed class CartState {}

sealed class CartActionState extends CartState {}

class CartInitial extends CartState {}

class CartSuccessState extends CartState {
  final List<ProductDataModel> cartItems;
  final double totalPrice;

  CartSuccessState(this.cartItems,this.totalPrice);
}

class CartRemovedActionState extends CartActionState {}
