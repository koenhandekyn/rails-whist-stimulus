# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

koen = Player.create!(name: 'koen handekyn', email: 'koen@handekyn.com')
gert = Player.create!(name: 'gert de gelder', email: 'koen@handekyn.com')
yves = Player.create!(name: 'yves breemersch', email: 'koen@handekyn.com')
kevin = Player.create!(name: 'kevin doorakkers', email: 'koen@handekyn.com')

spain = Game.create!('spain', p1: koen, p2: gert, p3: yves, p4: kevin)
Round.create!(game: spain, s1: 2, s2: 2, s3: -2, s3: -2, roundtype: 'normal')
