require 'websocket-client-simple'
require 'event_emitter'
require 'json'

module Mattermost
	class WebSocketClient
		include EventEmitter

		def initialize(url, token, option = {})
			@token = token
			@url = url
			@seq_mutex = Mutex.new
			@seq = 0
			@connected = false
			mm_ws = self
			@client = WebSocket::Client::Simple.connect(url, option) do |ws|
				ws.on :open do
					mm_ws.on_open
				end
				ws.on :message do |msg|
					mm_ws.on_message msg.data
				end
				ws.on :close do |e|
					mm_ws.on_close e
				end
				ws.on :error do |e|
					mm_ws.on_error e
				end
			end
			yield self if block_given?
		end

		def on_open
			emit :open
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
				emit :message, json
			end
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
			@connected && @client.connected?
		end

		def close
			@client.close
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
