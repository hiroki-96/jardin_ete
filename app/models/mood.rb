class Mood < ActiveHash::Base
  self.data = [
    { id: 1, name: '---' },
    { id: 2, name: 'ナチュラル' },
    { id: 3, name: 'エレガント' },
    { id: 4, name: 'ポップ' },
    { id: 5, name: 'その他'}
  ]

  # ナチュラル、エレガント、ポップ、その他

  include ActiveHash::Associations
  has_many :orders
end