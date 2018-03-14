# Copyright, 2017, by Samuel G. D. Williams. <http://www.codeotaku.com>
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

require 'async/dns'
require 'async/dns/system'

describe Async::DNS::StreamHandler do
	include_context Async::RSpec::Reactor
	
	let(:server) {Async::DNS::Server.new}
	let(:endpoint) {Async::IO::Endpoint.tcp('127.0.0.1', 6666)}
	
	it "can rebind port" do
		2.times do
			task = reactor.async do
				endpoint.bind do |socket|
					described_class.new(server, socket).run
				end
			end
			
			task.stop
		end
	end
end

describe Async::DNS::DatagramHandler do
	include_context Async::RSpec::Reactor
	
	let(:server) {Async::DNS::Server.new}
	let(:endpoint) {Async::IO::Endpoint.udp('127.0.0.1', 6666)}
	
	it "can rebind port" do
		2.times do
			task = reactor.async do
				endpoint.bind do |socket|
					described_class.new(server, socket).run
				end
			end
			
			task.stop
		end
	end
end
