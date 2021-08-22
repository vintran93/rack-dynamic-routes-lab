class Application

    @@items = [Item.new("Apples",1.50), Item.new("Oranges",1.75)]
    def call(env)
      resp = Rack::Response.new
      req = Rack::Request.new(env)
  
      if req.path.match(/items/)
        item_name = req.path.split("/items/").last
        if item = @@items.find{|i| i.name == item_name}
          resp.write item.price #Returns item price if it is in @@item
        else 
          resp.status = 400
          resp.write "Item not found" #Returns an error and 400 if the item is not there
        end
      else
        resp.status = 404 #Returns 404 for a bad route
        resp.write "Route not found"
      end
      resp.finish
    end
  
  end