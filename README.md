# flutter_bloc_architecture

Flutter example app using BLoC state management, go_router + navigator


Simplenya karena flutter itu untuk frontend maka code terbagi jadi 2 yaitu code UI dan code Logic (code UI kegunaanya untuk membentuk visual aplikasi, code Logic digunakan untuk menambahkan fungsionalitas seperti handle user input, menampung data variable , melakukan kalkulasi atau perhitungan, melakukan API request, dan juga bisa untuk menambah UI menjadi interaktif seperti animasi dll ), biasanya setiap halaman di aplikasi flutter terdiri dari code UI dan Logic. beberapa code UI akan saling berkaitan dengan satu atau lebih code logic pada halaman tersebut.
( kita bisa ambil contoh code UI untuk list katalog produk, element ui ini pasti berkaitan dengan code logic variable untuk menampung data list product, dan juga bisa berkaitan dengan code logic untuk refresh product, proses refresh product terdiri dari melakukan API request, ketika berhasil maka replace data variable dengan yang baru jika salah maka tampilkan error gagal melakukan refresh )

ketika aplikasi semakin berkembang maka code juga akan semakin kompleks, code UI dan Logic yang sudah kompleks akan sangat sulit dibaca apabila menumpuk dalam 1 file, karena itu proses pengembangan aplikasi jadi sedikit lebih sulit. solusi simple untuk masalah ini kita bisa memisahkan code UI beseerta logic yang berkaitan kedalam file khusus untuk element UI pada halaman tersebut ( contohnya memisahkan code UI dan code Logic untuk element list katalog produk dari file "home_page.dart" ke file "catalog_product_list.dart" ), maka kode akan jadi lebih mudah untuk dibaca, namun seperti yang sudah dijelaskan terkadang "beberapa code UI berkaitan dengan code Logic", yang mana code logic tersebut berkemungkinan juga berkaitan dengan code logic lainnya yang berkaitan dengan code UI lain. dengan begitu akan sulit untuk memisahkan code logic tersebut. ( yang jadi  permasalhan adalah memisahkan code logic tersebut ke halaman lain )

sekalipun bisa dipindahkan pastinya kita akan melakukan passing data dari code logic tersebut ke dalam halaman UI yang sudah kita pisah.  maka dari itu kode yang kita pisahkan dengan maksud untuk kode jadi semakin mudah untuk dibaca dan dimaintain, malah jadi semakin rumit dan sulit untuk dibaca.

TL;DR;
semakin aplikasi berkembang code jadi semakin kompleks, semakin kita membuat code yang kompleks menjadi simple, code malah jadi semakin rumit.

untuk mengatasi hal tersebut maka kita bisa gunakan metode state management, metode ini beguna untuk memisahkan Logic dari UI, singkatnya dengan metode ini kita bisa pisahkan logic kedalam class terpisah, sehingga kita bisa memanggil kapanpun logic tsb di code UI kita ( dan juga kita bisa saling berbagi code logic ke halaman yang berbeda ). dengan begitu kita bisa memecah beberapa code element UI kedalam file khusus tertentu dan ketika UI tersebut memerlukan code logic maka kita hanya perlu memanggil Logic tersebut tanpa perlu khawatir untuk passing data.

kesimpulannya dengan menggunakan metode state management kita bisa memisahkan logic dari UI dengan begitu kita dapat memecah kode yang kompleks menjadi kode yang lebih kecil sehingga code jadi lebih mudah untuk dibaca dan juga untuk dimaintain.
