# frozen_string_literal: true

#
# Copyright (C) 2021 - present Atomic Jolt, Inc.
#
# This file is part of Canvas.
#
# Canvas is free software: you can redistribute it and/or modify it under
# the terms of the GNU Affero General Public License as published by the Free
# Software Foundation, version 3 of the License.
#
# Canvas is distributed in the hope that it will be useful, but WITHOUT ANY
# WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR
# A PARTICULAR PURPOSE. See the GNU Affero General Public License for more
# details.
#
# You should have received a copy of the GNU Affero General Public License along
# with this program. If not, see <http://www.gnu.org/licenses/>.

require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe CanvasFips::CoreExtensions::Digest::MD5 do
  context "not in log_only mode" do
    before(:each) do
      set_raise_exceptions(true)
    end

    it "should raise exception on MD5 hexdigest" do
      expect { Digest::MD5.hexdigest("test") }.to raise_error(CanvasFips::DigestMD5Called)
    end

    it "should raise exception on MD5.new" do
      expect { Digest::MD5.new }.to raise_error(CanvasFips::DigestMD5Called)
    end
  end

  context "in log_only mode" do
    before(:each) do
      set_raise_exceptions(false)
    end

    it "should warn on MD5 hexdigest when" do
      expect(Rails.logger).to receive(:warn).with(/FIPS/)
      expect(Digest::MD5.hexdigest("test")).to eq("098f6bcd4621d373cade4e832627b4f6")
    end

    it "should warn on MD5 hexdigest.new" do
      expect(Rails.logger).to receive(:warn).with(/FIPS/)
      expect(Digest::MD5.new.hexdigest("test")).to eq("098f6bcd4621d373cade4e832627b4f6")
    end
  end
end
