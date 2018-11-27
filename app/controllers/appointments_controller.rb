class AppointmentsController < ApplicationController
  def index
    @appointments = Appointment.all
  end

  def new
    @flat = Flat.find(params[:flat_id])
    @appointment = Appointment.new
  end

  def create
    @appointment = Appointment.new(appointment_params)
    # we need `flat_id` to asssociate appointment with corresponding restaurant
    @appointment.flat = Flat.find(params[:flat_id])
    if @appointment.save
      redirect_to flat_path(@appointment.flat)
    else
      render :new
    end
  end

  def destroy
    @appointment = Appointment.find(params[:id])
    @flat = @appointment.flat
    @appointment.destroy
    redirect_to flat_path(@flat)
  end

  private

  def appointment_params
    params.require(:appointment).permit(:date, :time, :flat_id, :user_id, :status)
  end
end