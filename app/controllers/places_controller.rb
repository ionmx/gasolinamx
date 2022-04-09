class PlacesController < ApplicationController
	def near
		distances = {}
		places = Place.all
		latitude = params[:latitude].to_f
		longitude = params[:longitude].to_f
		if params[:qty] 
			qty = params[:qty].to_i
		else
			qty = 5
		end
		places.each do |p|
			d = Math.sqrt( (latitude - p.latitude) ** 2 + (longitude - p.longitude) ** 2 )
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

			lon1 = (longitude/180) * Math::PI  
    		lon2 = (v['longitude']/180) * Math::PI  
    		lat1 = (latitude/180) * Math::PI  
    		lat2 = (v['latitude']/180) * Math::PI  
      
    		dlon = lon2 - lon1
    		dlat = lat2 - lat1
    		a = Math.sin(dlat / 2) ** 2 + Math.cos(lat1) * Math.cos(lat2) * Math.sin(dlon / 2) ** 2
    		km = 2 * Math.asin(Math.sqrt(a)) * 6371



			item['distance']  = '%.2f' % km
			items[v.id] = item
			break if c >= qty
		end

		prices = Price.where("place_id IN (#{items.keys.join(',')})").where(date_add: Price.maximum('date_add'))

		prices.each do |p|
			items[p.place_id]['regular'] = p.regular
			items[p.place_id]['premium'] = p.premium
			items[p.place_id]['diesel'] = p.diesel
		end


		 
		
		render json: items.values.to_json
	end
end
