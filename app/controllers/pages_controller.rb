class PagesController < ApplicationController
	def home
		case get_preffered_language
			when  "ru"
				render "pages/home_langs/ru"
			when  "pl"
				render "pages/home_langs/pl"
			when  "en" 
				render "pages/home_langs/en"
		end
	end

	private

	def get_preffered_language
		rx = /([A-Za-z]{2}(?:-[A-Za-z]{2})?)(?:;q=(1|0?\.[0-9]{1,3}))?/
		langs = request.env['HTTP_ACCEPT_LANGUAGE'].to_s.scan(rx).map do |lang, q| 
			[lang, (q || '1').to_f]
		end	
  		preffered_lang = langs.sort_by(&:last).map(&:first).reverse.first

  		case preffered_lang
  			when "ru-RU"
  				"ru"
  			when "ru"
  				"ru"
  			when "en-US"
  				"en"
  			when "en"
  				"en"
  			when "pl-PL"
  				"pl"
  			when "pl"
  				"pl"
  			when "*"
  				"en"
  			when nil
  				"en"	
  		end	
	end
end
