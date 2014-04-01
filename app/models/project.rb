class Project < ActiveRecord::Base
	belongs_to :user
	has_many :tasks, dependent: :destroy
	validates_presence_of :name
	
	# validates :user,    presence: true
	# validates :title,   presence: true, uniqueness: true
	# validates :content, presence: true
end
