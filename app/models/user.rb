class User < ApplicationRecord
  has_many :messages

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable,:validatable,:confirmable

  def user_address
    "%s %s"%([self.address_city,self.address_street])
  end
  
  # グーグルマップで指定した住所に表示する用
  geocoded_by :user_address
  after_validation :geocode


  has_many :books,dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_books, through: :favorite, source: :book
  attachment :profile_image, destroy: false

  #バリデーションは該当するモデルに設定する。エラーにする条件を設定できる。
  validates :name, presence:true,length: {maximum: 20, minimum: 2}
  validates :email, uniqueness: true
  validates :introduction,length:{maximum:50}

  # has_many :post_images, dependent: :destroy
  has_many :post_comments, dependent: :destroy

  # 能動関係に対して1対多の関連付け
  has_many :active_relationships, class_name:  "Relationship",
                                  foreign_key: "follower_id",
                                  dependent:   :destroy
  # 受動的関係を使ってuser.followersを実装
  has_many :passive_relationships,class_name: "Relationship",
                                  foreign_key: "followed_id",
                                  dependent: :destroy                  
  # followingという外部キーをactive_relationshipsという中間テーブルを通して1対多で関連付ける
  has_many :following, through: :active_relationships, source: :followed
  # followersという外部キーをもたせる。sourceは省略してもよい。
  has_many :followers, through: :passive_relationships, source: :follower

  # チャット機能
  # has_many :messages

   # すでにいいねした確認
   def already_favorited?(book)
    self.favorites.exists?(book_id: book.id)
  end

  # ユーザーをフォローする
  def follow(other_user)
    following << other_user
  end

  # ユーザーをフォロー解除する
  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user).destroy
  end

  # 現在のユーザーがフォローしてたらtrueを返す
  def following?(other_user)
    following.include?(other_user)
  end

  # Userの検索機能
	def self.search(method,word)
		# 完全一致検索
		if method=="1"
			User.where("name LIKE?","#{word}")
		# 前方一致検索
		elsif method=="2"
			User.where("name LIKE?","#{word}%")
		# 後方一致検索
    elsif method=="3"
      User.where("name LIKE?","%#{word}")
		# 部分一致
		elsif method=="4"
			User.where("name LIKE ?", "%#{word}%")
		else
			User.all
		end
  end
  
  # 住所検索機能
  
  include JpPrefecture
  jp_prefecture :prefecture_code
  
  def prefecture_name
    JpPrefecture::Prefecture.find(code: prefecture_code).try(:name)
  end
  
  def prefecture_name=(prefecture_name)
    self.prefecture_code = JpPrefecture::Prefecture.find(name: prefecture_name).code
  end

  def send_regular_mail
		@user=User.find(1)
		NotificationMailer.send_regular_to_user(@user).deliver
	end

end
