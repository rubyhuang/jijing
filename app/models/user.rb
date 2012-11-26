class User < ActiveRecord::Base
  acts_as_tagger
  acts_as_followable
  acts_as_follower
  has_many :posts, :dependent => :destroy

  has_many :visit_journals, :dependent => :destroy, :order => 'visit_journals.last_visited_at DESC'
  has_many :users, :through => :visit_journals, :source => :user, :source_type => 'User', :foreign_key => :guest_id
  has_many :guests, :through => :visit_journals, :source => :user, :source_type => 'User', :foreign_key => :user_id

  has_many :taggings, :dependent => :destroy, :order => 'taggings.created_at DESC'
  has_many :tags, :through => :taggings, :uniq => true

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :username, :email, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body

  validates :username, :presence => true
  validates :username, :uniqueness => { :case_sensitive => false }
  validates :username, :format => { :with => /^[a-zA-Z0-9_-]+$/, :message => "Only letters, numbers, _ and - allowed" }
  validates :username, :length => { :in => 4..16 }
  validates_each :name do |record, attr, value|
    record.errors.add(attr, 'must start with letters or numbers') unless value.match(/^[a-zA-Z0-9]([a-zA-Z0-9_-]+)*$/i)
  end
  
  attr_accessor :login
  attr_accessible :login

  def name
    self.username || self.email.split('@').first
  end

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end

  
  # Get the updated posts number from last visited on the following profile page
  def following_posts_count
    count_sql=<<-SQL
        SELECT COUNT(*) AS num FROM posts p
          INNER JOIN follows f ON f.followable_id = p.user_id         
          INNER JOIN visit_journals v ON v.user_id = p.user_id
	  WHERE f.follower_id = #{self.id} AND p.created_at > v.last_visited_at
	GROUP BY p.user_id
    SQL
    User.find_by_sql(count_sql)
  end
end
