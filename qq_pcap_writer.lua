local ffi = require "ffi"

ffi.cdef [[
	typedef struct pcap_writer_struct { } pcap_writer_t;
	pcap_writer_t* pcap_writer_create(const char*);
	void pcap_writer_delete(pcap_writer_t*);
	void pcap_writer_store(pcap_writer_t*, const uint64_t, const uint32_t, const uint8_t*);
]]


local qqlib = ffi.load("build/flowscope")

local module = {}

function module.create_pcap_writer(path)
	return qqlib.pcap_writer_create(path)
end

local pcap_writer = {}
pcap_writer.__index = pcap_writer


function pcap_writer:delete()
	qqlib.pcap_writer_delete(self)
end

function pcap_writer:store(timestamp, length, data)
	qqlib.pcap_writer_store(self, timestamp, length, data)
end


ffi.metatype("pcap_writer_t", pcap_writer)

return module
