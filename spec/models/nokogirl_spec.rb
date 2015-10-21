require 'rails_helper'

describe Nokogiri::XML do
  let( :xml ){  File.read(File.expand_path('../../fixtures/car.xml', __FILE__)) }

  it 'should read REQUEST attributes' do
    doc = Nokogiri::XML( xml )
    doc.xpath("REQUEST/*").to_s

  end
end
