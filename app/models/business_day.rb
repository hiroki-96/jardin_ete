class BusinessDay < ApplicationRecord
  validates :date, presence: true, uniqueness: true
  validates :opening_time, :closing_time, presence: true, if: :is_open?
  validate :closing_after_opening, if: :is_open?

  def closing_after_opening
    if opening_time && closing_time && closing_time <= opening_time
      errors.add(:closing_time, "は開始時刻より後にしてください")
    end
  end

  def self.open_on?(date)
    find_by(date: date, is_open: true).present?
  end

  def self.opening_hours_on(date)
    day = find_by(date: date, is_open: true)
    day ? { opening_time: day.opening_time, closing_time: day.closing_time } : nil
  end
end 