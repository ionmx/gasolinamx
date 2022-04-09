require 'open-uri'
namespace :datosabiertos do
	DATE_ADD = DateTime.now
  PLACES_URL = 'https://bit.ly/2V1Z3sm'
  PRICES_URL = 'https://bit.ly/2JNcTha'
  desc "Import and update data from XML"
  task update: :environment do

	  # IMPORT PLACES
	  places_hash = {}
		xml = URI.open(PLACES_URL)
		data = Hash.from_xml(xml)
		data['places']['place'].each do |p|
			
			if place = Place.find_by_identificator(p["place_id"])
				places_hash[p["place_id"]] = place.id
			else
				puts "Import #{p["name"]}"
				new_place = Place.new
				new_place.identificator = p["place_id"]
				new_place.name = p["name"]
				new_place.cre_identificator = p["cre_id"]
				if p["location"]["y"].to_i.abs <= 90
					new_place.latitude = p["location"]["y"]
				else
					new_place.latitude = 0
				end
				if p["location"]["x"].to_i.abs <= 180
					new_place.longitude = p["location"]["x"]
				else
					new_place.longitude = 0
				end
				new_place.save
				places_hash[p["place_id"]] = new_place.id
			end
		end

		# IMPORT PRICES
		doc = Nokogiri::HTML(URI.open('/Users/ion/Hacking/Personal/gasolinamx/lib/tasks/prices.xml')) 
		prices = {}

		doc.xpath("//place").each do |p|
			prices[p['place_id']] = {} if !prices[p['place_id']]
			p.children.each do |c|
				if c['type'] == 'regular'
					prices[p['place_id']]['regular'] = c.content
				end
				if c['type'] == 'premium'
					prices[p['place_id']]['premium'] = c.content
				end
				if c['type'] == 'diesel'
					prices[p['place_id']]['diesel'] = c.content
				end
			end
		end

		prices.each do |k,v|
			puts "Updating ID:#{places_hash[k]} PLACE:#{k} REGULAR:#{v['regular']} PREMIUM:#{v['premium']} DIESEL:#{v['diesel']}"
			if place = Place.find(places_hash[k].to_i)
				price = place.prices.new
				price.regular = v['regular']
				price.premium = v['premium']
				price.diesel = v['diesel']
				price.date_add = DATE_ADD
				price.save
			end
			
		end

	end
end
