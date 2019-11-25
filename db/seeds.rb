Dir[File.join(Rails.root, 'db', 'seeds', '*.rb')].sort.each do |seed|
  p "Seeding #{seed}"
  load seed
end
