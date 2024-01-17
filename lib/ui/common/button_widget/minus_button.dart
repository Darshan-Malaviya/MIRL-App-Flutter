import 'package:mirl/infrastructure/commons/exports/common_exports.dart';

class MinusButtonWidget extends StatelessWidget {
  final VoidCallback onTap;

  const MinusButtonWidget({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 20,
          width: 20,
          child: const Icon(
            Icons.remove,
            size: 18,
          ),
          decoration: ShapeDecoration(
            color: ColorConstants.yellowButtonColor,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
            shadows: [
              BoxShadow(
                color: Color(0x3F000000),
                blurRadius: 2,
                offset: Offset(0, 2),
                spreadRadius: 0,
              )
            ],
          ),
          // decoration: BoxDecoration(
          //   color: ColorConstants.yellowButtonColor,
          //   borderRadius: BorderRadius.all(Radius.circular(4)),
          //   boxShadow: [
          //     BoxShadow(
          //       color: ColorConstants.borderColor,
          //       //spreadRadius: 2,
          //       blurRadius: 2,
          //       offset: Offset(0, 1),
          //     ),
          //   ],
          // ),
        ),
      ),
    );
  }
}

// children: <Widget>[
// _itemCount!=0? new  IconButton(icon: new Icon(Icons.remove),onPressed: ()=>setState(()=>_itemCount--),):new Container(),
// new Text(_itemCount.toString()),
// new IconButton(icon: new Icon(Icons.add),onPressed: ()=>setState(()=>_itemCount++))
// ],
