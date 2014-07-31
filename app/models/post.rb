class Post < ActiveRecord::Base

	belongs_to :group
	validates :context, :presence => true

end
