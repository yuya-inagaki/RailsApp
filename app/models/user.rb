class User < ApplicationRecord
    has_secure_password validations: false
    validates :username, presence: true
    validates :email, presence: true, uniqueness: true, unless: :uid?
    validates :password, presence: true, unless: :uid?


    #auth hashからユーザ情報を取得
    #データベースにユーザが存在するならユーザ取得して情報更新する；存在しないなら新しいユーザを作成する
    def self.find_or_create_from_auth(auth)
        provider = auth[:provider]
        uid = auth[:uid]
        username = auth[:info][:nickname]
        puts "ユーザー名#{username}"
        image = auth[:info][:image]
        #必要に応じて情報追加してください
    
        #ユーザはSNSで登録情報を変更するかもしれので、毎回データベースの情報も更新する
        self.find_or_create_by(provider: provider, uid: uid) do |user|
            user.username = username
            user.image_path = image
        end
    end
    
end
