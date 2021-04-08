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

describe CanvasFips::CoreExtensions::ActiveRecord::MigrationContext do
  before(:each) do
    set_raise_exceptions(true)
  end

  it "should list migrations without exception" do
    expect {
      ActiveRecord::MigrationContext.new("/canvas/db/migrate", ActiveRecord::SchemaMigration).migrations
    }.not_to raise_error
  end
end
