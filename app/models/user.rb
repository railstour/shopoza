class User < ActiveRecord::Base
  has_many :orders
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates_presence_of :name
  before_save :capitalize_name

  def capitalize_name
    self.name = name.split.map do |name_part|
      name_part.capitalize
    end.join(" ")
  end

  def first_name
    name.split(" ").first
  end

  def last_name
    (name.split(" ")[1..-1]).join(" ") || name
  end
end
