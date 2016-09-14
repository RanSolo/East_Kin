# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
def rand_time(from, to=Time.now)
  Time.at(rand_in_range(from.to_f, to.to_f))
end

def rand_in_range(from, to)
  rand * (to - from) + from
end
oldUnion = Venue.create([{
                      name: 'Old Union',
                      link: "https://www.youtube.com/embed/8AH-0j3wJQw",
                      link2: "http://www.stonewallmusic.com/artists/oldunion.html",
                      location: 'Nashville, TN',
                      about: 'Soulshine Pizza Factory invites you to come on down and see us at any of our four great locations. We’re family friendly, have a great variety of freshly prepared menu items, include full bars and offer live entertainment the way only the South can! Choose your location and visit their respective page to find out the details like operating hours, menu items, live music and event schedules and more. Thanks for the visit!'
                      }])
