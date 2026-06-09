package com.facebook.accountkit.ui;

import android.annotation.SuppressLint;
import android.content.Context;
import android.os.Bundle;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import android.text.Html;
import android.text.Spanned;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.TextView;
import com.facebook.accountkit.AccountKit;
import com.facebook.accountkit.PhoneLoginModel;
import com.facebook.accountkit.R;
import com.facebook.accountkit.internal.AccountKitController;
import com.facebook.accountkit.internal.Utility;
import com.facebook.accountkit.ui.CustomLinkMovement;
import com.facebook.accountkit.ui.SkinManager;

/* JADX INFO: loaded from: classes.dex */
public class PrivacyPolicyFragment extends ContentFragment {
    protected static final String COOKIE_URL = "https://m.facebook.com/policies/cookies/";
    protected static final String DATA_URL = "https://m.facebook.com/about/privacy/";
    private static final String LOGIN_FLOW_STATE = "login_flow_state";
    private static final String NEXT_BUTTON_TYPE = "next_button_type";
    private static final String RETRY_BUTTON_VISIBLE = "retry button visible";
    private static final String RETRY_KEY = "retry";
    protected static final String TERMS_URL = "https://m.facebook.com/terms";
    private LoginFlowState loginFlowState;
    private Button nextButton;
    private ButtonType nextButtonType;
    private OnCompleteListener onCompleteListener;
    private TextView retryButton;
    private TextView termsText;
    private boolean nextButtonEnabled = true;
    private boolean retryButtonVisible = true;

    public interface OnCompleteListener {
        void onNext(Context context, String str);

        void onRetry(Context context);
    }

    public static PrivacyPolicyFragment create(@NonNull UIManager uIManager, @NonNull LoginFlowState loginFlowState, @NonNull ButtonType buttonType) {
        PrivacyPolicyFragment privacyPolicyFragment = new PrivacyPolicyFragment();
        privacyPolicyFragment.getViewState().putParcelable(ViewStateFragment.UI_MANAGER_KEY, uIManager);
        privacyPolicyFragment.setLoginFlowState(loginFlowState);
        privacyPolicyFragment.setNextButtonType(buttonType);
        return privacyPolicyFragment;
    }

    @SuppressLint({"StringFormatMatches"})
    private Spanned getConfirmationCodeAgreementText(CharSequence charSequence) {
        return Html.fromHtml(getString(R.string.com_accountkit_confirmation_code_agreement, new Object[]{charSequence, TERMS_URL, DATA_URL, COOKIE_URL}));
    }

    @Override // com.facebook.accountkit.ui.LoginFragment
    protected View createView(LayoutInflater layoutInflater, ViewGroup viewGroup, Bundle bundle) {
        ViewGroup viewGroup2 = (ViewGroup) layoutInflater.inflate(R.layout.com_accountkit_fragment_confirmation_code_bottom, viewGroup, false);
        if (ViewUtility.isSkin(getUIManager(), SkinManager.Skin.CONTEMPORARY)) {
            View viewFindViewById = viewGroup2.findViewById(R.id.com_accountkit_next_button);
            ((ViewGroup) viewFindViewById.getParent()).removeView(viewFindViewById);
            View viewFindViewById2 = viewGroup2.findViewById(R.id.com_accountkit_space);
            ((ViewGroup) viewFindViewById2.getParent()).removeView(viewFindViewById2);
            viewGroup2.addView(viewFindViewById2);
            viewGroup2.addView(viewFindViewById);
        }
        return viewGroup2;
    }

    @Override // com.facebook.accountkit.ui.ContentFragment
    public LoginFlowState getLoginFlowState() {
        return this.loginFlowState;
    }

    public boolean getRetry() {
        return getViewState().getBoolean("retry", false);
    }

    @Override // com.facebook.accountkit.ui.ContentFragment
    boolean isKeyboardFragment() {
        return true;
    }

    @Override // com.facebook.accountkit.ui.ViewStateFragment, android.app.Fragment
    public /* bridge */ /* synthetic */ void onActivityCreated(Bundle bundle) {
        super.onActivityCreated(bundle);
    }

    @Override // com.facebook.accountkit.ui.ViewStateFragment, android.app.Fragment
    public /* bridge */ /* synthetic */ void onCreate(Bundle bundle) {
        super.onCreate(bundle);
    }

    @Override // com.facebook.accountkit.ui.LoginFragment, android.app.Fragment
    public /* bridge */ /* synthetic */ View onCreateView(LayoutInflater layoutInflater, ViewGroup viewGroup, Bundle bundle) {
        return super.onCreateView(layoutInflater, viewGroup, bundle);
    }

    @Override // com.facebook.accountkit.ui.ViewStateFragment, android.app.Fragment
    public /* bridge */ /* synthetic */ void onSaveInstanceState(Bundle bundle) {
        super.onSaveInstanceState(bundle);
    }

    @Override // android.app.Fragment
    public void onStart() {
        super.onStart();
        updateTermsText(this.termsText, this.nextButton.getText());
    }

