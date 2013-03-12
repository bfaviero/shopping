class Cart < ActiveRecord::Base
  attr_accessible :user_id, :active
  has_many :line_items

	def get_total_items
		total = 0
		self.line_items.each do |item|
			total+=item.quantity
		end
		total
	end

  def merge(old_cart)
    old_cart.line_items.each do |item|
      @LineItem = LineItem.where(:item_id => item.item.id, :cart_id => self.id).first_or_create
      if @LineItem.new_record?
        @LineItem.quantity = item.quantity
      else 
        if @LineItem.quantity.nil?
          @LineItem.quantity = 0
        end
        @LineItem.quantity += item.quantity
      end
      @LineItem.save
    end
  end

end


