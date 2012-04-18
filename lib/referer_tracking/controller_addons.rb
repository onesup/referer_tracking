module RefererTracking::ControllerAddons

  #before_filter :before_filter_referer_tracking_save_to_session

  def before_filter_referer_tracking_save_to_session
    if session[:referer_tracking].nil? && !request_is_from_a_known_bot?
      @referer_tracking_first_request = true
      session[:referer_tracking] = hash = Hash.new
      request_ref = "unknown"
      request_ref = request.headers["HTTP_REFERER"] if !request.headers["HTTP_REFERER"].blank?

      hash[:referer_url] = request_ref
      hash[:first_url] = request.url

      logger.info( "REFERER_TRACKING_FIRST: ver03 (ref|first) ||| #{hash[:referer_url]} ||| #{hash[:first_url]}" )
    end
  end

  ###############################################
  # Session add methods

  # Add only if referer_tracking already in session and key has not been added/changed before
  # So this is only performed on the first time of the session
  def referer_tracking_add_info(key, value)
    if !session[:referer_tracking].nil? && session[:referer_tracking][key.to_sym].nil?
      referer_tracking_set_info(key, value)
    end
  end

  def referer_tracking_set_info(key, value)
    if !session[:referer_tracking].nil?
      session[:referer_tracking][key.to_sym] = value
    end
  end

  def referer_tracking_get_info(key)
    session[:referer_tracking].nil? ? nil : session[:referer_tracking][key.to_sym]
  end

  ###############################################
  # Request add methods

  def referer_tracking_request_add_infos
    @referer_tracking_request_add_infos ||= {}
  end
  private :referer_tracking_request_add_infos

  def referer_tracking_request_set_info(key, value)
    referer_tracking_request_add_infos[key.to_sym] = value
  end

  ###############################################

  def referer_tracking_first_request?
    @referer_tracking_first_request
  end


  def request_is_from_a_known_bot?
    bot_user_agents = /\b(GoogleBot|Mediapartners-Google|msnbot|TwengaBot|DigExt; DTS Agent|YandexImages)\b/i
    request.user_agent =~ bot_user_agents
  end

  def request_is_from_a_possible_bot?
    request.user_agent =~ /bot/i
  end


  def self.included(base)
    base.class_eval do
      before_filter :before_filter_referer_tracking_save_to_session
      helper_method :'referer_tracking_first_request?'
      helper_method :'referer_tracking_add_info'
      helper_method :'referer_tracking_set_info'
      helper_method :'referer_tracking_get_info'
    end
  end

end

