# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# 50.times do |i|
#   Kategori.create!(nama: "Brand #{i}", status: true)
# end

5.times do |i|
  Barang.create!(nama: "Pencil #{i}", status: true, kategori_id: 1, )
end