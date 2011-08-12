module Kaminari
  module Helpers
    class Tag
      def initialize(template, options = {}) #:nodoc:
        @template, @options = template, options.dup
        @param_name = @options.delete(:param_name)
        @theme = @options[:theme] ? "#{@options.delete(:theme)}/" : ''
        @params = @options[:params] ? template.params.merge(@options.delete :params) : template.params
      end

      def to_s(locals = {}) #:nodoc:
        @template.render :partial => "kaminari/#{@theme}#{self.class.name.demodulize.underscore}", :locals => @options.merge(locals)
      end

      def page_url_for(page)
        begin
          @template.main_app.url_for @params.merge(@param_name => (page <= 1 ? nil : page))
        rescue 
          MOUNTED_ROUTES.each do|mr|
            mounted_route  = @template.send(mr[:name].to_sym)
            return mounted_route.url_for @params.merge(@param_name => (page <= 1 ? nil : page)) rescue next
          end
          raise $!
        end
      end
    end
  end
end

