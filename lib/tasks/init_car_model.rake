# encoding: utf-8
namespace :car do

  desc "initial car model with cartype.js  "
  task :initial_model => :environment do
    CarModel.connection.execute "TRUNCATE TABLE `car_models"
    pin_pais = []
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
          che_xings << vals
          
        end
      end
    end
    
    for pin_pai in pin_pais
      car_model = CarModel.new   
      car_model.name = pin_pai[1]
      car_model.is_foreign = pin_pai[2]
      car_model.initial = pin_pai[3]
      
      children = che_xings.select{|che_xing| che_xing[2]==pin_pai[0]}
      
      for child in children
        child_model = CarModel.new   
        child_model.name = child[1]
        car_model.children << child_model
      end
      car_model.save      
    end
    
    car_model1 = CarModel.find_by_name("国产")
    car_model2 = CarModel.find_by_name("进口")
    
    native_brands = CarModel.roots.where(["is_foreign=? and id!=?",false, car_model1.id])
    foreign_brands = CarModel.roots.where(["is_foreign=? and id!=?",true, car_model2.id])

    car_model1.children =native_brands
    car_model2.children =foreign_brands
  end
end