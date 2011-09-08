# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
require "lipsum"  
  
seeds_path = File.join(File.dirname(__FILE__), 'seeds')

Dir["#{seeds_path}/*"].select { |file| /(yml)$/ =~ file }.sort.each do |file|
  klass = File.basename(file, '.yml').gsub(/[0-9]+\-/,'').singularize.humanize.constantize
  #YAML.load_file(file).each  do |key, params|
  YAML::load(ERB.new(IO.read(file)).result).each  do |key, params|
    conditions = {}
    klass = params['type'].constantize unless params['type'].nil?
    unless params['uniq'].nil?
      params['uniq'] = [params['uniq']] unless params['uniq'].is_a?(Array)
      params['uniq'].each {|c| conditions[c.to_sym] = params[c]}
      params.delete('uniq')
      o = klass.find(:first, :conditions => conditions) || klass.new
    else
      o = klass.new
    end
    #o.update_attributes(params)
    params.each do |att, val|
      if att[-3,3].eql?('_id')
        val = att.gsub('_id','').capitalize.constantize.where(eval(val)).first.id
      end
      if att[-4,4].eql?('_ids')
        val = [val] unless val.is_a?(Array)
        vals = []
        val.each {|v| vals << att.gsub('_ids','').capitalize.constantize.where(eval(v)).first.id} 
        val = vals
      end
      if att[-10,10].eql?('_textilize')
        att = att.gsub('_textilize','')
        val = RedCloth.new(val).to_html
      end
      o.send("#{att}=", val)
    end
    o.save 
  end
end

