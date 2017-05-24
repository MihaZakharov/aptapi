class ProductsController < ApplicationController
    skip_before_filter :verify_authenticity_token

  def showproductsfromgroup

      @grp = params[:id].to_s
      
      g = Group.find_by_id(@grp)
      res=[]
      buf={}
      g.products.where("price > 0").order("name ASC").each do |prod|
	buf={}
	buf[:name] = prod.name
	buf[:id] = prod.id
	buf[:price] = prod.price
	buf[:group_id] = prod.group_id
	res.push(buf)
      end
#      render json: @pr_in_grp
      render json: res

  end

  def all
    
  end

  def searching
     @par = params[:name].to_json
     res = Product.where("to_tsvector('russian',name) @@ to_tsquery('russian',?)",@par)
     if not res.exists?
        res = Product.where('similarity(name,?)>0.1',@par)
     end
     render json: res.order("name ASC")
  end

end
