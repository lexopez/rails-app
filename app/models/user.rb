class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :timeoutable, :trackable, 
         :omniauthable, omniauth_providers: [:google_oauth2, :github]

  enum role: {user: 0, admin: 1}

  validates :phone, phone: true, on: :registration

  def self.from_omniauth(auth)
    user = User.where(email: auth.info.email).first
    if user.nil?
      user = User.create!(
        email: auth.info.email,
        password: Devise.friendly_token[0,20],
      )
      # user.skip_confirmation!
      UserRegistrationService.call(user)
    end
    user.provider = auth.provider
    user.full_name = auth.info.name # assuming the user model has a name
    user.avatar_url = auth.info.image # assuming the user model has an image
    user.uid = auth.uid
    user.save(context: :registration)
    
    user

  end
end
