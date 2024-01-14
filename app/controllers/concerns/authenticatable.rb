module Authenticatable
    def current_user
        return @current_user if @current_user

        header = request.headers['Authorization']
        return nil if header.nil?
        header = header.split(' ').last # support Bearer token

        decode = JsonWebToken.decode(header)
        @current_user = User.find(decode[:user_id]) rescue ActiveRecord::RecordNotFound
    end

    def check_login
        head(:forbidden) unless self.current_user
    end
end