# frozen_string_literal: true

module EnginesFiles
  def self.files
    @files ||= ::Rails::Engine.subclasses.each_with_object({}) do |klass, hash|
      paths = Dir.glob("#{klass.instance.root}/app/**/*.{erb,rb}")
      next if paths.empty?

      hash[engine_to_name(klass)] = engine_paths(paths)
    end
  end

  def self.engine_to_name(engine_class)
    if engine_class.respond_to?(:railtie_namespace) && engine_class.railtie_namespace
      engine_class.railtie_namespace.to_s.split("::").map(&:underscore).join("/")
    else
      engine_class.engine_name.sub("_engine", "")
    end
  end

  def self.engine_paths(paths)
    paths.each_with_object({}) do |path, hash|
      _name, *short_path = path.sub(gems_dir, "").split("/")
      hash[short_path.join("/")] = { path: path, fingerprint: fingerprint(path) }
    end
  end

  def self.gems_dir
    @gems_dir ||= "#{Bundler.rubygems.gem_dir}/gems/"
  end

  def self.fingerprint(path)
    Digest::MD5.hexdigest(File.read(path))
  end
end
