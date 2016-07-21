class Continent
  # Define class as a Mongoid Document
  include Mongoid::Document
  
  # Generates created_at and updated_at
  include Mongoid::Timestamps

  # Define fields with their types
  field :name, type: String
 
  # This model should be saved in the bird document
  has_and_belongs_to_many :birds
 
  validates :name, presence: true, uniqueness: true
end
 
