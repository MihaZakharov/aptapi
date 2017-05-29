module GroupsHelper
  #Загружаем всю классификацию
  def getAllGroups
    widgets = DBF::Table.new("kls.dbf", nil, 'cp866')
    widgets.each do |record|
      @p=Group.new
      @p.name = record.name
      @p.kls_unicode = record.kls_unicod
      @p.id = record.kls_unicod
      @p.kls_parent = record.kls_parent
      @p.kls_childcount = record.kls_childc
      @p.save
    end     
  end 


  def getkls    # делаем связки продуктов с классификацией

    widgets = DBF::Table.new("klscmp.dbf", nil, 'cp866')
    widgets.each do |record|
      @p=Product.find_by_id(record.cmp)
      @g=Group.find_by_id(record.kls)
      if @p != nil and @g != nil
         @p.groups<<@g
      end
#      @p.save
    end     

  end


  def getGrp
        @groups = Group.where('kls_parent=1613').each do |grp|
 		if grp.products.exists?
                    puts grp.products
                end
        end
  end
end
