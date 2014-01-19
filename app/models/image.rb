class Image < ActiveRecord::Base
    attr_accessor :file
    validates :filepath, presence: true
    validates_length_of :description, maximum: 50
end
