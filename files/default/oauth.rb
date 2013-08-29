#!/usr/bin/env ruby

require 'xmpp4r'

begin

  include Jabber

  jid=JID::new(ARGV[0])
  cl = Client.new(jid)
  cl.connect("talk.google.com")
  cl.auth(ARGV[1])

  puts "Authentication Successful"
  exit 0

rescue Jabber::ClientAuthenticationFailure => e

  puts "Authentication Failure: " + e.message
  exit 1

end