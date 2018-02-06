class User < ApplicationRecord

    devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable,
          :confirmable, :omniauthable
    include DeviseTokenAuth::Concerns::User
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable and :omniauthable
    has_many :companies, dependent: :destroy

end
