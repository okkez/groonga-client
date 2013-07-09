# -*- coding: utf-8 -*-
#
# Copyright (C) 2013  Haruka Yoshihara <yoshihara@clear-code.com>
# Copyright (C) 2013  Kouhei Sutou <kou@clear-code.com>
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

require "open-uri"

require "groonga/client/connection/request"

module Groonga
  class Client
    module Connection
      class HTTP
        def initialize(options)
          @host = options[:host] || "127.0.0.1"
          @port = options[:port] || 10041
        end

        def send(command)
          url = "http://#{@host}:#{@port}#{command.to_uri_format}"
          thread = Thread.new do
            open(url) do |response|
              body = response.read
              yield(body)
            end
          end
          Request.new(thread)
        end
      end
    end
  end
end
