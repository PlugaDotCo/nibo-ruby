module Nibo
  class Entity < Nibo::Object
    include ApiResource
    include ApiResource::Create
    include ApiResource::List

    def self.find_by(params)
      entities = list(params[:type])
      entity_result = nil
      entities.each do |entity|
        result = false
        params.each do |key, value|
          unless entity.send(key.to_s.camelcase) == params[key]
            result = false
            break
          end

          result = true
        end
        if result
          entity_result = entity
          break
        end

      end
      entity_result
    end

    def self.url_method(method)
      case method
        when :get
          '/GetEntitie'
        when :post
          '/CreateEntity'
      end
    end

    def self.object_param(param, method)
      case method
        when :get
          {type: param}
        when :post
          param
      end
    end
  end
end
