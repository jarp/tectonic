class AccountController < ApplicationController
  #before_action :require_login, except: [:login, :process_login, :callback]

  def index

  end

  def login
  end

  def callback
    puts "oauth callback"
    provider = params[:provider]

    if provider == 'google'
      info = info_from_the_google
    else
      throw 'What is going on?'
    end

    puts "looking up user"
    @player = Player.where(email: info[:email]).first_or_initialize
    new_record = @player.new_record?
    puts "looking up user:: #{@player}"

    if @player
      puts ">>setting userid "
      @player.first_name = info[:first_name]
      @player.last_name = info[:last_name]
      @player.image = info[:image]
      @player.save!
      session[:player_id] = @player.id
      session[:first_name] = @player.first_name
      session[:last_name] = @player.last_name
      session[:is_super] = true if @player.is_super
      puts "super user!" if @player.is_super
      flash[:notice] = "You have been logged in..."
      if cookies[:return_to]
        redirect_to cookies[:return_to]
      else
        redirect_to games_path
      end

    else
      flash[:notice] = "You do not have access to this site"
      redirect_to login_path
    end
  rescue => e
    puts ">> session error >> #{e}"
    flash[:message] = "Login could not be processed. Please try again."
    redirect_to login_path

  end

  def info_from_the_google
    {
      email: request.env["omniauth.auth"][:info][:email],
      first_name: request.env["omniauth.auth"][:info][:first_name],
      last_name: request.env["omniauth.auth"][:info][:last_name],
      image: request.env["omniauth.auth"][:info][:image]
    }
  end


  def process_login
     player = Player.find_by(email: params[:email])

     if player
      set_session(player)
      flash[:message] = 'You have been logged in'
      redirect_to account_path

    else
      flash[:message] = 'Nope!'
      redirect_to login_path
    end
  end

  def logout
    session[:player_id] = nil
    flash[:notice] = "You have been logged out"
    redirect_to login_path
  end
end
