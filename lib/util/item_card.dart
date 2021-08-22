import 'package:flutter/material.dart';

class ItemCard extends StatelessWidget {
  final String? title;
  final Color? color;
  final VoidCallback? onPress;

  const ItemCard({
    Key? key,
    this.title,
    this.color,
    this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(13),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.deepPurple[100],
              borderRadius: BorderRadius.circular(13),
              boxShadow: [
                BoxShadow(
                  blurRadius: 100,
                  color: Colors.black,
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                highlightColor: Colors.transparent,
                splashColor: Colors.deepPurple.withOpacity(0.5),
                onTap: onPress,
                child: Padding(
                  padding: const EdgeInsets.all(50),
                  child: Text(
                    title!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ItemCard2 extends StatelessWidget {
  final String? title;
  final VoidCallback? onTap;
  const ItemCard2({Key? key, this.title, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.deepPurple[100]!),
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [BoxShadow(blurRadius: 10, color: Colors.grey[300]!)]),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap!,
            child: ListTile(
              title: Text(
                title!,
                maxLines: 1,
                textDirection: TextDirection.rtl,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ItemCard3 extends StatelessWidget {
  final String? user;
  final String? code;
  final String? expire;
  final String? time;
  final VoidCallback? onPress;
  final VoidCallback? onDeletePress;
  final Color? codeColor;

  const ItemCard3(
      {Key? key,
      this.onPress,
      this.user,
      this.code,
      this.expire,
      this.time,
      @required this.codeColor,
      this.onDeletePress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(13),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.deepPurple[100],
              borderRadius: BorderRadius.circular(13),
              boxShadow: [
                BoxShadow(
                  blurRadius: 100,
                  color: Colors.black,
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                highlightColor: Colors.transparent,
                splashColor: Colors.deepPurple.withOpacity(0.5),
                onTap: onPress,
                child: Padding(
                  padding: const EdgeInsets.only(top: 5, bottom: 15),
                  child: Column(
                    children: [
                      IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Colors.grey[700],
                            size: 30,
                          ),
                          onPressed: onDeletePress),
                      Text(
                        user!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      Divider(),
                      Text(
                        code!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      Divider(),
                      Text(
                        expire!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 18,
                            color: codeColor ?? Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      Divider(),
                      Text(
                        time!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
