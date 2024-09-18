import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomDiceFace extends StatelessWidget {
  CustomDiceFace(
      {super.key,
      required this.widthAndHeight,
      this.transform,
      this.alignment,
      required this.number});
  Matrix4? transform;
  int number;
  Alignment? alignment;
  final double widthAndHeight;

  @override
  Widget build(BuildContext context) {
    String url = "";

    switch (number) {
      case 1:
        url += "https://scontent.fsgn19-1.fna.fbcdn.net/v/t1.15752-9/459182922_585503570469002_1568941098303412007_n.png?_nc_cat=100&ccb=1-7&_nc_sid=9f807c&_nc_eui2=AeHKE_VnDXmri0wBbwO_oPUqWleWL2cv1UhaV5YvZy_VSDmCTXAdKpSw2nEzaKakHyUw1PQsU_T-tMgKl-gCnDKx&_nc_ohc=5EehGm8_IAgQ7kNvgFicNyH&_nc_ht=scontent.fsgn19-1.fna&_nc_gid=A9JQzWWzY930VLqbnGbkGOf&oh=03_Q7cD1QE4HWfWuXHXJdzf9DXVDXeJAZLjQGURw0vN54OhgDQgwg&oe=67120ACF";
        break;
      case 2:
        url += "https://scontent.xx.fbcdn.net/v/t1.15752-9/459251379_489518600557795_143072884890981896_n.png?_nc_cat=110&ccb=1-7&_nc_sid=0024fc&_nc_eui2=AeFxXX8u4AYcIMM1xwC2QKmTSP_UxeFUvdBI_9TF4VS90NfUjW0ibeNDQ5FG8POm-9-_NVJnyZGF9fE4Ig-1iidY&_nc_ohc=emGBhYtcEeAQ7kNvgEWFV3-&_nc_ad=z-m&_nc_cid=0&_nc_ht=scontent.xx&_nc_gid=AFQPxYuQVtj-jbubhBF5Xb4&oh=03_Q7cD1QFcqfMuSEjSTrqGCBDhKWqcC8_JdNobBO1cLjra0eqJ3g&oe=6711F765";
        break;
      case 3:
        url += "https://scontent.xx.fbcdn.net/v/t1.15752-9/458773052_1211439429984303_5754649544639617371_n.png?_nc_cat=103&ccb=1-7&_nc_sid=0024fc&_nc_eui2=AeEkl3URBpVlG7VKe-MeOITE_IFeG_0xlR_8gV4b_TGVHy0C2mEyUqZmNSK_6ZLBNKg8fWNODv3JyHChlfh9BZfk&_nc_ohc=6GbjLtjLMgsQ7kNvgHBl3NO&_nc_ad=z-m&_nc_cid=0&_nc_ht=scontent.xx&_nc_gid=AFQPxYuQVtj-jbubhBF5Xb4&oh=03_Q7cD1QGwPJ5cqJXaq2kkmzAhc5RY7z5uiSxYteqeZbEYJmhSfQ&oe=67121862";
        break;
      case 4:
        url += "https://scontent.xx.fbcdn.net/v/t1.15752-9/458720770_1052503942950905_9154611876704126876_n.png?_nc_cat=101&ccb=1-7&_nc_sid=0024fc&_nc_eui2=AeFGcazOFi4Aj6elB_wnIU_Qf7aOMAnGZYl_to4wCcZliefCjNe7wmpbzCja7TQbCucPaE2nyqOJoDlFsKpPA5Ho&_nc_ohc=FzTHFjvUGkEQ7kNvgEWv9Cb&_nc_ad=z-m&_nc_cid=0&_nc_ht=scontent.xx&_nc_gid=AFQPxYuQVtj-jbubhBF5Xb4&oh=03_Q7cD1QFDfmVApO9Vd3JpS7dF_HwkOsiHjDVzJblw7EbkF1nAFQ&oe=6711FCC5";
        break;
      case 5:
        url += "https://scontent.xx.fbcdn.net/v/t1.15752-9/459236769_556535163604970_1113617706066173765_n.png?_nc_cat=101&ccb=1-7&_nc_sid=0024fc&_nc_eui2=AeF7-zwKyu6I2LxecG66bUqcjvTbq-HvOTSO9Nur4e85NJoqVNume5sk944gGLSutZ7jewjVp4BDRPq1fCD3uVAU&_nc_ohc=wQLhvUhRwIQQ7kNvgG4L4IB&_nc_ad=z-m&_nc_cid=0&_nc_ht=scontent.xx&_nc_gid=AFQPxYuQVtj-jbubhBF5Xb4&oh=03_Q7cD1QGnWZSDqpfy9HVnFuZZnbxgyg6_0HS7k4Nqw_cloU5SiQ&oe=67120D6B";
        break;
      case 6:
        url += "https://scontent.xx.fbcdn.net/v/t1.15752-9/458753606_507836735210198_5500733764522750099_n.png?_nc_cat=107&ccb=1-7&_nc_sid=0024fc&_nc_eui2=AeGC01PVoJpDtCKp2c7YdoQKVdFVZ7TaQtJV0VVntNpC0l4mStrFjtf6_QGZrd-hwDIwwEmVPzS_ZOZaU5LcfqB_&_nc_ohc=Zb89aW9cmaIQ7kNvgH2tcNF&_nc_ad=z-m&_nc_cid=0&_nc_ht=scontent.xx&_nc_gid=AFQPxYuQVtj-jbubhBF5Xb4&oh=03_Q7cD1QHYXLQEYI_3_U-oWvgNz9OhIKper9jvWsnHhODPrKziyg&oe=6711EEE4";
        break;
    }
    return transform != null
        ? Transform(
            alignment: alignment,
            transform: transform!,
            child: CubeCustom(
                widthAndHeight: widthAndHeight, url: url),
          )
        : CubeCustom(widthAndHeight: widthAndHeight, url: url);
  }
}

class CubeCustom extends StatelessWidget {
  const CubeCustom({
    super.key,
    required this.widthAndHeight,
    required this.url,
  });

  final double widthAndHeight;
  final String url;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.black, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            offset: Offset(10, 10),
            blurRadius: 10,
            spreadRadius: 1,
          ),
          BoxShadow(
            color: Colors.white.withOpacity(0.7),
            offset: Offset(-10, -10),
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ],
        // Hiệu ứng nâng khối 3D
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.grey.shade300,
            Colors.grey.shade100,
          ],
        ),
      ),
      width: widthAndHeight,
      height: widthAndHeight,
      child: Container(
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey.shade100,
            image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(url))),
      ),
    );
  }
}
