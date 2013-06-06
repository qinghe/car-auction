module ChineseCities
  class City
    attr_accessor :id, :name, :province_id

    def initialize(city)
      @id = city[:id]
      @province_id = city[:province_id]
      @name = city[:name]
    end

    def province
      Province.find(province_id)
    end

    def province_name
      province.name
    end

    def regions
      Region.find_by_city_id(id)
    end

    def region_names
      regions.map(&:name)
    end

    class << self

      private :new

      def search(name)
        cities = CITIES.select { |city| city[:name] =~ /#{name}/ }
        cities.map do |city|
          new(city)
        end
      end

      def find_by_province_id(province_id)
        cities = CITIES.select { |city| city[:province_id] == province_id }
        cities.map { |city| new(city) } unless cities.nil?
      end

      def find(id)
        city = CITIES.find { |city| city[:id] == id }
        new(city) unless city.nil?
      end

      def where(name)
        cities = CITIES.select { |city| city[:name] == name }
        cities.map { |city| new(city) } unless cities.empty?
      end

      def all_names
        CITIES.map { |city| city[:name] }
      end

      def all
        CITIES.map { |city| new(city) }
      end
    end

  end
end
