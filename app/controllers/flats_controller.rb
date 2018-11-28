class FlatsController < ApplicationController
  before_action :set_flat, only: [:show, :edit, :update, :destroy]
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @flats = Flat.near(params["address"], 15)
    @markers = @flats.map do |flat|
      {
        lng: flat.longitude,
        lat: flat.latitude,
        infoWindow: { content: render_to_string(partial: "/flats/map_window", locals: { flat: flat }) }
      }
    end
  end

  def show
    @appointments = @flat.appointments
  end

  def new
    @flat = Flat.new
  end

  def create
    @flat = Flat.new(flat_params)
    if !flat_params[:photo]
      @flat.remote_photo_url = "https://urbangauge.com/wp-content/uploads/2018/06/flat-768x384.jpg"
    end
    @flat.user = current_user
    if @flat.save
      redirect_to flat_path(@flat)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @flat.update(flat_params)
      redirect_to flats_path
    else
      render :edit
    end
  end

  def destroy
    @flat.destroy
    redirect_to flats_path
  end

  private

  def flat_params
    params.require(:flat).permit(:title, :price, :address, :description, :number_of_rooms, :photo, :user_id)
  end

  def set_flat
    @flat = Flat.find(params[:id])
  end
end
