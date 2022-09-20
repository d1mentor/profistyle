module ApplicationHelper
    def get_lang
		if params[:lang] == nil || params[:lang] == ""
			get_preffered_language
		else 
		    params[:lang]
		end		
	end

    def current_path
        current_uri = request.env['PATH_INFO']
    end    
	
	def admin_panel_path_check(route)
		if route.include?("admin_panel")
			true
		else
			false
		end		
	end	

    private
	#Метод автоопределния предпочтиемого языка пользователя
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
