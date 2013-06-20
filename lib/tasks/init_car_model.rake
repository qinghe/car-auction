# encoding: utf-8
namespace :car do

  desc "initial car model with cartype.js  "
  task :initial_models => :environment do
    CarModel.connection.execute "TRUNCATE TABLE `car_models"
    pin_pais = []
    che_xis = []
    che_xings = []
    open(File.join(File.dirname(__FILE__),'cartype.js')) do |file|
      file.each_line do  |line|
        if line=~/arrPinPai\[/
          vals = line.scan(/'[^']+'/)
          vals.each{|val| val.tr!("'",'')}
          pin_pais << vals
        elsif line=~/arrChexi\[/
          vals = line.scan(/'[^']+'/)
          vals.each{|val| val.tr!("'",'')}
          che_xis << vals
        elsif line=~/arrChexing\[/
          vals = line.scan(/'[^']+'/)
          vals.each{|val| val.tr!("'",'')}
          che_xings << vals          
        end
      end
    end
    
    for pin_pai in pin_pais
      car_model = CarModel.new   
      car_model.name = pin_pai[1]
      car_model.is_foreign = pin_pai[2]
      car_model.initial = pin_pai[3]
      
      cur_che_xis = che_xis.select{|che_xi| che_xi[2]==pin_pai[0]}
      car_model.save            
      for che_xi in cur_che_xis
        che_xi_model = car_model.children.create( :name=> che_xi[1] )        
        cur_che_xings = che_xings.select{|che_xing| che_xing[2]==che_xi[0]}
        for che_xing in cur_che_xings
          che_xi_model.children.create( :name=> che_xing[1] ) 
        end
      end
    end
    
    #car_model1 = CarModel.find_by_name("国产")
    #car_model2 = CarModel.find_by_name("进口")
    
    #native_brands = CarModel.roots.where(["is_foreign=? and id!=?",false, car_model1.id])
    #foreign_brands = CarModel.roots.where(["is_foreign=? and id!=?",true, car_model2.id])

    #car_model1.children =native_brands
    #car_model2.children =foreign_brands
    
    #CarModel.leaves.each{|leaf|
    #  leaf.update_attibute( :full_name, ( leaf.parent.name + leaf.name )
    #}
  end
end