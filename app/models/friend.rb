class Friend < ActiveRecord::Base
  belongs_to :user
  has_many :occasions

  attr_accessible :city, :name, :state, :street_address, :zipcode, :user_id

  validates_presence_of :name
  

  def self.add_fb_friend(current_user, params)
    friend = current_user.friends.build
    friend.name = params[:name]
    friend.save

    p params[:birthday].length
    if params[:birthday].length > 1
      p 'got inside the birthday conditional'
      occasion = friend.occasions.build
      occasion.date = Occasion.parse_birthday(params[:birthday])
      occasion.name = "#{friend.name}'s Birthday!"
      occasion.event_type_name = 'birthday'
      occasion.save
    end
  end

end
