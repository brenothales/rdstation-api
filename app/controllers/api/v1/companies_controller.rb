class Api::V1::CompaniesController < Api::V1::ApiController

    before_action :authenticate_api_v1_user!, except: [:show]
    before_action :set_company, only: [:show, :update, :destroy]
    before_action :allow_only_owner, only: [:update, :destroy]

    def index
        @companies = current_api_v1_user.companies
        render json: @companies.to_json
    end

    def show
        render json: @company, include: 'products'
    end

    def update
        @company.update(company_params)
        render json: @company
    end

    def create
        @company = Company.create(company_params)
        render json: @company
    end

    def destroy
        @company.destroy
        render json: {message: 'ok'}
    end

    private

        def set_company
            @company = Company.friendly.find(params[:id])
        end

        def allow_only_owner
            unless current_api_v1_user == @company.user
                render(json: {}, status: :forbidden) and return
            end
        end

        def company_params
            params.require(:company).permit(:name, :cnpj, :country, :currency, :slug, :description, :enable).merge(user: current_api_v1_user)
        end
end