module CanvasFips::CoreExtensions::Digest
  module MD5
    def fips_log_or_raise
      if CanvasFips.settings[:raise_exceptions]
        raise CanvasFips::DigestMD5Called
      end
      Rails.logger.warn("[FIPS] Digest::MD5 called\n" + caller.map { |s| s.prepend "[FIPS] "}.join("\n"))
    end

    def hexdigest(*args)
      fips_log_or_raise
      super
    end

    def new(*args)
      fips_log_or_raise
      super
    end
  end
end

