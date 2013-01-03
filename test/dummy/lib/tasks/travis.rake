task :travis do
	["rspec"].each do |cmd|
		puts "Starting to run #{cmd}..."
		system("export DISPLAY=:99 && bundle exec #{cmd}")
		raise "#{cmd} failed! unless $?.exitstatus = 0"
	end
end
