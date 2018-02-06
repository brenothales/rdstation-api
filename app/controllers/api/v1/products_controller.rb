class Api::V1::ProductsController < Api::V1::ApiController
  before_action :authenticate_api_v1_user!
  before_action :set_product, only: [:update, :destroy]
  before_action :set_company
  before_action :allow_only_owner, only: [:create, :update, :destroy]

  def update
    @product.update(product_params)
    render json: @product
  end

  def create
    @product = Product.create(product_params.merge(company: @company))
    render json: @product
  end

  def destroy
    @product.destroy
    render json: {message: 'ok'}
  end

  private

    def set_product
      @product = Product.find(params[:id])
    end

    def set_company
      @company = (@product)? @product.company : Company.find(params[:company_id])
    end

    def allow_only_owner
      unless current_api_v1_user == @company.user
        render(json: {}, status: :forbidden) and return
      end
    end

    def product_params
      params.require(:product).permit(:name, :price)
    end
end
