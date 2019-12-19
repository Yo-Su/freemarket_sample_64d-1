require 'rails_helper'

describe User do
  describe '#create' do

    it "is valid with all" do
      user = build(:user)
      expect(user).to be_valid
    end

    it "is invalid without a nickname" do
      user = build(:user, nick_name: "")
      user.valid?
      expect(user.errors[:nick_name]).to include("can't be blank")
    end

    it "is invalid without a email" do
      user = build(:user, email: "")
      user.valid?
      expect(user.errors[:email]).to include("can't be blank")
    end

    it "is invalid without a password" do
      user = build(:user, password: "")
      user.valid?
      expect(user.errors[:password]).to include("can't be blank")
    end

    it "is invalid without a last_name" do
      user = build(:user, last_name: "")
      user.valid?
      expect(user.errors[:last_name]).to include("can't be blank")
    end

    it "is invalid without a first_name" do
      user = build(:user, first_name: "")
      user.valid?
      expect(user.errors[:first_name]).to include("can't be blank")
    end

    it "is invalid without a last_name_kana" do
      user = build(:user, last_name_kana: "")
      user.valid?
      expect(user.errors[:last_name_kana]).to include("can't be blank")
    end

    it "is invalid without a first_name_kana" do
      user = build(:user, first_name_kana: "")
      user.valid?
      expect(user.errors[:first_name_kana]).to include("can't be blank")
    end

    it "is invalid without a birthday" do
      user = build(:user, birthday: "")
      user.valid?
      expect(user.errors[:birthday]).to include("can't be blank")
    end

    it "is invalid without a phone_number" do
      user = build(:user, phone_number: "")
      user.valid?
      expect(user.errors[:phone_number]).to include("can't be blank")
    end

    it "is invalid with a duplicate email address" do
      user = create(:user)
      another_user = build(:user, email: user.email)
      another_user.valid?
      expect(another_user.errors[:email]).to include("has already been taken")
    end

    it "メールアドレスが正規表現と一致していれば保存できること" do
      user = build(:user)
      expect(user.email).to match(/\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i)
    end

    it "is valid with a password that has more than 7 characters " do
      user = build(:user, password: "0000000")
      user.valid?
      expect(user).to be_valid
    end

    it "is invalid with a password that has less than 5 characters " do
      user = build(:user, password: "00000")
      user.valid?
      expect(user.errors[:password]).to include("is too short (minimum is 6 characters)")
    end

    it "last_nameが正規表現と一致していれば保存できること" do
      user = build(:user)
      expect(user.last_name).to match(/\A[^ -~｡-ﾟ]+\z/)
    end

    it "first_nameが正規表現と一致していれば保存できること" do
      user = build(:user)
      expect(user.first_name).to match(/\A[^ -~｡-ﾟ]+\z/)
    end

    it "last_name_kanaが正規表現と一致していれば保存できること" do
      user = build(:user)
      expect(user.last_name_kana).to match(/\A[\p{katakana} ー－&&[^ -~｡-ﾟ]]+\z/)
    end

    it "first_name_kanaが正規表現と一致していれば保存できること" do
      user = build(:user)
      expect(user.first_name_kana).to match(/\A[\p{katakana} ー－&&[^ -~｡-ﾟ]]+\z/)
    end

  end

end