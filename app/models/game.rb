class Game < ApplicationRecord
  belongs_to :p1, :class_name => 'Player', :foreign_key => 'p1_id', :validate => true
  belongs_to :p2, :class_name => 'Player', :foreign_key => 'p2_id', :validate => true
  belongs_to :p3, :class_name => 'Player', :foreign_key => 'p3_id', :validate => true
  belongs_to :p4, :class_name => 'Player', :foreign_key => 'p4_id', :validate => true
end
