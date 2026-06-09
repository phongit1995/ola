package com.facebook.accountkit.ui;

import android.content.Context;
import android.content.Intent;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import android.support.v4.content.LocalBroadcastManager;
import android.text.Html;
import android.view.View;
import android.widget.TextView;
import com.facebook.accountkit.AccountKit;
import com.facebook.accountkit.LoginModel;
import com.facebook.accountkit.R;
import com.facebook.accountkit.internal.AccountKitController;
import com.facebook.accountkit.internal.Utility;
import com.facebook.accountkit.ui.LoginFlowBroadcastReceiver;
import com.facebook.accountkit.ui.PrivacyPolicyFragment;
import com.facebook.accountkit.ui.TitleFragmentFactory;

/* JADX INFO: loaded from: classes.dex */
final class ConfirmAccountVerifiedContentController extends ContentControllerBase implements ButtonContentController {
    private static final ButtonType DEFAULT_BUTTON_TYPE = ButtonType.CONTINUE;
    private static final LoginFlowState LOGIN_FLOW_STATE = LoginFlowState.CONFIRM_ACCOUNT_VERIFIED;
    private PrivacyPolicyFragment bottomFragment;
    private ButtonType buttonType;
    private ContentFragment centerFragment;
    TitleFragmentFactory.TitleFragment footerFragment;
    TitleFragmentFactory.TitleFragment headerFragment;
    private PrivacyPolicyFragment.OnCompleteListener onCompleteListener;
    private ContentFragment textFragment;
    private ContentFragment topFragment;

    public static class BottomFragment extends PrivacyPolicyFragment {
        private static final String ACCOUNT_KIT_URL = "https://www.accountkit.com/faq";

        public static BottomFragment create(@NonNull UIManager uIManager, @NonNull LoginFlowState loginFlowState, @NonNull ButtonType buttonType) {
            BottomFragment bottomFragment = new BottomFragment();
            bottomFragment.getViewState().putParcelable(ViewStateFragment.UI_MANAGER_KEY, uIManager);
            bottomFragment.setLoginFlowState(loginFlowState);
            bottomFragment.setNextButtonType(buttonType);
            return bottomFragment;
        }

        @Override // com.facebook.accountkit.ui.PrivacyPolicyFragment
        protected void updateTermsText(TextView textView, CharSequence charSequence) {
            if (textView == null || getActivity() == null) {
                return;
            }
            LoginModel currentLogInModel = AccountKit.getCurrentLogInModel();
            textView.setText(Html.fromHtml((currentLogInModel == null || Utility.isNullOrEmpty(currentLogInModel.getPrivacyPolicy())) ? getString(R.string.com_accountkit_confirmation_code_agreement_instant_verification, new Object[]{charSequence, "https://m.facebook.com/terms", "https://m.facebook.com/about/privacy/", "https://m.facebook.com/policies/cookies/", ACCOUNT_KIT_URL}) : !Utility.isNullOrEmpty(currentLogInModel.getTermsOfService()) ? getString(R.string.com_accountkit_confirmation_code_agreement_app_privacy_policy_and_terms_instant_verification, new Object[]{charSequence, "https://m.facebook.com/terms", "https://m.facebook.com/about/privacy/", "https://m.facebook.com/policies/cookies/", currentLogInModel.getPrivacyPolicy(), currentLogInModel.getTermsOfService(), AccountKit.getApplicationName(), ACCOUNT_KIT_URL}) : getString(R.string.com_accountkit_confirmation_code_agreement_app_privacy_policy_instant_verification, new Object[]{charSequence, "https://m.facebook.com/terms", "https://m.facebook.com/about/privacy/", "https://m.facebook.com/policies/cookies/", currentLogInModel.getPrivacyPolicy(), AccountKit.getApplicationName(), ACCOUNT_KIT_URL})));
        }
    }

    ConfirmAccountVerifiedContentController(AccountKitConfiguration accountKitConfiguration) {
        super(accountKitConfiguration);
        this.buttonType = DEFAULT_BUTTON_TYPE;
    }

    private PrivacyPolicyFragment.OnCompleteListener getOnCompleteListener() {
        if (this.onCompleteListener == null) {
            this.onCompleteListener = new PrivacyPolicyFragment.OnCompleteListener() { // from class: com.facebook.accountkit.ui.ConfirmAccountVerifiedContentController.1
                @Override // com.facebook.accountkit.ui.PrivacyPolicyFragment.OnCompleteListener
                public void onNext(Context context, String str) {
                    if (ConfirmAccountVerifiedContentController.this.topFragment == null || ConfirmAccountVerifiedContentController.this.bottomFragment == null) {
                        return;
                    }
                    AccountKitController.Logger.logUIConfirmSeamlessLoginInteraction(str);
                    LocalBroadcastManager.getInstance(context).sendBroadcast(new Intent(LoginFlowBroadcastReceiver.ACTION_UPDATE).putExtra(LoginFlowBroadcastReceiver.EXTRA_EVENT, LoginFlowBroadcastReceiver.Event.CONFIRM_SEAMLESS_LOGIN));
                }

                @Override // com.facebook.accountkit.ui.PrivacyPolicyFragment.OnCompleteListener
                public void onRetry(Context context) {
                }
            };
        }
        return this.onCompleteListener;
    }

