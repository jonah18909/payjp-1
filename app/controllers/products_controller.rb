class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy, :pay, :onepay]

  # GET /products
  # GET /products.json
  def index
    @products = Product.all
  end

  # GET /products/1
  # GET /products/1.json
  def show
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # card が登録されていないuser
  def pay
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    # ユーザに紐づいた顧客を取得
    customer = Payjp::Customer.retrieve(current_user.pay.customer)
    # カード情報を登録
    payment = Pay.new(customer: customer.id, user_id: current_user.id)
    customer = Payjp::Customer.retrieve(customer.id)
    customer.cards.create(
      card: params['payjp-token']
    )
    charge = charge_product(customer)
    redirect_to @product, notice: 'ありがとうございました。'
  end

  def onepay
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    customer = Payjp::Customer.retrieve(current_user.pay.customer)
    charge = charge_product(customer)
    redirect_to @product, notice: '支払い完了'
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:name, :price)
    end

    # 登録しているカード情報で支払い
    def charge_product(customer)
      charge = Payjp::Charge.create(
        :amount => @product.price,
        :customer => customer,
        :currency => 'jpy',
      )
    end
end
