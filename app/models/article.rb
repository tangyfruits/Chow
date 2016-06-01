class Article < ActiveRecord::Base
  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "default.jpeg"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
  belongs_to :user
  has_many :comments, dependent: :destroy
  validates :title, :text, presence: true,
                    length: { minimum: 1 }
 def self.search(search)
   where("LOWER(title) LIKE ? OR LOWER(text) LIKE ?", "%#{search.downcase}%", "%#{search.downcase}%")
 end
end
