require "application_system_test_case"

class ServicePresetsTest < ApplicationSystemTestCase
  setup do
    sign_in users(:kanrisya)
  end

  test "make new service preset" do
    visit admin_root_url
    click_on "プリセットの作成"

    fill_in "サービス名", with: "Test Service"
    fill_in "支払間隔", with: "1"
    fill_in "金額", with: "500"

    click_on "登録する"

    assert_text "Service presetが作成されました"
  end

  test "edit service preset" do
    visit admin_root_url

    click_on "ChatGPT(Plus)"
    assert_text "プリセットの編集"
    fill_in "金額", with: "4000"
    click_on "更新する"

    assert_text "Service presetが更新されました"
  end

  test "delete service preset" do
    visit admin_root_url

    click_on "Youtube Premium"
    assert_text "プリセットの編集"

    accept_confirm do
      click_on "削除する"
    end

    assert_text "Service presetが削除されました"
  end
end
