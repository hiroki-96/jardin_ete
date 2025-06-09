class ColorTone < ActiveHash::Base
  self.data = [
    { id: 1, name: '---' },
    { id: 2, name: 'ピンク系' },
    { id: 3, name: 'ホワイトグリーン系' },
    { id: 4, name: '黄色系' },
    { id: 5, name: 'オレンジ系'},
    { id: 6, name: '寒色系(青・紫)'},
    { id: 7, name: 'その他'}
  ]

  # ピンク系、ホワイトグリーン系、黄色・オレンジ系、寒色系（青・紫）、その他

  include ActiveHash::Associations
  has_many :orders
end