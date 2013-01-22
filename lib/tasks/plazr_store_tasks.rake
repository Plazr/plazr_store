desc "Add banner to Store"
task :add_banner => :environment do
  c = YAML.load_file("#{Rails.root}/config/config.yml")
  m = PZS::Multimedium.create(:class_type => 'banner', :file => File.open("#{Rails.root}/" << c["banner_path"]))
end
