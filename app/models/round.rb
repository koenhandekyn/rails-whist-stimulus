# == Schema Information
#
# Table name: rounds
#
#  id         :bigint(8)        not null, primary key
#  game_id    :uuid
#  score1     :integer
#  score2     :integer
#  score3     :integer
#  score4     :integer
#  roundtype  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Round < ApplicationRecord
  belongs_to :game

  validate :correct_score

  before_save :derive

  def correct_score
    case scores.compact.count
    when 1
      errors.add :base, "single score should be divisible by 3" if scores.compact.first % 3 != 0
    when 2
      errors.add :base, "two scores should be equal" if scores.compact.first != scores.compact.second
    when 4
      errors.add :base, "scores should sum up to 0" if scores.compact.sum != 0
      errors.add :base, "there cannot be more than 2 different score valeus" if scores.uniq.count > 2
    end
  end

  def derive
    if valid?
      case scores.compact.count
      when 1
        score = -max_score/3
        self.score1 = score if score1.blank?
        self.score2 = score if score2.blank?
        self.score3 = score if score3.blank?
        self.score4 = score if score4.blank?
      when 2
        score = -max_score
        self.score1 = score if score1.blank?
        self.score2 = score if score2.blank?
        self.score3 = score if score3.blank?
        self.score4 = score if score4.blank?
      when 3
        score = -max_score*3
        self.score1 = score if score1.blank?
        self.score2 = score if score2.blank?
        self.score3 = score if score3.blank?
        self.score4 = score if score4.blank?
      end
    end
    self
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

  def scores
    [score1, score2, score3, score4]
  end

  def max_score
    scores.compact.max
  end
end
