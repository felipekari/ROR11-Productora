class Group < ApplicationRecord
  validates :name, :gender, presence: true
  
  has_many :concerts, dependent: :destroy
  has_many :crews, inverse_of: :group, dependent: :destroy
  accepts_nested_attributes_for :crews, reject_if: :all_blank, allow_destroy: true

  enum gender: { hombres: 0, mujeres: 1, banda: 2 }

  def concertcount
    self.concerts.count
  end

  def crewcount
    self.crews.count
  end

  def attendantcount
    self.concerts.pluck(:attendants).sum
  end

  def debutdate
    if self.concerts.any?
      self.concerts.order(date: :asc).first.date
    else
      "No ha debutado"
    end
  end

  def monthconcert
    self.concerts.where('extract(year from date) = ?', Time.now.year).where('extract(month from date) = ?', Time.now.month).count
  end

  def last_concert
    if self.concerts.any?
      self.concerts.order(date: :asc).last.date.strftime("%Y-%B-%A")
    else
      "No ha debutado"
    end
  end

  def max_attendants
    if self.concerts.any?
      self.concerts.pluck(:attendants).max
    else
      "No ha debutado"
    end
  end

  def max_length
    if self.concerts.any?
      self.concerts.pluck(:length).max
    else
      "No ha debutado"
    end
  end
end
