#require 'config/environment'
namespace :utils do
  desc "import price and creating goods if not exists"
  task :import_price  => :environment do

    widgets = DBF::Table.new("Products.dbf", nil, 'cp866')
    widgets.each do |record|
      if Product.where(:id => record.nnt).exists?
        p=Product.find_by_id(record.nnt)
        p.price=record.price
        p.price=record.price1
        p.ext_id=record.ext_id
        p.save
      else
            @p=Product.new
            @p.id = record.nnt
            @p.name = record.name
            @p.price = record.price
            @p.price1=record.price1
            @p.ext_id = record.ext_id
            @p.save
      end #end if
    end # end loop

    res=[]
    rr={}
  	CSV.foreach("klscmp.csv",:quote_char => "\x00", encoding: "windows-1251",col_sep: ',', :headers => true) do |row|
      rr = {}
      r = row.to_hash
  #    rr[:cmp] = r["cmp"]
  #    rr[:kls] = r["kls"]
      res.push(rr)
    end
    res.each { |k|
      if Product.where("id = :p",{p:k[:cmp]}).exists?
            @p=Product.find_by_id(k[:cmp])
            @g=Group.find_by_id(k[:kls])
            if @p != nil and @g != nil
               @p.groups<<@g
               @p.save
            end
      end
    }

  end #task import_price



end
