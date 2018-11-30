class FlatsController < ApplicationController
  before_action :set_flat, only: [:show, :edit, :update, :destroy]
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    flat_aux = Flat.near(params["query"]["address"].split("/")[0] , 15)

    if params[:query]["address"].split("/")[1].nil?
    @flats = flat_aux.where(price: params[:query][:min_price]..params[:query][:max_price]  )
      else
    @flats = flat_aux.where(price: params[:query]["address"].split("/")[1]..params[:query]["address"].split("/")[2]  )
    end

    @markers = @flats.map do |flat|
      {
        lng: flat.longitude,
        lat: flat.latitude,
        infoWindow: { content: render_to_string(partial: "/flats/map_window", locals: { flat: flat }) }
      }
    end
  end

  def show
    if !params[:format].nil?
      if params[:format].split("/").size == 2
      aux = params[:format].split("/")
      appoint = Appointment.find(aux[0].to_i)
      appoint.status = aux[1]
      appoint.save
      end
    end
    @appointments = @flat.appointments

    @appointment = Appointment.new
    if session[:date] && session[:time]
      # raise
      @appointment.date = session[:date]
      @appointment.time = session[:time]
    end
  end

  def new
    @flat = Flat.new
  end

  def create
    user_aux = User.find(current_user.id)
    user_aux.seller = true
    user_aux.save
    @flat = Flat.new(flat_params)
    if !flat_params[:photo]
      @flat.remote_photo_url = "https://urbangauge.com/wp-content/uploads/2018/06/flat-768x384.jpg"
    end
    current_user.seller = true
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
      redirect_to profiles_path
    else
      render :edit
    end
  end

  def destroy
    @flat.destroy
    redirect_to profiles_path
  end

  private

  def flat_params
    params.require(:flat).permit(:title, :price, :address, :description, :number_of_rooms, :photo, :user_id)
  end

  def set_flat
    @flat = Flat.find(params[:id])
  end
end
