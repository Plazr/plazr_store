desc "Add banner and logo to Store"
task :add_banner_and_logo => :environment do
  c = YAML.load_file("#{Rails.root}/config/config.yml")
  # if paths are blank, don't create the entry in the table
  if !c["banner_path"].blank?
    banner = PZS::Multimedium.create(:class_type => 'banner', :file => File.open("#{Rails.root}/" << c["banner_path"]))
  end
  if !c["logo_path"].blank?
    logo = PZS::Multimedium.create(:class_type => 'logo', :file => File.open("#{Rails.root}/" << c["logo_path"]))
  end
end
