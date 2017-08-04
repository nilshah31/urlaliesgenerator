class UrlGeneratorsController < ApplicationController
  def index
    @url_generators = UrlGenerator.all
  end

  def new
    @url_generator = UrlGenerator.new
  end

  def edit
  end

  def create
    # creating Key Pair Value Array to insert multiple record
    exixt = false
    @url_generator = UrlGenerator.new(url_generator_params)
    begin
      url_key = SecureRandom.urlsafe_base64(4, false)
      exixt = check_key_exist(url_key)
    end while exist=false
    hash = { url: params[:url_generator][:url], key: url_key }
    UrlGenerator.new(hash).save
    redirect_to action: 'index'
  end

  def check_key_exist(url_key)
    @url_generators = UrlGenerator.all
    @url_generators.each do |url_generator|
      if url_generator.key == url_key
        return true
      end
    end
    return false
  end

  def redirect_user
    url = get_url_key(params[:id]) 
    if(url)
      redirect_to "http://"+url
    else
      render_404
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_url_generator
      @url_generator = UrlGenerator.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def url_generator_params
      params.require(:url_generator).permit(:url)
    end
    def get_url_key(url_key)
      print("came here")
      @url_generators = UrlGenerator.all
      @url_generators.each do |url_generator|
        if url_generator.key == url_key
          return url_generator.url
        end
      end
      return false
    end
    def render_404
      respond_to do |format|
        format.html { render :file => "#{Rails.root}/public/404", :layout => false, :status => :not_found }
        format.xml  { head :not_found }
        format.any  { head :not_found }
      end
    end
end
