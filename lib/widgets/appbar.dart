import 'package:groceryshopprices/lib.dart';

PreferredSizeWidget appBarWidget(
    {required BuildContext context,
    required String text,
    Widget? title,
    bool backButton = true,
    bool enforceExit = true,
    VoidCallback? onBackClicked,
    Widget? trailingIcon,
    PreferredSizeWidget? bottom,
    double? elevation,
    Color? color,
    Color? bgColor}) {
  return AppBar(
    centerTitle: false,
    // shape: RoundedRectangleBorder(
    //     borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))),

    elevation: elevation ?? 0,
    leadingWidth: backButton == false ? 10 : null,
    bottom: bottom,
    leading: backButton
        ? IconButton(
            onPressed: () {
              if (onBackClicked != null) {
                onBackClicked();
              }
              exitOrAttemptExit(context, enforceExit: enforceExit);
            },
            icon:
                //  BackImgButton()
                Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: DesignColor.darkGrey,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.arrow_back,
                color: color ?? Colors.white,
              ),
            ))
        : SizedBox(),
    title: title ??
        Text(
          text,
          maxLines: 2,
          style: TextStyle(
              fontSize: w * 0.05,
              color: color ?? DesignColor.black,
              fontWeight: FontWeight.w600),
        ),
    backgroundColor: DesignColor.transparent,
    // bgColor ?? DesignColor.appbarBg,
    actions: [
      if (trailingIcon != null) trailingIcon,
    ],
  );
}
