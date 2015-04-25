class ListingsController < ApplicationController
  before_action :set_listing, only: [:show, :edit, :update, :destroy]

  # GET /listings
  # GET /listings.json
  def index
    @listings = Listing.all



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
    @location = params[:location]
    @address = "http://www.wikisherpa.com/api/1/page/en/"+@location
    @voyage_get = RestClient.get(@address)
    @voyage_json = JSON.load @voyage_get
    @level_one = params[:level_one].to_i
    @level_two = params[:level_two].to_i
    @level_three = params[:level_three].to_i
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
