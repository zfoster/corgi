class User < ActiveRecord::Base
  has_many :identities
end
