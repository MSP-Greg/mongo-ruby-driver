# frozen_string_literal: true
# encoding: utf-8

# Copyright (C) 2020 MongoDB Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

module Mongo
  module Operation
    class CollectionsInfo

      # A MongoDB collectionInfo operation sent as a command message.
      #
      # @api private
      class Command
        include Specifiable
        include Executable
        include ReadPreferenceSupported
        include PolymorphicResult

        private

        def get_result(connection, context, options = {})
          # This is a Mongo::Operation::CollectionsInfo::Result
          Result.new(*dispatch_message(connection, context), db_name)
        end

        def selector(connection)
          {}
        end

        def message(connection)
          Protocol::Query.new(db_name, Database::NAMESPACES, command(connection), options(connection))
        end
      end
    end
  end
end
