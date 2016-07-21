class Bird
  # Define class as a Mongoid Document
  include Mongoid::Document
 
  # Generates created_at and updated_at
  include Mongoid::Timestamps
 
  # Defining our fields with their types
  field :name, type: String
  field :visible, type: Boolean, default: false
  field :added, type: String, default: Date.today.strftime('%Y-%m-%d')
 
  # family and continents will be stores
  # inside Bird document
  belongs_to :family
  has_and_belongs_to_many :continents
 
  # Validates that the slug is present and unique
  validates :name, presence: true, uniqueness: true
  validates_associated :family, presence: true
  validates_associated :continents, presence: true, uniqueness: true

  def self.register(bird_param)
    bird = self.new(bird_param.slice(:name, :visible, :added).to_h)
    family = Family.find_or_create_by(name: bird_param[:family])
    bird.family = family
    bird_param[:continents].each do |continent|
      bird.continents << Continent.find_or_create_by(name: continent)
    end
    bird.save
    bird
  end
end