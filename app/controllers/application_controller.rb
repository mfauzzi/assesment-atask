class ApplicationController < ActionController::API
    def authorize_request
        header = request.headers['Authorization']
        token = header.split(' ').last if header
        decoded = JwtService.decode(token)

        if decoded
            @current_user = User.find(decoded[:user_id])
        else
            render json: { error: 'Unauthorized' }, status: :unauthorized
        end
    rescue
        render json: { error: 'Unauthorized' }, status: :unauthorized
    end
end
