class SessionsController < ApplicationController
    def create
        user = User.find_or_create_by(email: params[:email]) do |u|
            u.password_digest = BCrypt::Password.create(params[:password])
        end

        if user.present?
            new_user = User.create(email: params[:email], password_digest: (params[:password]))
        end
        
        if user.authenticate(params[:password])
            token = JwtService.encode({ user_id: user.id })
            render json: { token: token }, status: :created
        else
            render json: { error: 'Invalid email or password' }, status: :unauthorized
        end
    end
end  