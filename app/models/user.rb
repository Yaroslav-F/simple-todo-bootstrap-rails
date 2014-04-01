class User < ActiveRecord::Base
	devise :database_authenticatable, :registerable, :confirmable, :recoverable, stretches: 20
	has_role
	has_many :projects
end
