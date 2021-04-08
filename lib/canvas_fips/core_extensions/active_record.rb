module CanvasFips::CoreExtensions::ActiveRecord
  module MigrationContext
    def migrations
      return @migrations if instance_variable_defined?(:@migrations)
      migrations_cache = Thread.current[:migrations_cache] ||= {}
      key = Digest::SHA256.hexdigest(migration_files.sort.join(','))
      @migrations = migrations_cache[key] ||= super
    end
  end
end
