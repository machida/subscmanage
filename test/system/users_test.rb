require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase
  test "user registration" do
    visit root_url
    assert_text "サブスク管理"
    within(".hero__actions") do
      click_on "無料で始める"
    end

    fill_in "Eメール", with: "test@sample.com"
    fill_in "Eメール（確認用）", with: "test@sample.com"
    fill_in "パスワード", with: "fhfur@ER4g;l"
    fill_in "パスワード（確認用）", with: "fhfur@ER4g;l"

    click_on "アカウント登録"

    assert_text "アカウント登録が完了しました。"
  end

  test "change mail address" do
    sign_in users(:payment)
    visit root_url

    find(".dropdown-menu-button").click

    within(".dropdown-menu") do
      find("a", text: "登録情報の変更").click
    end

    fill_in "Eメール", with: "test@sample.jp"
    click_on "更新"
    assert_text "アカウント情報を変更しました。"
  end

  test "change password" do
    sign_in users(:payment)
    visit root_url

    find(".dropdown-menu-button").click

    within(".dropdown-menu") do
      find("a", text: "登録情報の変更").click
    end

    click_link "パスワードの変更はこちらから"
    fill_in "現在のパスワード", with: "subsc_test"
    fill_in "パスワード", with: "fhfur@ER4g;l"
    fill_in "パスワード（確認用）", with: "fhfur@ER4g;l"
    click_on "パスワード変更"
    assert_text "パスワードを更新しました"
  end

  test "cancel user" do
    sign_in users(:payment)
    visit root_url

    find(".dropdown-menu-button").click

    within(".dropdown-menu") do
      find("a", text: "登録情報の変更").click
    end

    click_link "退会はこちらから"
    accept_confirm do
      click_on "退会する"
    end
    assert_text "アカウントを削除しました。またのご利用をお待ちしております。"
  end
end
