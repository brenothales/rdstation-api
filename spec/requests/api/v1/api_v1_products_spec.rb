require 'rails_helper'

RSpec.describe "Api::V1::Products", type: :request do
  describe "POST /products" do
    context "With Invalid authentication headers" do
      it_behaves_like :deny_without_authorization, :post, "/api/v1/products"
    end

    context "With valid authentication headers" do
      before do
        @user = create(:user)
      end

      context "And with valid params" do
        before do
          @company = create(:company, user: @user)
          @product_attributes = attributes_for(:product)
          post "/api/v1/products", params: {product: @product_attributes, company_id: @company.id}, headers: header_with_authentication(@user)
        end

        it "returns 200" do
          expect_status(200)
        end

        it "product are created with correct data" do
          @product_attributes.each do |field|
            expect(Product.first[field.first]).to eql(field.last)
          end
        end

        it "Returned data is correct" do
          @product_attributes.each do |field|
            expect(json[field.first.to_s]).to eql(field.last)
          end
        end
      end

      context "And with invalid params" do
        before do
          @other_user = create(:user)
        end

        context "valid company" do
          before do
            @company = create(:company, user: @user)
          end

          it "returns 400" do
            post "/api/v1/products", params: {product: {}, company_id: @company.id}, headers: header_with_authentication(@user)
            expect_status(400)
          end
        end

        context "invalid company" do
          it "returns 404" do
            post "/api/v1/products", params: {product: {}}, headers: header_with_authentication(@user)
            expect_status(404)
          end
        end
      end
    end
  end

  describe "PUT /products/:id" do

    context "With Invalid authentication headers" do
      it_behaves_like :deny_without_authorization, :put, "/api/v1/products/0"
    end

    context "With valid authentication headers" do
      before do
        @user = create(:user)
      end

      context "When product exists" do

        context "And user is the products owner" do
          before do
            @company = create(:company, user: @user)
            @product = create(:product, company: @company)
            @product_attributes = attributes_for(:product)
            put "/api/v1/products/#{@product.id}", params: {product: @product_attributes}, headers: header_with_authentication(@user)
          end

          it "returns 200" do
            expect_status(200)
          end

          it "product are updated with correct data" do
            @product.reload
            @product_attributes.each do |field|
              expect(@product[field.first]).to eql(field.last)
            end
          end

          it "Returned data is correct" do
            @product_attributes.each do |field|
              expect(json[field.first.to_s]).to eql(field.last)
            end
          end
        end

        context "And user is not the owner" do
          before do
            @product = create(:product)
            @product_attributes = attributes_for(:product, id: @product.id)
            put "/api/v1/products/#{@product.id}", params: {product: @product_attributes}, headers: header_with_authentication(@user)
          end

          it "returns 403" do
            expect_status(403)
          end
        end
      end

      context "When product dont exists" do
        before do
          @product_attributes = attributes_for(:product)
        end

        it "returns 404" do
          delete "/api/v1/products/0", params: {product: @product_attributes}, headers: header_with_authentication(@user)
          expect_status(404)
        end
      end
    end
  end

  describe "DELETE /products/:id" do
    before do
      @user = create(:user)
    end

    context "With Invalid authentication headers" do
      it_behaves_like :deny_without_authorization, :delete, "/api/v1/products/0"
    end

    context "With valid authentication headers" do

      context "When product exists" do

        context "And user is the owner" do
          before do
            @company = create(:company, user: @user)
            @product = create(:product, company: @company)
            delete "/api/v1/products/#{@product.id}", params: {}, headers: header_with_authentication(@user)
          end

          it "returns 200" do
            expect_status(200)
          end

          it "product are deleted" do
            expect(Product.all.count).to eql(0)
          end
        end

        context "And user is not the owner" do
          before do
            @product = create(:product)
            delete "/api/v1/products/#{@product.id}", params: {}, headers: header_with_authentication(@user)
          end

          it "returns 403" do
            expect_status(403)
          end
        end
      end

      context "When product dont exists" do
        it "returns 404" do
          delete "/api/v1/products/0", params: {}, headers: header_with_authentication(@user)
          expect_status(404)
        end
      end
    end
  end

end
