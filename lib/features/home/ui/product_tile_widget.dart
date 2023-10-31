import 'package:flutter/material.dart';
import 'package:grocery/features/home/bloc/home_bloc.dart';
import 'package:grocery/models/home_product_data_model.dart';

class ProductTileWidget extends StatelessWidget {
  final ProductDataModel productDataModel;
  final HomeBloc homeBloc;
  ProductTileWidget(
      {super.key, required this.productDataModel, required this.homeBloc});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200,
            width: double.maxFinite,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(productDataModel.imageUrl))),
          ),
          const SizedBox(
            height: 10.0,
          ),
          Text(
            productDataModel.name,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          Text(
            productDataModel.des,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(
            height: 10.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '\$${productDataModel.price}',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      homeBloc.add(HomeProductWishlistButtonClickedEvent(productDataModel));
                    },
                    icon: Icon(
                      Icons.favorite_border_outlined,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      homeBloc.add(HomeProductCartButtonClickedEvent(productDataModel));
                    },
                    icon: Icon(
                      Icons.shopping_bag_outlined,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
