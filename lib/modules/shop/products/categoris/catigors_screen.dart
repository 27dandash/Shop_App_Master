import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter/models/categories_model.dart';
import 'package:udemy_flutter/shared/components/components.dart';
import 'package:udemy_flutter/shared/cubit/cubit.dart';

import '../../../../shared/cubit/states.dart';

class Categors_Screen extends StatelessWidget {
  const Categors_Screen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, Shopstates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ListView.separated(
            itemBuilder: (context, index) => buildCatiegiresItem(
                ShopCubit.get(context).CategorsModel.data.data[index]),
            separatorBuilder: (context, index) => myDivider(),
            itemCount: ShopCubit.get(context).CategorsModel.data.data.length);
      },
    );
  }

  Widget buildCatiegiresItem(DataModel data) => Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Image(
              image: NetworkImage(data.image),
              height: 80,
              width: 80,
              fit: BoxFit.cover,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              data.name,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Spacer(),
            Icon(Icons.arrow_forward_ios)
          ],
        ),
      );
}
