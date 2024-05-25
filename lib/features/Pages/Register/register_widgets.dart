
part of 'register_page.dart';

class _RegisterAppBar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return AppBar(
        toolbarHeight: 30.h,
        leading: const AppBarIcon(),
        flexibleSpace: const AppbarFlexibleSpace(),
        centerTitle: true,
        title: GeneralTextWidget(
            title: "Üye Ol", fontsize: 14.sp, color: Colors.white),);
  }
}

class _RegisterPageColumnItems extends StatelessWidget {
  const _RegisterPageColumnItems(
      {
      required this.number,
      required this.title,
      required this.incoming});
  final String number;
  final String title;
  final String incoming;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        ListTile(
          contentPadding: CustomPadding.allInset(0),
          title: Text(
            title,
            style: TextStyle(fontSize: 17.sp, color: Colors.grey),
          ),
          leading: Container(
            width: 20.w,
            height: 20.h,
            margin: CustomPadding.onlyHorizontalInset(10),
            child: CircleAvatar(
              backgroundColor: Colors.grey,
              child: Text(
                number,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
          trailing: incoming.contains("entry")
              ? null
              : Container(
                  width: 20.w,
                  height: 20.h,
                  margin: CustomPadding.onlyHorizontalInset(10),
                  child: const CircleAvatar(
                    backgroundColor: Colors.green,
                    child: Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 15,
                    ),
                  ),
                ),
        ),
        Divider(
          endIndent: 70.w,
          indent: 70.w,
          height: 2.h,
          color: Colors.black,
        )
      ],
    );
    
  }
}
