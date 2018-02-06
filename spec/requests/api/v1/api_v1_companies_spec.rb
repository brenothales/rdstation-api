require 'rails_helper'

RSpec.describe "Api::V1::Company", type: :request do
  describe "GET /companies" do
    context "With Invalid authentication headers" do
      it_behaves_like :deny_without_authorization, :get, "/api/v1/companies"
    end

    context "With Valid authentication headers" do
      before do
        @user = create(:user)
        @company1 = create(:company, user: @user)
        @company2 = create(:company, user: @user)

        get "/api/v1/companies", params: {}, headers: header_with_authentication(@user)
      end

      it "returns 200" do
        expect_status(200)
      end

      it "returns Company list with 2 companies" do
        expect(json.count).to eql(2)
      end

      it "returned Company have right datas" do
        expect(json[0]).to eql(JSON.parse(@company1.to_json))
        expect(json[1]).to eql(JSON.parse(@company2.to_json))
      end
    end
  end

  describe "GET /companies/:friendly_id" do
    before do
      @user = create(:user)
    end

    context "When company exists" do

      context "And is enable" do
        before do
          @company = create(:company, user: @user, enable: true)
          @product1 = create(:product, company: @company)
          @product2 = create(:product, company: @company)
          get "/api/v1/companies/#{@company.friendly_id}", params: {}, headers: header_with_authentication(@user)
        end
        it "returns 200" do
            expect_status(200)
        end

        it "returned Company with right datas" do
            expect(json.except('products')).to eql(JSON.parse(@company.to_json))
        end

        it "returned associated products" do
            expect(json['products'][0]).to eql(JSON.parse(@product1.to_json))
            expect(json['products'][1]).to eql(JSON.parse(@product2.to_json))
        end
      end

      context "And is unable" do
        before do
          @company = create(:company, user: @user, enable: false)
        end

        it "returns 404" do
          get "/api/v1/companies/#{FFaker::Lorem.word}", params: {id: @company.friendly_id}, headers: header_with_authentication(@user)
          expect_status(404)
        end
      end
    end

    context "When company dont exists" do
      it "returns 404" do
        get "/api/v1/companies/#{FFaker::Lorem.word}", params: {}, headers: header_with_authentication(@user)
        expect_status(404)
      end
    end
  end

  describe "POST /companies" do
    context "With Invalid authentication headers" do
      it_behaves_like :deny_without_authorization, :post, "/api/v1/companies"
    end

    context "With valid authentication headers" do
      before do
        @user = create(:user)
      end

      context "And with valid params" do
        before do
          @company_attributes = attributes_for(:company)
          post "/api/v1/companies", params: {company: @company_attributes}, headers: header_with_authentication(@user)
        end

        it "returns 200" do
          expect_status(200)
        end

        it "company are created with correct data" do
          @company_attributes.each do |field|
            expect(Company.first[field.first]).to eql(field.last)
          end
        end

        it "Returned data is correct" do
          @company_attributes.each do |field|
            expect(json[field.first.to_s]).to eql(field.last)
          end
        end
      end
    end
  end

  describe "PUT /companies/:friendly_id" do
    context "With Invalid authentication headers" do
      it_behaves_like :deny_without_authorization, :put, "/api/v1/companies/productary"
    end

    context "With valid authentication headers" do
      before do
        @user = create(:user)
      end

      context "When company exists" do

        context "And user is the owner" do
          before do
            @company = create(:company, user: @user)
            @company_attributes = attributes_for(:company, id: @company.id)
            put "/api/v1/companies/#{@company.friendly_id}", params: {company: @company_attributes}, headers: header_with_authentication(@user)
          end

          it "returns 200" do
            expect_status(200)
          end

          it "company are updated with correct data" do
            @company.reload
            @company_attributes.each do |field|
              expect(@company[field.first]).to eql(field.last)
            end
          end

          it "Returned data is correct" do
            @company_attributes.each do |field|
              expect(json[field.first.to_s]).to eql(field.last)
            end
          end
        end

        context "And user is not the owner" do
          before do
            @company = create(:company)
            @company_attributes = attributes_for(:company, id: @company.id)
            put "/api/v1/companies/#{@company.friendly_id}", params: {company: @company_attributes}, headers: header_with_authentication(@user)
          end

          it "returns 403" do
            expect_status(403)
          end
        end
      end

      context "When company dont exists" do
        before do
          @company_attributes = attributes_for(:company)
        end

        it "returns 404" do
          put "/api/v1/companies/#{FFaker::Lorem.word}", params: {company: @company_attributes}, headers: header_with_authentication(@user)
          expect_status(404)
        end
      end
    end
  end

  describe "DELETE /companies/:friendly_id" do

    before do
      @user = create(:user)
    end

    context "With Invalid authentication headers" do
      it_behaves_like :deny_without_authorization, :delete, "/api/v1/companies/productary"
    end

    context "With valid authentication headers" do
      context "When company exists" do
        context "And user is the owner" do
          before do
            @company = create(:company, user: @user)
            @product = create(:product, company: @company)
            delete "/api/v1/companies/#{@company.friendly_id}", params: {}, headers: header_with_authentication(@user)
          end

          it "returns 200" do
            expect_status(200)
          end

          it "company are deleted" do
              expect(Company.all.count).to eql(0)
          end

          it "associated product are deleted" do
            expect(Question.all.count).to eql(0)
          end
        end

        context "And user is not the owner" do
          before do
            @company = create(:company)
            delete "/api/v1/companies/#{@company.friendly_id}", params: {}, headers: header_with_authentication(@user)
          end

          it "returns 403" do
            expect_status(403)
          end
        end
      end

      context "When company dont exists" do
        it "returns 404" do
          delete "/api/v1/companies/#{FFaker::Lorem.word}", params: {}, headers: header_with_authentication(@user)
          expect_status(404)
        end
      end

      context "When company exists" do

        context "And user is the owner" do
          before do
            @company = create(:company, user: @user)
            delete "/api/v1/companies/#{@company.friendly_id}", params: {}, headers: header_with_authentication(@user)
          end

          it "returns 200" do
            expect_status(200)
          end

          it "company are deleted" do
            expect(Company.all.count).to eql(0)
          end
        end

        context "And user is not the owner" do
          before do
            @company = create(:company)
            delete "/api/v1/companies/#{@company.friendly_id}", params: {}, headers: header_with_authentication(@user)
          end

          it "returns 403" do
            expect_status(403)
          end
        end
      end

      context "When company dont exists" do
        it "returns 404" do
          delete "/api/v1/companies/#{FFaker::Lorem.word}", params: {}, headers: header_with_authentication(@user)
          expect_status(404)
        end
      end
    end
  end

end

