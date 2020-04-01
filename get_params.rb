#!/usr/bin/env ruby

require 'active_support/time'
require 'securerandom'
require 'jwt'

at_exit() do
  token = generate_token()
  puts "TOKEN : " + token.to_s
  start_time = (Time.now.utc - 15.days).beginning_of_day.iso8601.to_s
  end_time =  (Time.now.utc - 15.days).end_of_day.iso8601.to_s
  puts "START_TIME : " + start_time
  puts "END_TIME : " + end_time
end

def generate_token()
  payload = {
    "iss": 'PROJECT_KEY',
    "iat": Time.now.utc.to_i,
    "exp": Time.now.utc.to_i + 180,
    "ist": "project",
    "jti": SecureRandom.uuid
  }
  JWT.encode payload, 'PROJECT_SECRET', 'HS256'
end
