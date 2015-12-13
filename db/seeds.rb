# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Book.create(
  title: 'Sherlock Holmes A Collectors Edition',
  author: 'Sir Arthur Conan Doyle',
  summary: 'Buku ini merupakan kumpulan dari 4 buku petualangan terbaik Sherlock Holmes, berisi 48 kisah misterius yang akan memuaskan para Sherlockian',
  image: 'https://images-na.ssl-images-amazon.com/images/I/51HWaRzG42L._SS100_.jpg'
  price: 169_150,
  quantity: 50
)

Book.create(
  title: 'Bumi Manusia',
  author: 'Pramoedya Ananta Toer',
  summary: 'mengambil latar belakang Indonesia di awal abad ke-20. Dengan membacanya kita dibalikkan hidup di era membibitnya pergerakan nasional mula-mula, percintaan, dan pertarungan kekuatan anonim para srikandi yang mengawal penyemaian bangunan nasional',
  image: 'http://wpc.21684.lambdacdn.net/8021684/cdn/media/catalog/product/cache/1/image/9df78eab33525d08d6e5fb8d27136e95/b/u/bumi-manusia_1.jpg',
  price: 112_200,
  quantity: 50
)

Book.create(
  title: 'Robin Hood',
  author: 'David B.coe',
  summary: 'ROBIN HOOD mengisahkan kehidupan seorang ahli memanah. yang hanya memikirkan dirinya sendiri. Akan tetapi, akhirnya ia dan teman-temannya merasa terpanggil untuk melakukan petualangan yang lebih besar.',
  image: 'http://ecx.images-amazon.com/images/I/516YD90ZZ2L.jpg',
  price: 112_200,
  quantity: 50
)
