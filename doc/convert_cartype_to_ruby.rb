
pin_pai = []
che_xing = []
open('cartype.js') do |file|
  file.each_line do  |line|
    if line=~/arrPinPai\[/
      vals = line.scan(/'[^']+'/)
      vals.each{|val| val.tr!("'",'')}
      pin_pai << vals
    elsif line=~/arrChexi\[/
      vals = line.scan(/'[^']+'/)
      vals.each{|val| val.tr!("'",'')}
      che_xing << vals
      
    end
  end
end

puts "pin_pai=#{pin_pai}"
