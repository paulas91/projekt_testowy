# frozen_string_literal: true

class ItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only: %i[show edit update destroy]

  def index
    @items = current_user.items
  end

  def show; end

  def new
    @item = current_user.items.build
  end

  def edit; end

  def create
    @item = current_user.items.new(item_params)

    respond_to do |format|
      if @item.save
        format.html { redirect_to item_url(@item), notice: 'Item was successfully created.' }
        format.json { render :show, status: :created, location: @item }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to item_url(@item), notice: 'Item was successfully updated.' }
        format.json { render :show, status: :ok, location: @item }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @item.destroy

    respond_to do |format|
      format.html { redirect_to items_url, notice: 'Item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def active
    @items = current_user.items.active
  end

  def inactive
    @items = current_user.items.inactive
  end

  def borrowed
    @items = current_user.items.borrowed
  end

  def on_place
    @items = current_user.items.on_place
  end

  def request_rent
    item = Item.find(params[:id])
    item.rental_requests.create!(user: current_user)
    owner = item.user
    owner.notifications.create(data: {
                                    message: "User #{current_user.email} requested to rent your item #{item.name}",
                                    type: 'rental_request',
                                    path: item_path(item)

    })
    RentalRequestMailer.ask(owner, current_user, item).deliver_now
    redirect_to items_friend_path(owner)
  end

  def return_item
    item = current_user.items.find(params[:id])
    item.update(borrowed: false, borrowed_at: nil, borrowed_to_id: nil)
    redirect_to items_path
  end

  private

  def set_item
    @item = current_user.items.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:name, :active, :borrowed, :item_type)
  end
end
