class ApplicationController < ActionController::Base
  before_action :store_user_location!, if: :storable_location?
  before_action :set_dates, only: :create
  before_action :authenticate_user!
   # Its important that the location is NOT stored if:
    # - The request method is not GET (non idempotent)
    # - The request is handled by a Devise controller such as Devise::SessionsController as that could cause an
    #    infinite redirect loop.
    # - The request is an Ajax request as this can lead to very unexpected behaviour.
    private

    def set_dates
      if params[:controller] =~ /.*appointments.*/
        session[:time] = params[:appointment][:time]
        session[:date] = params[:appointment][:date]
      end
    end

    def storable_location?
      is_navigational_format? && !devise_controller? && !request.xhr?
    end

    def store_user_location!
      # :user is the scope we are authenticating
      store_location_for(:user, request.referer)
    end
end
