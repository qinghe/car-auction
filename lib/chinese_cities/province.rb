module ChineseCities
  class Province
    attr_accessor :id, :name

    def initialize(province)
      @id = province[:id]
      @name = province[:name]
    end

    def cities
      City.find_by_province_id(id)
    end

    def city_names
      cities.map(&:name)
    end

    class << self

      private :new

      def search(name)
        provinces = PROVINCES.select { |province| province[:name] =~ /#{name}/ }
        provinces.map do |province|
          new(province)
        end
      end

      def find(id)
        province = PROVINCES.find { |province| province[:id] == id }
        new(province) unless province.nil?
      end

      def where(name)
        province = PROVINCES.find { |province| province[:name] == name }
        new(province) if province
      end

      def all_names
        PROVINCES.map { |province| province[:name] }
      end

      def all
        PROVINCES.map { |province| new(province) }
      end
    end

  end
end
