#!/usr/bin/env ruby

require 'sinatra'
require 'json'

require_relative 'words'
require_relative 'hashes'

set :public_folder, File.dirname(__FILE__)

get '/' do send_file 'index.html' end
get '/points/:count' do
	content_type 'application/json'
	count = params[:count].to_i || 100
	JSON.generate(WORDS.sample(count).map do |word|
		{str: word, hashes: hashes(word)}
	end)
end