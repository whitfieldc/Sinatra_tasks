require 'thrones_faker'

# details = {
#   :description => ThronesFaker.words(rand(5)+1),
#   :complete => false
# }

5.times do
  Task.create({
  :content => ThronesFaker.words(rand(5)+1),
  :complete => false
})
end
