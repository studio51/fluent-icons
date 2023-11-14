class Cache
	def initialize
		@cache = {}
	end

	def get_fluent_icon(name)
		return @cache[name] if @cache.key?(name)

		@cache = JSON.parse(file)
		@cache[name]
	end

	def file
		binding.pry
		File.read(
			File.join(
				File.dirname(__FILE__), "../lib/build/data.json"
			)
		)
	end
end
