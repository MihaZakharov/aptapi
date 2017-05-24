class GetinvoiceController < ApplicationController
    skip_before_filter :verify_authenticity_token


   def showinv
      params.require(:invoices).permit(:phone,:code,:email)
      @par = params[:invoices].to_json
      @hash = JSON.parse(@par)
      @phone = @hash["phone"] 
      @email = @hash["email"] 
      res=[]
      buf={}
      Invoice.all.where("email = :email AND phone_invoice = :phone",email: @email, phone: @phone).each do |inv|
	buf={}
	buf[:email] = inv.email
	buf[:id] = inv.id
	buf[:summ] = inv.summ
	buf[:status] = inv.status
	buf[:place] = inv.place
	buf[:updated_at] = inv.updated_at.to_s(:db)
	
	res.push(buf)
      end
      render  json: res

   end  

	def showdetailinvoice
      		res=[]
	        buf={}
	        params.require(:invoices).permit(:number_invoice)
		@par = params[:invoices].to_json
		@hash = JSON.parse(@par)
		@number_invoice = @hash["number_invoice"]
		inv = Invoice.find_by_id(@number_invoice)
#		items = inv.items
		hash = {}
		inv.items.each do |prod|
			buf = {}
			name_prod = Product.find_by_id(prod.goodsid)
			buf[:name] = name_prod.name
			buf[:goodsid] = prod.goodsid
			buf[:price] = prod.price
			buf[:qnt] = prod.qnt
			res.push(buf)
		end
		render json: res
	end

#http://localhost:3000/getinvoice/

#{"invoices":{"phone":"23423","email":"235","code":"123"}}

#{"invoices":{"number_invoice":65}}
end
