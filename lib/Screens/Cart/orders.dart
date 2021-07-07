import 'package:flutter/material.dart';
import 'package:skyLenses/Screens/Cart/widgets/ordersCard.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'Blocs/cartBloc.dart';

class OrderScreen extends StatefulWidget {
  OrderScreen({Key key}) : super(key: key);

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  void initState() {
    super.initState();
    bloc.cartEventsController.sink.add(DisplayOrders());
  }

  final bloc = CartBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF0F0F0),
      body: SingleChildScrollView(
        child: StreamBuilder(
            initialData: [{}],
            stream: bloc.ordersController.stream.asBroadcastStream(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.black,
                      strokeWidth: 2,
                    ),
                  ),
                );
              } else {
                if (snapshot.data.length != 0) {
                  return Column(
                    children: List.generate(snapshot.data.length, (index) {
                      return Column(
                        children: [
                          OrderCard(orderDetails: snapshot.data[index]),
                          SizedBox(),
                        ],
                      );
                    }),
                  );
                } else {
                  return Container(
                    height: 0.5.hp,
                    child: Center(
                      child: Text(
                        'Place your first order...',
                        style: TextStyle(
                            fontSize: 45.sp, fontWeight: FontWeight.w500),
                      ),
                    ),
                  );
                }
              }
            }),
      ),
    );
  }
}
