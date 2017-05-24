module ProductsHelper
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
			p.save
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

  def prodloop # Всех в первую группу
    @p=Product.all
    @c=Group.first
    @p.each do |prod|
      @c.products << @p
    end
  end

  def prodloop # Всех в первую группу
    @p=Product.limit(500)
    @c=Group.first
    @p.each do |prod|
      @c.products << @p
    end
  end

end
