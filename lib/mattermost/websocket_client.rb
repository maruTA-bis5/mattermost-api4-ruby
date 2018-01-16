require 'faye/websocket'
require 'event_emitter'
require 'json'

module Mattermost
	class WebSocketClient
		include EventEmitter

		def initialize(url, token, option = {})
			@token = token
			@url = url
			@option = option
			@seq_mutex = Mutex.new
			@connected = false
			yield self if block_given?
			connect
			self
		end

		def connect
			return self if connected?
			mm_ws = self
			@em = Thread.new do
				EM.run do
					mm_ws.connect_internal
				end
			end
		end

		def on_open(e)
			emit :open, e
		end

		def on_message(data)
			json = JSON.parse data
			event = json["event"]
			#puts "on_message json:#{json}, event:#{event}"
			seq_up json
			case event
			when "hello"
				@connected = true
			else
				emit event.to_sym, json
			end
			emit :message, json
		end

		def on_close(msg)
			@connected = false
			emit :close, msg
		end

		def on_error(err)
			emit :error, err
		end

		def send_msg(action, data)
			payload = {
				:seq => next_seq,
				:action => action,
				:data => data
			}.to_json
			@client.send payload
		end

		def connected?
			@connected && (@client != nil && @client.ready_state == Faye::WebSocket::API::OPEN)
		end

		def close
			@connected = false
			@client.close if @client != nil
			@client = nil
			Thread.kill @em if @em != nil
			@em = nil
		end

		def connect_internal
			@seq = 0
			mm_ws = self
			@client = Faye::WebSocket::Client.new(@url.gsub(/^http(s?):/, 'ws\1:'), {}, { :headers => {
				'Authorization' => "Bearer #{@token}"
			}})
			@client.on :open do |e|
				mm_ws.on_open e
			end
			@client.on :message do |msg|
				mm_ws.on_message msg.data
			end
			@client.on :close do |e|
				mm_ws.on_close e
			end
			@client.on :error do |e|
				mm_ws.on_error e
			end
		end

		private

		def seq_up(event)
			@seq_mutex.synchronize do
				return if !event.key? "seq"
				new_seq = event["seq"]
				@seq = new_seq if @seq < new_seq
			end
		end

		def next_seq
			@seq_mutex.synchronize do
				@seq = @seq + 1
				@seq
			end
		end

	end
end
