class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  belongs_to :peran
  has_many :data_keagamaan_katolik

  before_create :set_default_role
  # or 
  # before_validation :set_default_role 

  private
  def set_default_role
    self.peran ||= Peran.find_by nama_peran: "Pemirsa" if self.peran.nil?
  end
end
