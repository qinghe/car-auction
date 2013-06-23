# encoding: utf-8

module ChineseCities
  module Helpers
    module FormHelper
      
      def region_select(object, methods, options = {}, html_options = {})
        output = ''
        html_options[:class] ?
          (html_options[:class].prepend('region_select ')) : 
            (html_options[:class] = 'region_select')
            
        if Array === methods
          methods.each_with_index do |method, index|
            klass_name = [ 'province','city','region' ].select{|n| method=~/#{n}/}.first
            region_klass = ('chinese_cities/'+klass_name.to_s).classify.safe_constantize
            if region_klass.present?
              choices = (index == 0 ? region_klass.all.collect {|p| [ p.name, p.id ] } : [])
              origin_selected = options[:selected]
              if options[:selected]
                if Array === options[:selected]
                  selected = options[:selected][index]
                else
                  selected = options[:selected] if index == 0
                end
              end
              if index > 0 and selected
                parent_selected = options[:selected][index-1]
                scope_method = [ 'province','city','region' ][index-1]+"_id"
                choices = region_klass.all.select{|q|q.send(scope_method) == parent_selected}.collect {|p| [ p.name, p.id ] }
              end
              next_method = methods.at(index + 1)
              set_region_options(method, options, region_klass)
              set_region_html_options(object, method, html_options, next_method)
              options[:selected] = selected if selected
              output << select(object, "#{method.to_s}_id", choices,  options,  html_options)
              options[:selected] = origin_selected
            else
              raise "Method '#{method}' is not a vaild attribute of #{object}"
            end
          end
        else
          _methods = unless methods.to_s.include?('_id')
            (methods.to_s + ('_id')).to_sym 
          else
            _methods = methods
            methods = methods.to_s.gsub(/(_id)$/, '')
            _methods
          end

          if region_klass = methods.to_s.classify.safe_constantize
            options[:prompt] = region_prompt(region_klass)
            
            output << select(object, _methods, region_klass.scoped.collect {|p| [ p.name, p.id ] }, options = options, html_options = html_options)
          else
            raise "Method '#{method}' is not a vaild attribute of #{object}"
          end
        end
        
        output << javascript_tag(js_output)
        output.html_safe
      end
    
    
      private
      
      def set_region_options(method, options, region_klass)
        if respond_to?("#{method}_select_prompt")
          options[:include_blank] = __send__("#{method}_select_prompt")
        else
          options[:include_blank] = region_prompt(region_klass)
        end
      end
      
      def set_region_html_options(object, method, html_options, next_region)
        html_options[:data] ? (html_options[:data][:region_klass] = "#{method.to_s}") : (html_options[:data] = { region_klass: "#{method.to_s}" })
        if next_region
          # object may be car[accidents_attributes][0]_city_id
          #aciton_views/form_helper#sanitized_object_name
          object_name = object.dup.gsub(/\]\[|[^-a-zA-Z0-9:.]/, "_").sub(/_$/, "") 
          
          html_options[:data].merge!(region_target: "#{object_name}_#{next_region.to_s}_id", region_target_klass: next_region.to_s)
        else
          html_options[:data].delete(:region_target)
          html_options[:data].delete(:region_target_klass)
        end
      end
        
      def region_prompt(region_klass)
        t('views.select.'+region_klass.name.demodulize.underscore)
      end
      
      def js_output
        %~        
          $(function(){
            var cities = #{ChineseCities::CITIES.to_json}
            var regions = #{ChineseCities::REGIONS.to_json}
            $('.region_select').change(function(event){
              var self, targetDom, selected_id;
              self = $(event.currentTarget);
              selected_id = parseInt(self.val());
              targetDom = $('#' + self.data('region-target'));
              if (targetDom.size() > 0) {
                var data = []
                if (self.data('region-target').match('city_id'))
                {
                  $.each(cities, function(index, value) {
                    if (value.province_id==selected_id)
                    { data.push( value ) }
                  })
                } else {
                  $.each(regions, function(index, value) {
                    if (value.city_id==selected_id)
                    { data.push( value ) }
                  })                 
                } 
                  $('option[value!=""]', targetDom).remove();
                  $.each(data, function(index, value) {
                    targetDom.append("<option value='" + value.id + "'>" + value.name + "</option>");
                  });
                
              }
            });
          });
        ~
      end
  
    end
    
    
    module FormBuilder
      def region_select(methods, options = {}, html_options = {})
        @template.region_select(@object_name, methods, options = options, html_options = html_options)
      end
    end

  end
end
ActionView::Base.send :include, ChineseCities::Helpers::FormHelper
ActionView::Helpers::FormBuilder.send :include, ChineseCities::Helpers::FormBuilder
