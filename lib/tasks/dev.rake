task sample_data: :environment do
  p "Creating sample data"

  if Rails.env.development?
   FollowRequest.destroy_all 
   User.destroy_all
  end 
  12.times do
    name = Faker::Name.first_name
    u = User.create(
      email: "#{name}@example.com",
      username: name,
      password: "password",
      private: [true, false].sample
    )
  end
    p "#{User.count} users have been created."


  users = User.all

  users.each do |first_user|
    users.each do |second_user|
      if rand < 0.75
        first_user.sent_follow_requests.create(
          recipient: second_user,
          status: FollowRequest.statuses.keys.sample
        )
      end
      if rand < 0.75
        second_user.sent_follow_requests.create(
          recipient: second_user,
          status: FollowRequest.statuses.keys.sample
        )
      end
    end
  end

  users.each do |user|
    rand(15).times do
      photo = user.own_photos.create(
        caption: Faker::Quote.jack_handey,
        image: "https://robohash.org/#{rand(9999)}"
      )

      users.followers.each do |follower|
        if rand < 0.5
          photo.fans << follower
        end

        if rand < 0.25
          photo.comments.create(
            body: Faker::Quote.jack_handey,
            author: follower
          )
        end
      end
    end
  end


p "It took #{(ending - starting).to_i} seconds to create sample data"
p "there are now #{User.count} users."
p "there are now #{FollowRequests.count} follow requests."
p "there are now #{Photo.count} photos."
p "there are now #{Like.count} likes."
p "there are now #{Comment.count} comments."
end