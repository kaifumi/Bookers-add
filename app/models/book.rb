class Book < ApplicationRecord
	belongs_to :user
	has_many :favorites
	has_many :favorited_users, through: :favorites, source: :user
	has_many :post_comments
	#バリデーションは該当するモデルに設定する。エラーにする条件を設定できる。
	#presence trueは空欄の場合を意味する。
	validates :title, presence: true
	validates :body, presence: true, length: {maximum: 200}

	# Bookの検索機能
	def self.search(method,word)
		# 完全一致検索
		if method=="1"
			Book.where("title LIKE?","#{word}")
		# 前方一致検索
		elsif method=="2"
			Book.where("title LIKE?","#{word}%")
		# 後方一致検索
		elsif method=="3"
			Book.where("title LIKE?","%#{word}")
		# 部分一致
		elsif method=="4"
			Book.where("title LIKE ?", "%#{word}%")
		else
			Book.all
		end
	end
end
