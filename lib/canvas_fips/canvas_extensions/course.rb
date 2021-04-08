module CanvasFips
  module CanvasExtensions
    module Course
      def self_enrollment_codes
        # Don't generate long_self_enrollment_code, based on MD5
        [self_enrollment_code]
      end
    end
  end
end
