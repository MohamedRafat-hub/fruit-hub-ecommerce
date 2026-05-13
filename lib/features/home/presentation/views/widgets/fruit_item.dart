import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fruit_hub/core/entities/product_entity.dart';
import 'package:fruit_hub/features/home/presentation/managers/cartCubit/cart_cubit.dart';
import 'package:fruit_hub/features/home/presentation/managers/favouriteCubit/favourite_cubit.dart';
import 'package:gap/gap.dart';

class FruitItem extends StatefulWidget {
  const FruitItem({super.key, required this.productEntity});

  final ProductEntity productEntity;

  @override
  State<FruitItem> createState() => _FruitItemState();
}

class _FruitItemState extends State<FruitItem> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
        color: const Color(0xFFF3F5F7),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 7),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
                onTap: () {
                  setState(() {
                    isSelected = !isSelected;
                  });
                  if(isSelected == true)
                    {
                      context.read<FavouriteCubit>().addToFavourite(widget.productEntity.code);
                    }
                  else
                    {
                      context.read<FavouriteCubit>().removeFromFavourite(widget.productEntity.code);
                    }
                },
                child: isSelected
                    ? Icon(CupertinoIcons.heart_fill , color: Colors.red,)
                    : Icon(CupertinoIcons.heart)),
            Flexible(
              flex: 1,
              child: Center(
                child: CachedNetworkImage(
                  imageUrl: '${widget.productEntity.imageUrl}',
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
            Gap(10),
            Text(
              widget.productEntity.name,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
            ),
            Row(
              children: [
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: '${widget.productEntity.price}',
                        style: TextStyle(
                          color: const Color(0xFFF4A91F) /* Orange-500 */,
                          fontSize: 13,
                          fontFamily: 'Cairo',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      TextSpan(
                        text: '/',
                        style: TextStyle(
                          color: const Color(0xFFF8C76D) /* Orange-300 */,
                          fontSize: 13,
                          fontFamily: 'Cairo',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      TextSpan(
                        text: ' ',
                        style: TextStyle(
                          color: const Color(0xFFF4A91F) /* Orange-500 */,
                          fontSize: 13,
                          fontFamily: 'Cairo',
                          fontWeight: FontWeight.w600,
                          height: 1.70,
                        ),
                      ),
                      TextSpan(
                        text: 'الكيلو',
                        style: TextStyle(
                          color: const Color(0xFFF8C76D) /* Orange-300 */,
                          fontSize: 13,
                          fontFamily: 'Cairo',
                          fontWeight: FontWeight.w600,
                          height: 1.70,
                        ),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.right,
                ),
                Spacer(),
                GestureDetector(
                    onTap: () {
                      context
                          .read<CartCubit>()
                          .addProductToCart(widget.productEntity);
                    },
                    child: SvgPicture.asset('assets/icons/add_icon.svg')),
              ],
            )
          ],
        ),
      ),
    );
  }
}
