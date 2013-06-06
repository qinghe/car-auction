module ChineseCities
  class Region
    attr_accessor :id, :name, :city_id

    def initialize(region)
      @id = region[:id]
      @city_id = region[:city_id]
      @name = region[:name]
    end

    def city
      City.find(city_id)
    end

    def city_name
      city.name
    end

    class << self
      private :new

      def search(name)
        regions = REGIONS.select { |region| region[:name] =~ /#{name}/ }
        regions.map do |region|
          new(region)
        end
      end

      def find_by_city_id(city_id)
        regions = REGIONS.select { |region| region[:city_id] == city_id }
        regions.map { |region| new(region) }
      end

      def find(id)
        region = REGIONS.find { |region| region[:id] == id }
        new(region) unless region.nil?
      end

      def where(name)
        regions = REGIONS.select { |region| region[:name] == name }
        regions.map { |region| new(region) } unless regions.empty?
      end

      def all_names
        REGIONS.map { |region| region[:name] }
      end

      def all
        REGIONS.map { |region| new(region) }
      end

    end
  end
end
