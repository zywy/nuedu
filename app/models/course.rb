class Course < ActiveRecord::Base
  resourcify

  has_and_belongs_to_many :categories

  has_many :steps, -> { order('position asc')}
  has_many :attachments, as: :attachable
  has_one :exam, as: :examable

  has_many :participations
  has_many :participants, through: :participations, source: :user


  validates :name, presence: true
  validates :description, presence: true

  has_attached_file :logo, :styles => { medium: "300x300>", small: "200x200>", thumb: "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :logo, :content_type => /\Aimage\/.*\Z/


  def published?
    status == 'PUBLISHED'
  end
end
