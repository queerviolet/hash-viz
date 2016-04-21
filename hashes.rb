#!/usr/bin/env ruby

require 'digest'
require 'zlib'

def sum_hash(str)
	#h = str.bytes.reduce(:+) ^ str.bytes.reduce(:*)
	h = str.bytes.reduce(:+)
	return h if h >= 0
	unsigned(0x1_0000_0000_0000_0000)
end

def crc32_hash(str)
	unsigned(Zlib::crc32(str))
end

def sha256_hash(str)
	sha256 = Digest::SHA256.new
	digest_str = sha256.digest(str)
	result = 0
	digest_str.bytes.each_with_index do |byte, index|
		result += byte << (index * 8)
	end
	unsigned(result)
end

def murmur(str)
	unsigned(str.hash)
end

def unsigned(num)
	num if num >= 0
	num + 0x1_0000_0000_0000_0000
end

def hashes(str)
	{sum: sum_hash(str), crc32: crc32_hash(str), sha256: sha256_hash(str),
		murmur: murmur(str)}
end
