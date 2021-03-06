module AppConfig
  module Storage

    require 'yaml'

    # YAML storage method.
    class YAML < Storage::Base

      DEFAULT_PATH = File.join(Dir.home, '.app_config.yml')

      # Loads `@data` with the YAML file located at `path`.
      # `@data` will be the OpenStruct that is accessed with `AppConfig.some_var`.
      #
      # Defaults to `Dir.home/.app_config.yml`
      def initialize(path = DEFAULT_PATH, options = {})
        # Allows passing `true` as an option.
        path = DEFAULT_PATH if path == true

        # Make sure to use the top-level YAML module here.
        if options.has_key?(:env)
          @data = Storage::ConfigData.new(::YAML.load_file(path)[options[:env]])
        else
          @data = Storage::ConfigData.new(::YAML.load_file(path))
        end
      end

    end # YAML
  end # Storage
end # AppConfig
