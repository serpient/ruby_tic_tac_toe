clearing :on

guard :rspec, cmd: 'bundle exec rspec --color' do
  # watch /lib/ files
  watch(%r{^lib/(.+).rb$}) do |_m|
    "lib/#{m[1]}.rb"
  end

  # watch /spec/ files
  watch(%r{^spec/(.+).rb$}) do |_m|
    "spec/#{m[1]}_spec.rb"
  end
end
