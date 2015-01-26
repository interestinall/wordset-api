
class Entry
  include Mongoid::Document
  include Suggestable
  field :pos, type: String
  has_many :meanings, autosave: true
  belongs_to :word

  validates :word,
            :presence => true

  validates :meanings,
            :associated => true,
            :length => { :minimum => 1 },
            :on => :create

  index({word_id: 1})
  index({pos: 1})

  def self.pos
    %w(adv adj verb noun)
  end

  def self.suggestable_fields
    %w(pos)
  end

  def self.suggestable_children
    %w(meanings)
  end
end