Round.delete_all
Game.delete_all

# Player.delete_all

# koen = Player.create!(name: 'koen', email: 'koen@handekyn.com')
# gert = Player.create!(name: 'gert', email: 'koen@handekyn.com')
# yves = Player.create!(name: 'yves', email: 'koen@handekyn.com')
# kevin = Player.create!(name: 'kevin', email: 'koen@handekyn.com')

spain = Game.create!(name: 'spain', player1: 'koen', player2: 'gert', player3: 'yves', player4: 'kevin', owner: 'koen')
Round.create!(game: spain, score1: 2, score2: 2, score3: -2, score4: -2, roundtype: 'normal')
Round.create!(game: spain, score1: 12, score2: -4, score3: -4, score4: -4, roundtype: 'abondance')
Round.create!(game: spain, score1: 9, score2: -3, score3: -3, score4: -3, roundtype: 'kleine miserie')
