class LineItemsController < ApplicationController
  # GET /line_items
  # GET /line_items.json
  def index
    @line_items = LineItem.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @line_items }
    end
  end

  # GET /line_items/1
  # GET /line_items/1.json
  def show
    @line_item = LineItem.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @line_item }
    end
  end

  # GET /line_items/new
  # GET /line_items/new.json
  def new
    @line_item = LineItem.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @line_item }
    end
  end

  def subtract
    @user = current_user
    @cart = current_cart
    @line_item = LineItem.find_or_create_by_item_id_and_cart_id(:item_id=>params[:item_id], :cart_id=>@cart.id)
    @line_item.quantity  = @line_item.quantity - 1
    respond_to do |format|
      if @line_item.save
        format.html { redirect_to @cart, flash: {notice: 'Item successfully subtracted from cart.'} }
      else
        format.html { render action: "new" }
      end
    end
  end

  # POST /line_items
  # POST /line_items.json
  def add
    @user = current_user
    @cart = current_cart
    @line_item = LineItem.find_or_create_by_item_id_and_cart_id(:item_id=>params[:item_id], :cart_id=>@cart.id)
    if @line_item.quantity.nil?
      @line_item.quantity = 1
    else
      @line_item.quantity += 1
    end
    respond_to do |format|
      if @line_item.save
        format.html { redirect_to @cart, flash: {notice: 'Item successfully added to cart.'} }
        format.json { render json: @line_item, status: :created, location: @line_item }
      else
        format.html { render action: "new" }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /line_items/1
  # PUT /line_items/1.json
  def update
    @line_item = LineItem.find(params[:id])

    respond_to do |format|
      if @line_item.update_attributes(params[:line_item])
        format.html { redirect_to @line_item, notice: 'Line item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /line_items/1
  # DELETE /line_items/1.json
  def destroy
    @line_item = LineItem.where(:item_id => params[:item_id], :cart_id => params[:cart_id]).first
    @cart = @line_item.cart

    @line_item.destroy

    respond_to do |format|
      format.html { redirect_to @cart }
      format.json { head :no_content }
    end
  end
end
