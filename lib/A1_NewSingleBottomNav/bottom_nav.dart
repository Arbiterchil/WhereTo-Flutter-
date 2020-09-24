import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {

  final int selectedIndex;
  final double iconSize;
  final Color backColor;
  final bool showElavation;
  final Duration animateDuration;
  final List<BottomBarItems> items;
  final ValueChanged<int> onItemSelected;
  final MainAxisAlignment mainAxisAlign;
  final double itemCorner;
  final double containHieght;
  final Curve curve;

   BottomNavBar({
    Key key, 
    this.selectedIndex = 0, 
    this.iconSize = 24, 
    this.backColor, 
    this.showElavation = true, 
    this.animateDuration = const Duration(milliseconds: 260), 
    @required this.items, 
    @required this.onItemSelected, 
    this.mainAxisAlign = MainAxisAlignment.spaceEvenly, 
    this.itemCorner, 
    this.containHieght, 
    this.curve = Curves.linear
    }){
      assert(items !=null);
      assert(items.length >= 2 && items.length <= 5);
      assert(onItemSelected != null);
      assert(curve !=null);
    }

  @override
  Widget build(BuildContext context) {
    final bgColor = (backColor == null) 
    ? Theme.of(context).bottomAppBarColor 
    : backColor;

    return Container(
        decoration: BoxDecoration(
          color: bgColor,
          boxShadow: [
            if(showElavation)
            const BoxShadow(
              color: Colors.black12,
              blurRadius: 2
            )
          ]
        ),
        child: SafeArea(
          child: Container(
            width: double.infinity,
            height: containHieght,
            padding: const EdgeInsets.symmetric(vertical: 6,horizontal: 8),
            child: Row(
              mainAxisAlignment: mainAxisAlign,
              children: items.map((iteme) {
                var indexing = items.indexOf(iteme);
                return GestureDetector(
                  onTap: ()=> onItemSelected(indexing),
                  child: ItemWidgetSNeed(
                    items: iteme,
                    iconSize: iconSize,
                    isSelected: indexing == selectedIndex,
                    backColors: backColor,
                    itemCorners: itemCorner,
                    animateDuration: animateDuration,
                    curve: curve,
                  ),
                );
              }).toList(),
            ),
          ),
          ),
    );
  }
}

class ItemWidgetSNeed extends StatelessWidget {

  final double iconSize;
  final bool isSelected;
  final BottomBarItems items;
  final Color backColors;
  final double itemCorners;
  final Duration animateDuration;
  final Curve curve;

  const ItemWidgetSNeed({Key key, 
  this.iconSize, 
  this.isSelected, 
  this.items, 
  this.backColors, 
  this.itemCorners, 
  this.animateDuration, 
  this.curve}) : 
  assert(isSelected !=null),
  assert(items !=null),
  assert(backColors !=null),
  assert(animateDuration !=null),
  assert(itemCorners !=null),
  assert(iconSize !=null),
  assert(curve !=null),
  super(key: key);


  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: true,
      selected: isSelected,
      child: AnimatedContainer(
        width: isSelected ? 130 : 60,
        height: double.maxFinite,
        duration: animateDuration,
        curve: curve,
        decoration: BoxDecoration(
          color: isSelected?items.activeColor.withOpacity(0.2) : backColors,
          borderRadius: BorderRadius.circular(itemCorners)
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: NeverScrollableScrollPhysics(),
          child: Container(
            width: isSelected ? 130 : 60,
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconTheme(
                  data: IconThemeData(
                    size: iconSize,
                    color: isSelected 
                    ? items.activeColor.withOpacity(1)
                    : items.inActiveColor == null
                    ? items.activeColor
                    : items.inActiveColor
                  ), 
                  child: items.icon),
                  if(isSelected)
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 4),
                      child: DefaultTextStyle(
                       style: TextStyle(
                         color: items.activeColor,
                         fontWeight: FontWeight.normal,
                         fontFamily: 'Gilroy-light'
                       ),
                       maxLines: 1,
                       textAlign: items.textAlign,
                       child: items.title),
                    ),
                    )
              ],
            ),
          ),
        ),
        ),
    );
  }
}

class BottomBarItems{

  final Widget icon;
  final Widget title;
  final Color activeColor;
  final Color inActiveColor;
  final TextAlign textAlign;

  BottomBarItems({
   @required this.icon,
   @required  this.title, 
    this.activeColor, 
    this.inActiveColor, 
    this.textAlign}) {
     assert(icon !=null); 
    assert( title !=null);
    }


}