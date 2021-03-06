require 'spec_helper'

describe NFE::RPSField do
    describe "#new" do
        context "with no parameters or not only two paremeters" do
            it "raises an ArgumentError" do
                expect{ NFE::RPSField.new }           .to raise_error ArgumentError
            end
        end

        context "with invalid parameter type class" do
            it "raises InvalidParamError" do
                expect{ NFE::RPSField.new 10, String.new }.to raise_error NFE::Errors::InvalidParamError, /Parameter name must be String or Symbol/
                expect{ NFE::RPSField.new String.new, 10 }.to raise_error NFE::Errors::InvalidParamError, /Parameter value must be String/
            end
        end

        context "with empty String parameters" do
            it "raises an InvalidParamError" do
                expect{ NFE::RPSField.new "", "" }        .to raise_error NFE::Errors::InvalidParamError
                expect{ NFE::RPSField.new String.new, "" }.to raise_error NFE::Errors::InvalidParamError
                expect{ NFE::RPSField.new "", String.new }.to raise_error NFE::Errors::InvalidParamError
            end
        end

        context "with valid parameters" do
            it "returns a NFE::RPSField object" do
                expect(NFE::RPSField.new "field", "value").to be_an NFE::RPSField
                expect(NFE::RPSField.new :field, "value") .to be_an NFE::RPSField
                expect(NFE::RPSField.new :field)          .to be_an NFE::RPSField
            end
        end
    end

    describe "#check_value" do
        context "with invalid field value" do
            it "raises an Error" do
                expect{ (NFE::RPSField.new :layout_version, "100").check_value }   .to raise_error NFE::Errors::LayoutVersionError
                expect{ (NFE::RPSField.new :rps_type, "JUL").check_value }         .to raise_error NFE::Errors::RPSTypeError
                expect{ (NFE::RPSField.new :rps_status, "Z").check_value }         .to raise_error NFE::Errors::RPSStatusError
                expect{ (NFE::RPSField.new :iss_by, "0").check_value }             .to raise_error NFE::Errors::ISSByError
                expect{ (NFE::RPSField.new :taker_type, "0").check_value }         .to raise_error NFE::Errors::TakerTypeError
                expect{ (NFE::RPSField.new :start_date, "20162908").check_value }  .to raise_error ArgumentError, /invalid date/
                expect{ (NFE::RPSField.new :end_date, "20162908").check_value }    .to raise_error ArgumentError, /invalid date/
                expect{ (NFE::RPSField.new :issuing_date, "20162908").check_value }.to raise_error ArgumentError, /invalid date/
            end
        end

        context "with valid field value" do
            it "do not raise Error" do
                expect{ (NFE::RPSField.new :layout_version, "001").check_value }   .to_not raise_error
                expect{ (NFE::RPSField.new :rps_type, "RPS").check_value }         .to_not raise_error
                expect{ (NFE::RPSField.new :rps_status, "T").check_value }         .to_not raise_error
                expect{ (NFE::RPSField.new :iss_by, "1").check_value }             .to_not raise_error
                expect{ (NFE::RPSField.new :taker_type, "2").check_value }         .to_not raise_error
                expect{ (NFE::RPSField.new :start_date, "20160108").check_value }  .to_not raise_error
                expect{ (NFE::RPSField.new :end_date, "20160108").check_value }    .to_not raise_error
                expect{ (NFE::RPSField.new :issuing_date, "20160108").check_value }.to_not raise_error
            end
        end
    end

    describe "#valid?" do
        context "with valid field name" do
            it "returns whether a RPSField value is valid" do
                expect((NFE::RPSField.new :uf, "SP").valid?)                                .to be true
                expect((NFE::RPSField.new :iss_by, "2").valid?)                             .to be true
                expect((NFE::RPSField.new :rps_type, "RPS").valid?)                         .to be true
                expect((NFE::RPSField.new :rps_status, "T").valid?)                         .to be true
                expect((NFE::RPSField.new :taker_type, "1").valid?)                         .to be true
                expect((NFE::RPSField.new :aliquot, "0500").valid?)                         .to be true
                expect((NFE::RPSField.new :start_date, "20160101").valid?)                  .to be true
                expect((NFE::RPSField.new :end_date, "20160101").valid?)                    .to be true
                expect((NFE::RPSField.new :city, "SAO PAULO").valid?)                       .to be true
                expect((NFE::RPSField.new :address_type, "AV").valid?)                      .to be true
                expect((NFE::RPSField.new :rps_serial, "12345").valid?)                     .to be true
                expect((NFE::RPSField.new :address_type, "RUA").valid?)                     .to be true
                expect((NFE::RPSField.new :address, "MARANHAO").valid?)                     .to be true
                expect((NFE::RPSField.new :complement, "FUNDOS").valid?)                    .to be true
                expect((NFE::RPSField.new :zip_code, "01225001").valid?)                    .to be true
                expect((NFE::RPSField.new :layout_version, "002").valid?)                   .to be true
                expect((NFE::RPSField.new :address_number, "600").valid?)                   .to be true
                expect((NFE::RPSField.new :service_code, "06157").valid?)                   .to be true
                expect((NFE::RPSField.new :district, "HIGIENOPOLIS").valid?)                .to be true
                expect((NFE::RPSField.new :amount, "000000000050085").valid?)               .to be true
                expect((NFE::RPSField.new :city_ibge_code, "1234567").valid?)               .to be true
                expect((NFE::RPSField.new :rps_number, "000000000001").valid?)              .to be true
                expect((NFE::RPSField.new :tributary_source, "idontknow").valid?)           .to be true
                expect((NFE::RPSField.new :tributary_percentage, "60023").valid?)           .to be true
                expect((NFE::RPSField.new :taker_document, "43896729837").valid?)           .to be true
                expect((NFE::RPSField.new :total_detail_lines, "0000005").valid?)           .to be true
                expect((NFE::RPSField.new :municipal_registration, "48815446").valid?)      .to be true
                expect((NFE::RPSField.new :taker_name, "FERNANDO FARIA DE SOUZA").valid?)   .to be true
                expect((NFE::RPSField.new :taker_email, "julia.birkett@99motos.com").valid?).to be true
                expect((NFE::RPSField.new :service_description, "Agenciamento de motoboy realizados através da plataforma 99motos").valid?).to be true

                expect((NFE::RPSField.new :uf, "SPRJ").valid?)                              .to be false
                expect((NFE::RPSField.new :iss_by, "J").valid?)                             .to be false
                expect((NFE::RPSField.new :rps_type, "ASLKAAA").valid?)                     .to be false
                expect((NFE::RPSField.new :rps_status, "LALA").valid?)                      .to be false
                expect((NFE::RPSField.new :taker_type, "444").valid?)                       .to be false
                expect((NFE::RPSField.new :aliquot, "la").valid?)                           .to be false
                expect((NFE::RPSField.new :start_date, "201601012").valid?)                 .to be false
                expect((NFE::RPSField.new :end_date, "201601012").valid?)                   .to be false
                expect((NFE::RPSField.new :city, "SAO PAULO!").valid?)                      .to be false
                expect((NFE::RPSField.new :address_type, "AVAAA").valid?)                   .to be false
                expect((NFE::RPSField.new :rps_serial, "AKSSDASF").valid?)                  .to be false
                expect((NFE::RPSField.new :address, "MARANHA@@@O").valid?)                  .to be false
                expect((NFE::RPSField.new :complement, "$").valid?)                         .to be false
                expect((NFE::RPSField.new :zip_code, "021225001").valid?)                   .to be false
                expect((NFE::RPSField.new :layout_version, "0s02").valid?)                  .to be false
                expect((NFE::RPSField.new :address_number, "sa600sa600sa600").valid?)       .to be false
                expect((NFE::RPSField.new :service_code, "asdd").valid?)                    .to be false
                expect((NFE::RPSField.new :district, "HIGIENOP@@OLIS").valid?)              .to be false
                expect((NFE::RPSField.new :amount, "000000000050a085").valid?)              .to be false
                expect((NFE::RPSField.new :city_ibge_code, "åsdas").valid?)                 .to be false
                expect((NFE::RPSField.new :rps_number, "000000000@001").valid?)             .to be false
                expect((NFE::RPSField.new :tributary_source, "idontknow!!").valid?)         .to be false
                expect((NFE::RPSField.new :tributary_percentage, "60023232").valid?)        .to be false
                expect((NFE::RPSField.new :taker_document, "438967298371212332").valid?)    .to be false
                expect((NFE::RPSField.new :total_detail_lines, "0000005!").valid?)          .to be false
                expect((NFE::RPSField.new :municipal_registration, "4881aaa5446").valid?)   .to be false
                expect((NFE::RPSField.new :taker_name, "FERNANDO FARIA DE SOUZ!!@A").valid?).to be false
                expect((NFE::RPSField.new :service_description, "!!!! 99motos").valid?)     .to be false
                expect((NFE::RPSField.new :taker_email, "julia.birkett").valid?)            .to be false
            end
        end
    end

    describe "#default_char" do
        it "returns the RPSField default char" do
            field = NFE::RPSField.new :taker_email
            expect(field.default_char).to be_eql " "
            field = NFE::RPSField.new :cei
            expect(field.default_char).to be_eql "0"
            field = NFE::RPSField.new :service_description
            expect(field.default_char).to be_eql " "
        end
    end
end
