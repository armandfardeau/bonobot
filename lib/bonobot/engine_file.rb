module Bonobot
  class EngineFile
    attr_reader :path, :engine_name, :short_path, :root_path

    def initialize(path, engine)
      @path = path
      @root_path = engine.instance.root
      @engine_name = engine_to_name(engine)
      @short_path = path.sub("#{@root_path}/", "")
    end

    def fingerprint
      Digest::MD5.hexdigest(File.read(@path))
    end

    def to_hash
      instance_values.merge({ "fingerprint" => fingerprint })
    end

    private

    def engine_to_name(engine_class)
      if engine_class.respond_to?(:railtie_namespace) && engine_class.railtie_namespace
        engine_class.railtie_namespace.to_s.split("::").map(&:underscore).join("/")
      else
        engine_class.engine_name.sub("_engine", "")
      end
    end
  end
end