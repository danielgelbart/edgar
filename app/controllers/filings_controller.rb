class FilingsController < ApplicationController
  before_action :set_filing, only: [:show, :edit, :update, :destroy]

  # GET /filings
  # GET /filings.json
  def index
    @filings = Filing.all
  end

  # GET /filings/1
  # GET /filings/1.json
  def show
  end

  # GET /filings/new
  def new
    @filing = Filing.new
  end

  # GET /filings/1/edit
  def edit
  end

  # POST /filings
  # POST /filings.json
  def create
    @filing = Filing.new(filing_params)

    respond_to do |format|
      if @filing.save
        format.html { redirect_to @filing, notice: 'Filing was successfully created.' }
        format.json { render :show, status: :created, location: @filing }
      else
        format.html { render :new }
        format.json { render json: @filing.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /filings/1
  # PATCH/PUT /filings/1.json
  def update
    respond_to do |format|
      if @filing.update(filing_params)
        format.html { redirect_to @filing, notice: 'Filing was successfully updated.' }
        format.json { render :show, status: :ok, location: @filing }
      else
        format.html { render :edit }
        format.json { render json: @filing.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /filings/1
  # DELETE /filings/1.json
  def destroy
    @filing.destroy
    respond_to do |format|
      format.html { redirect_to filings_url, notice: 'Filing was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_filing
      @filing = Filing.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def filing_params
      params.require(:filing).permit(:stock_id, :type, :acn, :year)
    end
end
