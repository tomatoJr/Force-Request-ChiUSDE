class Admin < ActiveRecord::Base
    validates :name, presence: true
    validates :uin, presence: true
    # validates :password, presence: true
    validates_format_of :name, :with => /\w+/, :multiline => true
    
    attr_encrypted :password, key: ENV['PASSWORD_KEY'].truncate(32)
end
