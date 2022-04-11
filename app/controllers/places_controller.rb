class PlacesController < ApplicationController
	def near
		latitude = params[:latitude].to_f
		longitude = params[:longitude].to_f
		
		lat1 = latitude + 0.08
		lon1 = longitude - 0.1

		lat2 = latitude - 0.08
		lon2 = longitude + 0.1
		
		items = get_items(lat1, lon1, lat2, lon2)
		render json: items.values.to_json
	end

	def area
		p1 = params[:p1].split(',')
		p2 = params[:p2].split(',')
		items = get_items(p1[0], p1[1], p2[0], p2[1])
		render json: items.values.to_json
	end

	private

	def get_items(lat1, lon1, lat2, lon2)
		places = Place.where("latitude <= #{lat1} AND longitude >= #{lon1} AND latitude >= #{lat2} AND longitude <= #{lon2}")
		distances = {}
		latitude = params[:latitude].to_f
		longitude = params[:longitude].to_f
		if params[:qty] 
			qty = params[:qty].to_i
		else
			qty = 1000
		end

		places.each do |p|
			# Haversine distance
			lon1 = (longitude/180) * Math::PI  
    		lon2 = (p['longitude']/180) * Math::PI  
    		lat1 = (latitude/180) * Math::PI  
    		lat2 = (p['latitude']/180) * Math::PI  
      
    		dlon = lon2 - lon1
    		dlat = lat2 - lat1
    		a = Math.sin(dlat / 2) ** 2 + Math.cos(lat1) * Math.cos(lat2) * Math.sin(dlon / 2) ** 2
    		d = 2 * Math.asin(Math.sqrt(a)) * 6371

			distances[d] = p
		end

		result = []
		c = 0
		
		sorted = distances.sort.to_h

		items = {}
		sorted.each do |k,v|
			c += 1
			item = {}
			item['name']      = v['name']
			item['latitude']  = v['latitude']
			item['longitude'] = v['longitude']
			item['regular']   = v['last_regular']
			item['premium']   = v['last_premium']
			item['diesel']    = v['last_diesel']
			item['last_update'] = v['date_update']
			item['distance']  = '%.2f' % k
			items[v.id] = item
			break if c >= qty
		end
		return items
	end
end
