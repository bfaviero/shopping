class LineItem < ActiveRecord::Base
  belongs_to :item
  belongs_to :cart
  attr_accessible :quantity, :user_id, :item_id, :cart_id

end
