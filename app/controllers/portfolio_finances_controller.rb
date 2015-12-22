class PortfolioFinancesController < ApplicationController
  before_action :set_portfolio_finance, only: [:show, :edit, :update, :destroy, :check_share_items]

  # GET /portfolio_finances
  # GET /portfolio_finances.json
  def index
    @portfolio_finances = PortfolioFinance.all
  end

  # GET /portfolio_finances/1
  # GET /portfolio_finances/1.json
  def show
  end

  # GET /portfolio_finances/new
  def new
    @portfolio_finance = PortfolioFinance.new
  end

  # GET /portfolio_finances/1/edit
  def edit
  end

  # POST /portfolio_finances
  # POST /portfolio_finances.json
  def create
    @portfolio_finance = PortfolioFinance.new(portfolio_finance_params)
    @portfolio_finance.user = current_user

    if params[:portfolio_finance][:share_items].present?
      params[:portfolio_finance][:share_items].each do |key, share_item|
        if share_item[:quantity].to_i > 0
          @portfolio_finance.add_share_item(ShareItem.new(:share_id => key, :quantity => share_item[:quantity].to_i))
        end
      end
    end

    respond_to do |format|
      if @portfolio_finance.save
        format.html { redirect_to root_path, notice: 'Portfolio finance was successfully created.' }
        format.json { render :show, status: :created, location: @portfolio_finance }
      else
        format.html { render :new }
        format.json { render json: @portfolio_finance.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /portfolio_finances/1
  # PATCH/PUT /portfolio_finances/1.json
  def update

    if params[:portfolio_finance][:share_items].present?
      ShareItem.where(:portfolio_finance_id => @portfolio_finance.id).destroy_all
      params[:portfolio_finance][:share_items].each do |key, share_item|
        if share_item[:quantity].to_i > 0
          @portfolio_finance.add_share_item(ShareItem.new(:share_id => key, :quantity => share_item[:quantity].to_i))
        end
      end
    end

    respond_to do |format|
      if @portfolio_finance.update(portfolio_finance_params)
        format.html { redirect_to root_path, notice: 'Portfolio finance was successfully updated.' }
        format.json { render :show, status: :ok, location: @portfolio_finance }
      else
        format.html { render :edit }
        format.json { render json: @portfolio_finance.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /portfolio_finances/1
  # DELETE /portfolio_finances/1.json
  def destroy
    @portfolio_finance.destroy
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Portfolio finance was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def check_share_items
    @data_line_chart = @portfolio_finance.historical_quotes Time::now-2.years, Time::now, params['check_share_items'].keys
    respond_to do |format|
      format.js { }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_portfolio_finance
      @portfolio_finance = PortfolioFinance.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def portfolio_finance_params
      params.require(:portfolio_finance).permit(:user_id, :title)
    end
end
