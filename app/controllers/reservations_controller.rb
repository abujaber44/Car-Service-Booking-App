class ReservationsController < ApplicationController

      get "/reservations" do
        redirect_if_not_logged_in
        @reservations = current_user.reservations.sort_by { |reservation| reservation.date }
        erb :"reservations/index"
      end
    
      get "/reservations/new" do
        redirect_if_not_logged_in
        @reservation = Reservation.new
        erb :"/reservations/new"
      end
    
      post "/reservations" do
        redirect_if_not_logged_in
        @reservation = current_user.reservations.build(params[:reservation])
        if @reservation.date > Time.now
        @reservation.save
          redirect '/reservations'
        else
          @errors = @reservation.errors.full_messages
          redirect 'reservations/new'
        end
      end

      get '/reservations/:id' do
        redirect_if_not_logged_in
        @reservation = Reservation.find(params[:id])
        if current_user.id == @reservation.user_id
            erb :'/reservations/show'
        else
          redirect '/login'
        end
      end

      get '/reservations/:id/edit' do
        redirect_if_not_logged_in
        @reservation = Reservation.find(params[:id])
        if current_user.id == @reservation.user_id
            erb :'/reservations/edit'
        else
          redirect '/login'
        end
      end 

      patch '/reservations/:id' do
        @reservation = Reservation.find(params[:id])
        if @reservation.update(params[:reservation]) 
        redirect "/reservations/#{@reservation.id}"
        else
          erb :'/reservations/edit'
        end 
      end

      delete '/reservations/:id' do
        redirect_if_not_logged_in
          @reservation = Reservation.find(params[:id])
          @reservation.delete
          redirect '/reservations'
      end 
end 