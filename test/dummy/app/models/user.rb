class User < ActiveRecord::Base
  attr_accessible :name

  has_referer_tracking
end
