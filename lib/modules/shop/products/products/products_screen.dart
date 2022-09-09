import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:udemy_flutter/models/add_favorites.dart';
import 'package:udemy_flutter/models/categories_model.dart';
import 'package:udemy_flutter/models/home_model.dart';

import '../../../../shared/components/components.dart';
import '../../../../shared/cubit/cubit.dart';
import '../../../../shared/cubit/states.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, Shopstates>(
      listener: (context, state) {

        if (state is ShopSuccessfavoritesState) {
          if (state.model.status == true) {
            Fluttertoast.showToast(
                msg: state.model.message,
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.SNACKBAR,
                timeInSecForIosWeb: 3,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0);
          }
        }
        if (state is ShopSuccessfavoritesState) {
          if (state.model.status == false) {
            Fluttertoast.showToast(
                msg: state.model.message,
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.SNACKBAR,
                timeInSecForIosWeb: 3,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          }
        }
      },
      builder: (context, state) {
        return ConditionalBuilder(
            condition: ShopCubit.get(context).homeModel != null &&
                ShopCubit.get(context).CategorsModel != null,
            builder: (context) {
              return ProductBulider(ShopCubit.get(context).homeModel,
                  ShopCubit.get(context).CategorsModel, context);
            },
            fallback: (context) {
              return Center(
                child: CircularProgressIndicator(),
              );
            });
      },
    );
  }

  Widget ProductBulider(
      HomeModel model, CategoriesModel categoriesModel, context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CarouselSlider(
              items: model.data.banners.map((banner) {
                return Container(
                  child: Image.network(banner.image),
                );
              }).toList(),
              options: CarouselOptions(
                height: 200,
                autoPlay: true,
                initialPage: 0,
                aspectRatio: 2.0,
                viewportFraction: 1.0,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                scrollDirection: Axis.horizontal,
                reverse: false,

                // aspectRatio: 2.0,
              ),
            ),
            SizedBox(
              height: 18,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Categroies',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  Container(
                    height: 100,
                    child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return electronics(categoriesModel.data.data[index]);
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            width: 5,
                          );
                        },
                        itemCount: categoriesModel.data.data.length),
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  Text(
                    'New Products',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.white,
              child: GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                childAspectRatio: 1 / 1.7,
                mainAxisSpacing: 1.0,
                crossAxisSpacing: 2.0,
                padding: const EdgeInsets.all(10.0),
                children: model.data.products.map((product) {
                  return Column(
                    children: [
                      Stack(
                        alignment: AlignmentDirectional.bottomStart,
                        children: [
                          Image(
                            image: NetworkImage(product.image),
                            width: double.infinity,
                            height: 200,
                          ),
                          if (product.discount != 0)
                            Container(
                              color: Colors.red,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  'DISCOUNT',
                                  style: TextStyle(
                                      fontSize: 10, color: Colors.white),
                                ),
                              ),
                            )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.name,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 13,
                                height: 1.1,
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  '${product.price.round()}',
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.blue),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                if (product.discount != 0)
                                  Text(
                                    '${product.oldPrice}',
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.grey,
                                        decoration: TextDecoration.lineThrough),
                                  ),
                                Spacer(),
                                IconButton(
                                  onPressed: () {
                                    ShopCubit.get(context)
                                        .changefavorites(product.id);

                                    // Fluttertoast.showToast(
                                    //     msg:  FavModel.,
                                    //     toastLength: Toast.LENGTH_LONG,
                                    //     gravity: ToastGravity.SNACKBAR,
                                    //     timeInSecForIosWeb: 3,
                                    //     backgroundColor: Colors.green,
                                    //     textColor: Colors.white,
                                    //     fontSize: 16.0);
                                  },
                                  icon: CircleAvatar(
                                    radius: 15,
                                    backgroundColor: ShopCubit.get(context)
                                            .favariot[product.id]
                                        ? Colors.red
                                        : Colors.grey,
                                    child: Icon(
                                      Icons.favorite,
                                      size: 14,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget electronics(DataModel data) =>
      Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Image(
            image: NetworkImage(data.image),
            height: 100,
            width: 100,
            fit: BoxFit.cover,
          ),
          Container(
            color: Colors.black.withOpacity(0.8),
            width: 100,
            child: Text(
              data.name,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      );
}
