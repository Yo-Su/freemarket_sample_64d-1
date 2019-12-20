require 'rails_helper'

describe Address do
  describe 'addressモデルのバリデーション' do

    it "is valid with all except a buling, phone_number" do
      address = build(:address)
      expect(address).to be_valid
    end

    it "is invalid without a last_name" do
      address = build(:address, last_name: "")
      address.valid?
      expect(address.errors[:last_name]).to include("can't be blank")
    end

    it "is invalid without a first_name" do
      address = build(:address, first_name: "")
      address.valid?
      expect(address.errors[:first_name]).to include("can't be blank")
    end

    it "is invalid without a last_name_kana" do
      address = build(:address, last_name_kana: "")
      address.valid?
      expect(address.errors[:last_name_kana]).to include("can't be blank")
    end

    it "is invalid without a first_name_kana" do
      address = build(:address, first_name_kana: "")
      address.valid?
      expect(address.errors[:first_name_kana]).to include("can't be blank")
    end

    it "is invalid without a post_number" do
      address = build(:address, post_number: "")
      address.valid?
      expect(address.errors[:post_number]).to include("can't be blank")
    end

    it "is invalid without a prefecture" do
      address = build(:address, prefecture: "")
      address.valid?
      expect(address.errors[:prefecture]).to include("can't be blank")
    end

    it "is invalid without a municipality" do
      address = build(:address, municipality: "")
      address.valid?
      expect(address.errors[:municipality]).to include("can't be blank")
    end

    it "is invalid without a block" do
      address = build(:address, block: "")
      address.valid?
      expect(address.errors[:block]).to include("can't be blank")
    end

    it "last_nameが正規表現と一致していれば保存できること" do
      address = build(:address)
      expect(address.last_name).to match(/\A[^ -~｡-ﾟ]+\z/)
    end

    it "first_nameが正規表現と一致していれば保存できること" do
      address = build(:address)
      expect(address.first_name).to match(/\A[^ -~｡-ﾟ]+\z/)
    end

    it "last_name_kanaが正規表現と一致していれば保存できること" do
      address = build(:address)
      expect(address.last_name_kana).to match(/\A[\p{katakana} ー－&&[^ -~｡-ﾟ]]+\z/)
    end

    it "first_name_kanaが正規表現と一致していれば保存できること" do
      address = build(:address)
      expect(address.first_name_kana).to match(/\A[\p{katakana} ー－&&[^ -~｡-ﾟ]]+\z/)
    end

  end

end