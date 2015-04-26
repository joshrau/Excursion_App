class ListingsController < ApplicationController
  before_action :set_listing, only: [:show, :edit, :update, :destroy]

  # GET /listings
  # GET /listings.json
  def index
    @listings = Listing.all


    if params[:location] == nil
      @location = "Chiang_Mai"
    else
      @location = params[:location]
    end

     if params[:level_one].to_i == nil
      @level_one = 0 
    else
      @level_one = params[:level_one].to_i
    end

    if params[:level_two].to_i == nil
      @level_two = 0 
    else
      @level_two = params[:level_two].to_i
    end

    if params[:level_three].to_i == nil
      @level_three = 0 
    else
      @level_three = params[:level_three].to_i
    end
    
 
    @address = "http://www.wikisherpa.com/api/1/page/en/"+@location
    @voyage_get = RestClient.get(@address)
    @voyage_json = JSON.load @voyage_get

   # @voyage_json["sections"][@level_one].class ||
   # @voyage_json["sections"][@level_one]["sections"][@level_two].class ||

    if @voyage_json["sections"].class == NilClass
      @listings_one = "No Sections"
    elsif  @voyage_json["sections"][@level_one]["sections"].class == NilClass
      @listings_one = @voyage_json["sections"].count
      @listings_two = "No Sub-sections"
    elsif  @voyage_json["sections"][@level_one]["sections"][@level_two]["listings"].class == NilClass
      @listings_one = @voyage_json["sections"].count
      @listings_two = @voyage_json["sections"][@level_one]["sections"].count
      @listings_three = "No Listings"
    else 
      @listings_one = @voyage_json["sections"].count
      @listings_two = @voyage_json["sections"][@level_one]["sections"].count
      @listings_three = @voyage_json["sections"][@level_one]["sections"][@level_two]["listings"].count
    end

    respond_to do |format|
      format.html
      format.xml { render :json => @listings }
    end
  end

  # GET /listings/1
  # GET /listings/1.json
  def show
  end

  def check

  end

  # GET /listings/new
  def new
    @listing = Listing.new

    if @location != params[:location]
      @location = "Chiang_Mai"
    else
      @location != params[:location]
    end

    @address = "http://www.wikisherpa.com/api/1/page/en/"+@location
    @voyage_get = RestClient.get(@address)
    @voyage_json = JSON.load @voyage_get

    if @level_one != params[:level_one].to_i
      @level_one = 0 
    else
      @level_one = params[:level_one].to_i
    end

    if @level_two != params[:level_two].to_i
      @level_two = 0 
    else
      @level_two = params[:level_two].to_i
    end

    if @level_three != params[:level_three].to_i
      @level_three = 0 
    else
      @level_three = params[:level_three].to_i
    end

    @voyage_sections = @voyage_json["sections"][@level_one]["sections"][@level_two]["listings"][@level_three]
    # @voyage_nested_sections = @voyage_sections["sections"]
   
  end

  # GET /listings/1/edit
  def edit
    @listing = Listing.find(params[:id])
  end

  # POST /listings
  # POST /listings.json
  def create
    @listing = Listing.new(listing_params)

    respond_to do |format|
      if @listing.save
        format.html { redirect_to @listing, notice: 'Listing was successfully created.' }
        format.json { render :show, status: :created, location: @listing }
      else
        format.html { render :new }
        format.json { render json: @listing.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /listings/1
  # PATCH/PUT /listings/1.json
  def update
    respond_to do |format|
      if @listing.update(listing_params)
        format.html { redirect_to @listing, notice: 'Listing was successfully updated.' }
        format.json { render :show, status: :ok, location: @listing }
      else
        format.html { render :edit }
        format.json { render json: @listing.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /listings/1
  # DELETE /listings/1.json
  def destroy
    @listing.destroy
    respond_to do |format|
      format.html { redirect_to listings_url, notice: 'Listing was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_listing
      @listing = Listing.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def listing_params
      params.require(:listing).permit(:address, :alt, :category, :description, :directions, :hours, :lat, :long, :name, :price, :tag, :url, :phone, :email, :fax, :image1, :image2, :image3)
    end
end
