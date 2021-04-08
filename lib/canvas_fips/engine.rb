# Copyright (C) 2021 Atomic Jolt

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.

# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

module CanvasFips
  NAME = "Canvas FIPS".freeze
  DISPLAY_NAME = "Patches for FIPS compliance".freeze
  DESCRIPTION = "Patches for FIPS compliance".freeze

  def self.settings
    @settings ||= {}
  end

  def self.settings=(value)
    @settings = value
  end


  class Railtie < ::Rails::Engine
    config.autoload_paths << File.expand_path(File.join(__FILE__, "../.."))

    initializer "canvas_fips.canvas_plugin" do
      settings = {
        :raise_exceptions => nil,
      }.merge((ConfigFile.load("fips").dup || {}).symbolize_keys)
      CanvasFips.settings = settings

      Rails.logger.debug("[FIPS] Applying patches...")
      Rails.application.config.active_support.use_sha1_digests = true

      Digest::MD5.extend CoreExtensions::Digest::MD5
      Course.prepend CanvasExtensions::Course
      WebConference.prepend CanvasExtensions::WebConference

      # Switchman uses a module prepend to cache the migration context using MD5 as key. Replace their call with ours.
      #
      # This is replacing memoization code (all of the real functionality is provided by ActiveRecord directly)
      # so this should be pretty safe to override with our code.
      if defined?(Switchman::ActiveRecord::MigrationContext)
        ActiveRecord::MigrationContext.prepend CoreExtensions::ActiveRecord::MigrationContext
        Switchman::ActiveRecord::MigrationContext.remove_method(:migrations)
      end
    end

    config.to_prepare do
      Canvas::Plugin.register(
        :canvas_fips,
        nil,
        name: -> { I18n.t(:canvas_fips_name, NAME) },
        display_name: -> { I18n.t :canvas_fips_display, DISPLAY_NAME },
        author: "Atomic Jolt",
        author_website: "http://www.atomicjolt.com/",
        description: -> { t(:description, DESCRIPTION) },
        version: CanvasFips::VERSION,
      )
    end
  end

  class FipsException < StandardError; end
  class DigestMD5Called < FipsException; end
end
