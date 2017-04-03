class Book < ActiveRecord::Base
  enum status: %w(reservation now_on_sale end_of_print)
  scope :costly, -> { where("price > ?", 3000) }
  scope :written_about, -> (theme) { where("name like?", "%#{theme}") }
  #bookからみたらpublisherを紐付けている
  belongs_to :publisher
  #bookからみたらbook_authorsを複数持つ
  has_many :book_authors
  #bookからみたらauthorsを複数持つって
  has_many :authors, through: :book_authors

  #名前にが必ず入っていること
  validates :name, presence: true
  #名前の長さが15文字以上だとエラーを出す
  validates :name, length: { maximum: 15 }
  validates :price, numericality: { greater_than_or_equal_to: 0 }

  # validates do |book|
  #   if book.name.include?("exercise")
  #     book.errors[:name] << "I don't like exercise."
  #   end
  # end

  before_validation do |book|
    book.name = book.name.gsub(/Cat/) do |matched|
      "lovely#{matched}"
    end
  end

  after_destroy do |book|
    Rails.logger.info "Book is deleted: #{book.attributes.inspect}"
  end

  def high_price?
    price >= 5000
  end

  after_destroy :if => :high_price? do |book|
    Rails.logger.warn "Book with high price is deleted: #{book.attributes.inspect}"
    Rails.logger.warn "please check!!"
  end
end
