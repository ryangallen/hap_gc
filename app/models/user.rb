class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :first_name, :last_name, :profile_name, :email, :password, :password_confirmation, :remember_me

  validates :first_name, presence:true
  validates :last_name, presence:true
  validates :profile_name, presence:true, 
                           uniqueness:true, 
                           format: { 
                            with: /^[a-zA-Z0-9][a-zA-Z0-9_-]*$/,
                            message: 'must be formatted correctly. (No spaces or crazy characters)'
                           }

  has_many :pins

  def full_name
  	first_name + " " + last_name
  end
  
  def gravurl
    clean_email = email.strip.downcase
    hash = Digest::MD5.hexdigest(clean_email)
    "http://gravatar.com/avatar/#{hash}"
  end
end