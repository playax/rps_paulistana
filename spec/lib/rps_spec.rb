require 'spec_helper'

describe NFE::RPS do
    describe "#new" do
        context "passing parameters" do
            it "raises an ArgumentError" do
                expect{NFE::RPS.new "teste"}.to raise_error ArgumentError
            end
        end

        it "instantiate an Header, an Footer and an Array (which will be populated with Details objects)" do
            expect((NFE::RPS.new).header) .to be_an NFE::Header
            expect((NFE::RPS.new).details).to be_an Array
            expect((NFE::RPS.new).footer) .to be_an NFE::Footer
        end
    end

    describe "#add_header" do
        context "with invalid parameter" do
            it "raise InvalidParamError" do
                expect{(NFE::RPS.new).add_header "teste"}.to raise_error NFE::Errors::InvalidParamError
            end
        end

        context "with valid parameter" do
            context "with nonexistent field name" do
                it "raises NonExistentFieldError" do
                    expect{(NFE::RPS.new).add_header({troubles: "whatever"})}.to raise_error NFE::Errors::NonExistentFieldError
                end
            end

            context "with invalid field value" do
                it "raises an Error" do
                    expect{(NFE::RPS.new).add_header({layout_version: "003"})}.to raise_error NFE::Errors::LayoutVersionError
                end
            end

            context "with valid field" do
                it "returns whether the header was added" do
                    expect((NFE::RPS.new).add_header({layout_version: "002", municipal_registration: "12345678", \
                        start_date: "20161220"}).empty?).to be false
                    expect((NFE::RPS.new).add_header({layout_version: "002", municipal_registration: "12345678", \
                        start_date: "20161220", end_date: "20161223"}).empty?).to be false
                end
            end
        end
    end

    describe "#add_detail" do
        context "with invalid parameter" do
            it "raise InvalidParamError" do
                expect{(NFE::RPS.new).add_detail "teste"}.to raise_error NFE::Errors::InvalidParamError
            end
        end

        context "with valid parameter" do
            context "with nonexistent field name" do
                it "raises NonExistentFieldError" do
                    expect{(NFE::RPS.new).add_detail({troubles: "whatever"})}              .to raise_error NFE::Errors::NonExistentFieldError
                    expect{(NFE::RPS.new).add_detail({layout_version: "003"})}             .to raise_error NFE::Errors::NonExistentFieldError
                end
            end

            context "with invalid field value" do
                it "raises an Error" do
                    expect{(NFE::RPS.new).add_detail({rps_type: "003"})}.to raise_error NFE::Errors::RPSTypeError
                    expect{(NFE::RPS.new).add_detail({rps_status: "I"})}.to raise_error NFE::Errors::RPSStatusError
                    expect{(NFE::RPS.new).add_detail({iss_by: "5"})}    .to raise_error NFE::Errors::ISSByError
                    expect{(NFE::RPS.new).add_detail({taker_type: "5"})}.to raise_error NFE::Errors::TakerTypeError
                end
            end

            context "with valid field" do
                it "returns whether the detail was added" do
                    true_hash = {
                        rps_number: "1",
                        amount: "1000",
                        tax_amount: "0",
                        service_code: "12345",
                        aliquot: "0",
                        iss_by: "1",
                        taker_type: "1",
                        taker_document: "43896729837",
                        service_description: "Agenciamento de motoboy realizados através da plataforma 99motos"
                    }
                    false_hash = {
                        rps_number: "2",
                        amount: "10"
                    }
                    # expect((NFE::RPS.new).add_detail(true_hash).empty?) .to be false
                    # expect((NFE::RPS.new).add_detail(false_hash).empty?).to be false
                end
            end
        end
    end

    describe "#set_footer" do
        context "with parameters" do
            it "raises an ArgumentError" do
                expect{(NFE::RPS.new).set_footer({field: "ba"})}.to raise_error ArgumentError
            end
        end

        context "without parameters" do
            it "returns whether the Footer is valid" do
                rps = NFE::RPS.new
                rps.set_footer
                expect(rps.set_footer.empty?).to be false
            end
        end
    end

    describe "#to_s" do

    end
end
