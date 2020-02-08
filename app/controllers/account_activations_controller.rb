class AccountActivationsController < ApplicationController
  def edit
    user = User.find_by(email: params[:email])
    #ユーザーが存在する、かつ、有効化されていないユーザー、かつ、有効化トークンによる認証ができる
    #すべての条件を満たす場合
      #有効化ステータスをtrueに更新する
      #有効化時刻を現在時刻で更新する
      #ユーザーをログイン状態にする
      #フラッシュメッセージにsuccessをセットする
      #ユーザー情報ページへリダイレクトする
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.activate
      log_in(user)
      flash[:success] = "Account Activated!"
      redirect_to user
    else
      flash[:danger] = "Invalid activation link"
      redirect_to root_url
    end
  end
end
