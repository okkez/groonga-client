# Copyright (C) 2016  Kouhei Sutou <kou@clear-code.com>
#
# This library is free software; you can redistribute it and/or
# modify it under the terms of the GNU Lesser General Public
# License as published by the Free Software Foundation; either
# version 2.1 of the License, or (at your option) any later version.
#
# This library is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# Lesser General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public
# License along with this library; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA

require "groonga/client/error"

module Groonga
  class Client
    module Request
      class Error < Client::Error
      end

      class ErrorResponse < Error
        attr_reader :response
        def initialize(response)
          @response = response
          command = @response.command
          status_code = @response.status_code
          error_message = @response.error_message
          message = "failed to execute: "
          message << "#{command.command_name}: #{status_code}: "
          message << "<#{error_message}>: "
          message << command.to_command_format
          super(message)
        end
      end
    end
  end
end
