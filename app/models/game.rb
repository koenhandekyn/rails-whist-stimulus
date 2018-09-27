# == Schema Information
#
# Table name: games
#
#  id         :uuid             not null, primary key
#  owner      :string
#  player1    :string           not null
#  player2    :string           not null
#  player3    :string           not null
#  player4    :string           not null
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Game < ApplicationRecord
  has_many :rounds # cascade delete done in database

  validates :name, presence: true
  validates :player1, presence: true
  validates :player2, presence: true
  validates :player3, presence: true
  validates :player4, presence: true

  def score1
    rounds.sum(:score1)
  end

  def score2
    rounds.sum(:score2)
  end

  def score3
    rounds.sum(:score3)
  end

  def score4
    rounds.sum(:score4)
  end

  def score_sign1
    score1 >= 0 ? 'pos' : 'neg'
  end

  def score_sign2
    score2 >= 0 ? 'pos' : 'neg'
  end

  def score_sign3
    score3 >= 0 ? 'pos' : 'neg'
  end

  def score_sign4
    score4 >= 0 ? 'pos' : 'neg'
  end

  def winner1
    score1 == max_score ? 'winner' : 'looser'
  end

  def winner2
    score2 == max_score ? 'winner' : 'looser'
  end

  def winner3
    score3 == max_score ? 'winner' : 'looser'
  end

  def winner4
    score4 == max_score ? 'winner' : 'looser'
  end

  def scores
    [score1, score2, score3, score4]
  end

  def max_score
    scores.compact.max
  end
end
