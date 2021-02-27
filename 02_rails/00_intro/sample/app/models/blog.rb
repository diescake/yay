class Blog < ApplicationRecord
  # dependent :destroy をつけると Blog に関連するレコードも一緒に消去する
  has_many :entries, dependent: :destroy
  validates :title, presence: true
  scope :title_search, ->(title) { where('title like :title', title: "%#{title}") }
  # return by "all" if title is not matched
  scope :notfound_scope, -> { where(title: '100000').first }

  # 完全に同時リクエストの場合アプリケーションレベルのバリデーションはすり抜けることがある
  validates :title, uniqueness: true

  def self.notfound_method
    where(title: '100000').first
  end
end
