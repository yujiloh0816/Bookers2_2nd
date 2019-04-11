class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # booksTableと関連付ける 1:n
  has_many :books

  # refile gem imageを扱えるようにする
  # attachment :column(_id) _idは記述しない
  attachment :my_image

  validates :name, length: { in: 2..20 }, presence: true
  validates :introduction, length: { maximum: 50 }

end
