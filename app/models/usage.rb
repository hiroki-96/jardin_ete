class Usage < ActiveHash::Base
  self.data = [
    { id: 1, name: '---' },
    { id: 2, name: '誕生日' },
    { id: 3, name: '記念日' },
    { id: 4, name: 'ギフト' },
    { id: 5, name: 'お悔やみ' },
    { id: 6, name: '自宅用' },
    { id: 7, name: 'その他' }
  ]

  # 誕生日、記念日、ギフト、お悔やみ、自宅用

  include ActiveHash::Associations
  has_many :orders
end