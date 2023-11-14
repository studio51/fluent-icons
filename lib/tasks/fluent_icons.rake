namespace :fluent_icons do
	desc "Download FluentUI System Icons"
	task :download do
		require 'open-uri'

		url = 'https://github.com/microsoft/fluentui-system-icons/archive/refs/heads/main.zip'
		icons_dir = Rails.root.join('vendor', 'fluentui-system-icons')

		FileUtils.mkdir_p(icons_dir)

		open(url) do |file|
			IO.copy_stream(file, File.join(icons_dir, 'icons.zip'))
		end

		system("unzip #{File.join(icons_dir, 'icons.zip')} -d #{icons_dir}")
	end
end