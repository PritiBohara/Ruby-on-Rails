class RegistrationController < ApplicationController
    def new
        @user = User.new
    end
    
    def create 
        @user = User.new(registration_params)
        if @user.save
            login @user
            redirect_to root_path, notice: "User successfully registered."
        else
            render :new, status: :unprocessible_entity
        end
    end

    private

    def registration_params
        params.require(:user).permit(:email, :password, :password_confirmation)
    end
end