    @Override // com.facebook.accountkit.ui.ViewStateFragment
    protected void onViewReadyWithState(View view, Bundle bundle) {
        super.onViewReadyWithState(view, bundle);
        this.nextButtonType = ButtonType.values()[bundle.getInt(NEXT_BUTTON_TYPE)];
        this.loginFlowState = LoginFlowState.values()[bundle.getInt(LOGIN_FLOW_STATE)];
        this.retryButtonVisible = bundle.getBoolean(RETRY_BUTTON_VISIBLE, true);
        this.nextButton = (Button) view.findViewById(R.id.com_accountkit_next_button);
        this.retryButton = (TextView) view.findViewById(R.id.com_accountkit_retry_button);
        if (this.nextButton != null) {
            this.nextButton.setEnabled(this.nextButtonEnabled);
            this.nextButton.setOnClickListener(new View.OnClickListener() { // from class: com.facebook.accountkit.ui.PrivacyPolicyFragment.1
                @Override // android.view.View.OnClickListener
                public void onClick(View view2) {
                    if (PrivacyPolicyFragment.this.onCompleteListener != null) {
                        PrivacyPolicyFragment.this.onCompleteListener.onNext(view2.getContext(), Buttons.ENTER_CONFIRMATION_CODE.name());
                    }
                }
            });
            this.nextButton.setText(this.nextButtonType.getValue());
        }
        if (this.retryButton != null) {
            this.retryButton.setVisibility(this.retryButtonVisible ? 0 : 8);
            this.retryButton.setOnClickListener(new View.OnClickListener() { // from class: com.facebook.accountkit.ui.PrivacyPolicyFragment.2
                @Override // android.view.View.OnClickListener
                public void onClick(View view2) {
                    AccountKitController.Logger.logUIResendInteraction(Buttons.DID_NOT_GET_CODE.name());
                    if (PrivacyPolicyFragment.this.onCompleteListener != null) {
                        PrivacyPolicyFragment.this.onCompleteListener.onRetry(view2.getContext());
                    }
                }
            });
            this.retryButton.setTextColor(ViewUtility.getButtonColor(getActivity(), getUIManager()));
        }
        this.termsText = (TextView) view.findViewById(R.id.com_accountkit_confirmation_code_agreement);
        if (this.termsText != null) {
            this.termsText.setMovementMethod(new CustomLinkMovement(new CustomLinkMovement.OnURLClickedListener() { // from class: com.facebook.accountkit.ui.PrivacyPolicyFragment.3
                @Override // com.facebook.accountkit.ui.CustomLinkMovement.OnURLClickedListener
                public void onURLClicked(String str) {
                    AccountKitController.Logger.logUIConfirmationCodeInteraction(Buttons.POLICY_LINKS.name(), str);
                }
            }));
        }
        updateTermsText(this.termsText, this.nextButton.getText());
    }

    protected void setLoginFlowState(@NonNull LoginFlowState loginFlowState) {
        this.loginFlowState = loginFlowState;
        getViewState().putInt(LOGIN_FLOW_STATE, loginFlowState.ordinal());
    }

    public void setNextButtonEnabled(boolean z) {
        this.nextButtonEnabled = z;
        if (this.nextButton != null) {
            this.nextButton.setEnabled(z);
        }
    }

    public void setNextButtonType(ButtonType buttonType) {
        this.nextButtonType = buttonType;
        getViewState().putInt(NEXT_BUTTON_TYPE, this.nextButtonType.ordinal());
        if (this.nextButton != null) {
            this.nextButton.setText(buttonType.getValue());
        }
    }

    public void setOnCompleteListener(@Nullable OnCompleteListener onCompleteListener) {
        this.onCompleteListener = onCompleteListener;
    }

    public void setRetry(boolean z) {
        getViewState().putBoolean("retry", z);
    }

    public void setRetryVisible(boolean z) {
        this.retryButtonVisible = z;
        getViewState().putBoolean(RETRY_BUTTON_VISIBLE, this.retryButtonVisible);
        if (this.retryButton != null) {
            this.retryButton.setVisibility(z ? 0 : 8);
        }
    }

    protected void updateTermsText(TextView textView, CharSequence charSequence) {
        Spanned confirmationCodeAgreementText;
        if (textView == null || getActivity() == null) {
            return;
        }
        PhoneLoginModel currentPhoneNumberLogInModel = AccountKit.getCurrentPhoneNumberLogInModel();
        if (currentPhoneNumberLogInModel == null || Utility.isNullOrEmpty(currentPhoneNumberLogInModel.getPrivacyPolicy())) {
            confirmationCodeAgreementText = getConfirmationCodeAgreementText(charSequence);
        } else {
            confirmationCodeAgreementText = Html.fromHtml(!Utility.isNullOrEmpty(currentPhoneNumberLogInModel.getTermsOfService()) ? getString(R.string.com_accountkit_confirmation_code_agreement_app_privacy_policy_and_terms, new Object[]{charSequence, TERMS_URL, DATA_URL, COOKIE_URL, currentPhoneNumberLogInModel.getPrivacyPolicy(), currentPhoneNumberLogInModel.getTermsOfService(), AccountKit.getApplicationName()}) : getString(R.string.com_accountkit_confirmation_code_agreement_app_privacy_policy, new Object[]{charSequence, TERMS_URL, DATA_URL, COOKIE_URL, currentPhoneNumberLogInModel.getPrivacyPolicy(), AccountKit.getApplicationName()}));
        }
        textView.setText(confirmationCodeAgreementText);
    }
}