    private void updateNextButton() {
        if (this.topFragment == null || this.bottomFragment == null) {
            return;
        }
        this.bottomFragment.setNextButtonType(getButtonType());
    }

    @Override // com.facebook.accountkit.ui.ContentController
    public ContentFragment getBottomFragment() {
        if (this.bottomFragment == null) {
            setBottomFragment(BottomFragment.create(this.configuration.getUIManager(), LOGIN_FLOW_STATE, DEFAULT_BUTTON_TYPE));
        }
        return this.bottomFragment;
    }

    @Override // com.facebook.accountkit.ui.ButtonContentController
    public ButtonType getButtonType() {
        return this.buttonType;
    }

    @Override // com.facebook.accountkit.ui.ContentController
    public ContentFragment getCenterFragment() {
        if (this.centerFragment == null) {
            setCenterFragment(StaticContentFragmentFactory.create(this.configuration.getUIManager(), getLoginFlowState()));
        }
        return this.centerFragment;
    }

    @Override // com.facebook.accountkit.ui.ContentController
    @Nullable
    public View getFocusView() {
        return null;
    }

    @Override // com.facebook.accountkit.ui.ContentController
    public TitleFragmentFactory.TitleFragment getFooterFragment() {
        if (this.footerFragment == null) {
            setFooterFragment(TitleFragmentFactory.create(this.configuration.getUIManager()));
        }
        return this.footerFragment;
    }

    @Override // com.facebook.accountkit.ui.ContentController
    public TitleFragmentFactory.TitleFragment getHeaderFragment() {
        if (this.headerFragment == null) {
            setHeaderFragment(TitleFragmentFactory.create(this.configuration.getUIManager(), R.string.com_accountkit_account_verified, new String[0]));
        }
        return this.headerFragment;
    }

    @Override // com.facebook.accountkit.ui.ContentController
    public LoginFlowState getLoginFlowState() {
        return LOGIN_FLOW_STATE;
    }

    @Override // com.facebook.accountkit.ui.ContentController
    public ContentFragment getTextFragment() {
        if (this.textFragment == null) {
            setTextFragment(StaticContentFragmentFactory.create(this.configuration.getUIManager(), getLoginFlowState()));
        }
        return this.textFragment;
    }

    @Override // com.facebook.accountkit.ui.ContentController
    public ContentFragment getTopFragment() {
        if (this.topFragment == null) {
            setTopFragment(StaticContentFragmentFactory.create(this.configuration.getUIManager(), getLoginFlowState()));
        }
        return this.topFragment;
    }

    @Override // com.facebook.accountkit.ui.ContentControllerBase, com.facebook.accountkit.ui.ContentController
    public boolean isTransient() {
        return false;
    }

    @Override // com.facebook.accountkit.ui.ContentControllerBase
    protected void logImpression() {
        if (this.bottomFragment == null) {
            return;
        }
        AccountKitController.Logger.logUIConfirmAccountVerified(true);
    }

    @Override // com.facebook.accountkit.ui.ContentController
    public void setBottomFragment(@Nullable ContentFragment contentFragment) {
        if (contentFragment instanceof BottomFragment) {
            this.bottomFragment = (BottomFragment) contentFragment;
            this.bottomFragment.setOnCompleteListener(getOnCompleteListener());
            this.bottomFragment.setRetryVisible(false);
            updateNextButton();
        }
    }

    @Override // com.facebook.accountkit.ui.ButtonContentController
    public void setButtonType(ButtonType buttonType) {
        this.buttonType = buttonType;
        updateNextButton();
    }

    @Override // com.facebook.accountkit.ui.ContentController
    public void setCenterFragment(@Nullable ContentFragment contentFragment) {
        this.centerFragment = contentFragment;
    }

    @Override // com.facebook.accountkit.ui.ContentController
    public void setFooterFragment(@Nullable TitleFragmentFactory.TitleFragment titleFragment) {
        this.footerFragment = titleFragment;
    }

    @Override // com.facebook.accountkit.ui.ContentController
    public void setHeaderFragment(@Nullable TitleFragmentFactory.TitleFragment titleFragment) {
        this.headerFragment = titleFragment;
    }

    @Override // com.facebook.accountkit.ui.ContentController
    public void setTextFragment(@Nullable ContentFragment contentFragment) {
        this.textFragment = contentFragment;
    }

    @Override // com.facebook.accountkit.ui.ContentController
    public void setTopFragment(@Nullable ContentFragment contentFragment) {
        this.topFragment = contentFragment;
    }
}
