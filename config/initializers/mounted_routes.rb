Rails.application.config.after_initialize do
  Rails.application.reload_routes!
  MOUNTED_ROUTES =
    Rails.application.routes.routes.dup.collect do |route|
        reqs = route.requirements.dup
        unless route.app.class.name.to_s =~ /^ActionDispatch::Routing/ or route.name.to_s.blank?
          reqs[:to] = route.app 
          {:name => route.name.to_s, :verb => route.verb.to_s, :path => route.path }
        else
          nil
        end
    end.compact
end
