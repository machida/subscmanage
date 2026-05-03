require "application_system_test_case"

class SubscriptionServicesTest < ApplicationSystemTestCase
  setup do
    sign_in users(:thmz)
  end

  test "make new subscription serivce" do
    visit subscription_services_url
    assert_selector "h1", text: "マイサブスク"
    click_on "追加する"

    fill_in "サービス名", with: "Youtube Premium"
    fill_in "次回支払日", with: Date.current
    fill_in "支払間隔", with: "1"
    fill_in "金額", with: "1000"

    click_on "登録する"

    assert_text "サービスが作成されました"
  end

  test "no service name has been entered" do
    visit subscription_services_url
    assert_selector "h1", text: "マイサブスク"
    click_on "追加する"

    fill_in "次回支払日", with: Date.current
    fill_in "支払間隔", with: "1"
    fill_in "金額", with: "1000"

    click_on "登録する"

    assert_text "サービス名を入力してください"
  end

  test "edit subscription service" do
    visit subscription_services_url
    assert_selector "h1", text: "マイサブスク"
    click_on "Youtube Premium"

    assert_text "サービスの編集"

    fill_in "金額", with: "2000"

    click_on "更新する"

    assert_text "サービスが更新されました"
  end

  test "delete subscription service" do
    visit subscription_services_url
    assert_selector "h1", text: "マイサブスク"
    click_on "Youtube Premium"

    assert_text "サービスの編集"

    accept_confirm do
      click_on "削除する"
    end

    assert_text "サービスが削除されました"
  end
end
