module CanvasFips
  module CanvasExtensions
    module WebConference
      def presenter_key
        @presenter_key ||= "instructure_" + Digest::SHA256.hexdigest([user_id, self.uuid].join(","))
      end
    end
  end
end
