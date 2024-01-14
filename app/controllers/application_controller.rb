class ApplicationController < ActionController::API
    include Authenticatable
    include Paginable
end
