class User < ApplicationRecord
    has_secure_password validations: false
    validates :password, length:{minimum:6}, confirmation: true, on: :create
    validates :username, presence: true
    validates :email, presence: true, unless: :uid?
    validates :email, uniqueness: { case_sensitive: false, message: "このメールアドレスはすでに登録されています" }


    #auth hashからユーザ情報を取得
    #データベースにユーザが存在するならユーザ取得して情報更新する；存在しないなら新しいユーザを作成する
    def self.find_or_create_from_auth(auth)
        provider = auth[:provider]
        uid = auth[:uid]
        username = auth[:info][:nickname]
        image = auth[:info][:image]
    
        #ユーザはSNSで登録情報を変更するかもしれので、毎回データベースの情報も更新する
        self.find_or_create_by(provider: provider, uid: uid) do |user|
            user.username = username
            user.image_path = image
        end
    end
    
end
