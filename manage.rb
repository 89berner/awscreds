#!/usr/bin/ruby

require 'json'
require 'pp'

method = ARGV[0]

if method == nil or method == ""
	puts "You must pass a parameter"
	exit
end

if method == "list"
	all = %x[aws dynamodb scan --table-name credentials]
	all_p = JSON.parse(all)['Items']
	puts "USER - PASSWORD"
	all_p.each do |p|
		if p['value'] != nil
			puts p['name']['S'] + " - " + p['value']['S']
		else
			puts p['name']['S'] + " - "
		end
	end
end

if method == "create"
	puts "Insert resource_user name"
	user = STDIN.gets.strip()
	if user == ""
		puts "Quitting"
		exit
	end
	puts "Ingresar password"
	pass = STDIN.gets.strip()
	if pass == ""
		puts "Quitting"
		exit
	end

	puts "I'm going to add #{user} - #{pass} OK? (Y/N)"
	answ = STDIN.gets.strip()
	if answ != "Y"
		puts "Quitting"
		exit
	end

	puts "Creating.."
	puts %x[/opt/create.sh "#{user}" "#{pass}"]
elsif method == "delete"
	puts "Insert resource_user name"
	user = STDIN.gets.strip()
	if user == ""
		puts "Quitting"
		exit
	end
	puts "I'm going to delete #{user} OK? (Y/N)"
	answ = STDIN.gets.strip()
	if answ != "Y"
		puts "Quitting"
		exit
	end
	puts "Deleting.."
	puts %x[/opt/delete.sh "#{user}" ]
end
