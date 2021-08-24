import 'package:flutter/material.dart';

class DisplayColor extends StatefulWidget {
  final Function onSelectedColor;
  final List<Color> availableColors;
  final Color initialColor;
  final bool circleItem;

  DisplayColor(
      {required this.onSelectedColor,
      required this.availableColors,
      required this.initialColor,
      this.circleItem = true});

  @override
  DisplayColorState createState() => DisplayColorState();
}

class DisplayColorState extends State<DisplayColor> {
  late Color _choosedColor;

  void initState() {
    super.initState();
    _choosedColor = widget.initialColor;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: widget.availableColors.length,
            itemBuilder: (context, index) {
              print(index);
              final itemColor = widget.availableColors[index];
              return InkWell(
                  onTap: () {
                    widget.onSelectedColor(itemColor);
                    setState(() {
                      _choosedColor = itemColor;
                      print('SelectedColor:$_choosedColor');
                    });
                  },
                  child: Container(
                      padding: EdgeInsets.all(8.0),
                      width: 50,
                      height: 50,
                      child: Container(
                        decoration: BoxDecoration(
                            color: itemColor,
                            shape: widget.circleItem == true
                                ? BoxShape.circle
                                : BoxShape.rectangle,
                            border: Border.all(width: 1, color: Colors.grey)),
                        child: itemColor == _choosedColor
                            ? Center(
                                child: Icon(
                                  Icons.check,
                                  color: Colors.black54,
                                ),
                              )
                            : Container(),
                      )));
            }));
  }
}
