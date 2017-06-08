module ProductsHelper
require 'csv'
require 'dbf'
  # Загружаем всю номенклатуру
  def getAllProducts
    widgets = DBF::Table.new("products.dbf", nil, 'cp866')
    widgets.each do |record|
      @p=Product.new
      @p.id = record.nnt
      @p.name = record.name
      @p.qtn = record.qnt
      @p.price = record.price
      @p.save
      puts record.name
      puts record.price
    end
  end

def impPrice
	widgets = DBF::Table.new("products.dbf", nil, 'cp866')   
	widgets.each do |record|
		if Product.where(:id => record.nnt).exists?
			p=Product.find_by_id(record.nnt)
			p.price=record.price
			p.ext_id=record.ext_id
			p.save
		else
		      @p=Product.new
		      @p.id = record.nnt
		      @p.name = record.name
		      @p.qtn = record.qnt
		      @p.price = record.price
		      @p.ext_id = record.ext_id
		      @p.save
		end  
	end
end

def importkls
    widgets = DBF::Table.new("KLScmp.dbf", nil, 'cp866')
    widgets.each do |record|     
       if Product.where(:id => record.cmp).exists?
          p = Product.find_by_id(record.cmp)
          p.group_id=record.kls
          p.save
       end
    end  
end

def impRLS
	CSV.foreach('rls.csv', :headers => true) do |row|
	  r = row.to_hash
	  puts r
 		rl = Rl.new
		rl.mnn = r["mnn"]
		rl.composition = r["composition"]
		rl.unindic = r["unindic"] 
		rl.method = r["method"] 
		rl.overdose = r["overdose"] 
		rl.precaut = r["precaut"] 
		rl.pregnan = r["pregnan"] 
		rl.text = r["text"] 
		rl.sideact = r["sideact"] 
		rl.pharmact = r["pharmact"] 
		rl.pharmak = r["pharmak"] 
		rl.actonorg = r["actonorg"] 
		rl.compsprop = r["compsprop"] 
		rl.specguid = r["specguid"] 
		rl.charactres = r["charactres"] 
		rl.drugform = r["drugform"] 
		rl.clinic = r["clinic"] 
		rl.direct = r["direct"] 
		rl.inst = r["inst"] 
		rl.recomend = r["recomend"] 
		rl.manufact = r["manufact"] 
		rl.liter = r["liter"]
		rl.save
	end

end

end
