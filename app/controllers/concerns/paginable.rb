module Paginable
    def current_page
        (params[:page] || 1).to_i
    end

    def per_page
        (params[:per_page] || 10).to_i
    end

    def links(path, collection)
        { 
            links: {
                first: send(path, page: 1),
                last: send(path, page: collection.total_pages),
                prev: send(path, page: collection.prev_page),
                next: send(path, page: collection.next_page)
            }
        }
    end
end