class Article < ActiveRecord::Base
  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "default.jpeg"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
  has_many :comments, dependent: :destroy
  validates :title, :text, presence: true,
                    length: { minimum: 1 }
end
