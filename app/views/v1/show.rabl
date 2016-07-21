object @bird => false
attributes :id, :name, :visible, :added

node :family do |bird|
  bird.family.name
end

node :continents do |bird|
  bird.continents.map(&:name)
end