# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Image.destroy_all
Bulleting.destroy_all
ItemDetail.destroy_all
Item.destroy_all
User.destroy_all

s1 = User.create name: 'seller_1', email: 's1@ohction,com', password_digest: '123'
s2 = User.create name: 'seller_2', email: 's2@ohction,com', password_digest: '123'

im1= Image.create path: 'item1_1.jpg'
im2= Image.create path: 'item1_2.jpg'
im3= Image.create path: 'item1_3.jpg'
im4= Image.create path: 'item1_4.jpg'

b1 = Bulleting.create bulleting: "Display: 14.0-inch diagonal HD SVA anti-glare micro-edge WLED-backlit display (1366 x 768); 82% screen to body ratio"
b2 = Bulleting.create bulleting: "Memory & storage: 4 GB LPDDR4-2400 SDRAM (not upgradable) and 32 GB eMMC"
b3 = Bulleting.create bulleting: "Google play store: The millions of Android apps you know and love on your phone and tablet can now run on your"
b4 = Bulleting.create bulleting: "Sleek, responsive design: Keep going comfortably with the backlit keyboard"


i1 = Item.create title: 'item_1_titl', seller_id: s1.id
i2 = Item.create title: 'item_2_titl', seller_id: s1.id
i3 = Item.create title: 'item_3_titl', seller_id: s1.id
i4 = Item.create title: 'item_4_titl', seller_id: s1.id
i5 = Item.create title: 'item_5_titl', seller_id: s1.id
i6 = Item.create title: 'item_6_titl', seller_id: s2.id

i1.images << im1 << im2 << im3 << im4
i1.bulletings << b1 << b2 << b3 << b4 

im5 = Image.create path: 'i2im1'
im6 = Image.create path: 'i2im2'
im7 = Image.create path: 'i2im3'
im8 = Image.create path: 'i2im4'

i2.images << im5 << im6 << im7 << im8