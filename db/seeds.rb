# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Item.destroy_all
Image.destroy_all
User.destroy_all
# ItemDetail.destroy_all

s1 = User.create name: 'seller_1', email: 's1@ohction,com', password_digest: '123'
s2 = User.create name: 'seller_2', email: 's2@ohction,com', password_digest: '123'

im1= Image.create image_path: 'item1_1.jpg'
im2= Image.create image_path: 'item1_2.jpg'
im3= Image.create image_path: 'item1_3.jpg'
im4= Image.create image_path: 'item1_4.jpg'

i1 = Item.create title: 'item_1_titl', seller_id: s1.id
i2 = Item.create title: 'item_2_titl', seller_id: s1.id
i3 = Item.create title: 'item_3_titl', seller_id: s1.id
i4 = Item.create title: 'item_4_titl', seller_id: s1.id
i5 = Item.create title: 'item_5_titl', seller_id: s1.id
i6 = Item.create title: 'item_6_titl', seller_id: s2.id
ItemDetail.create item_id: i1.id, image_id: im1.id
ItemDetail.create item_id: i1.id, image_id: im2.id
ItemDetail.create item_id: i1.id, image_id: im3.id
ItemDetail.create item_id: i1.id, image_id: im4.id
# i1.images << im1 << im2 << im3 << im4

