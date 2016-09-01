class School < ApplicationRecord
  validates_presence_of :name, :type

	def school_name
		"The School is named #{name}"
	end

	def school_type
	   type ? "Public" : "Private"
	end

	def self.by_name
		order(:name)
	end

end
