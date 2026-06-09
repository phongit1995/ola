package com.facebook.accountkit.ui;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.content.IntentSender;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.annotation.StringRes;
import android.support.design.widget.TextInputLayout;
import android.support.v4.content.LocalBroadcastManager;
import android.text.Editable;
import android.text.Html;
import android.text.Spanned;
import android.text.TextWatcher;
import android.util.Log;
import android.util.Patterns;
import android.view.KeyEvent;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.AutoCompleteTextView;
import android.widget.Button;
import android.widget.TextView;
import com.facebook.accountkit.AccountKit;
import com.facebook.accountkit.R;
import com.facebook.accountkit.internal.AccountKitController;
import com.facebook.accountkit.internal.InternalLogger;
import com.facebook.accountkit.internal.Utility;
import com.facebook.accountkit.ui.LoginFlowBroadcastReceiver;
import com.facebook.accountkit.ui.SkinManager;
import com.facebook.accountkit.ui.StaticContentFragmentFactory;
import com.facebook.accountkit.ui.TextContentFragment;
import com.facebook.accountkit.ui.TitleFragmentFactory;
import com.google.android.gms.auth.api.Auth;
import com.google.android.gms.auth.api.credentials.Credential;
import com.google.android.gms.auth.api.credentials.HintRequest;
import com.google.android.gms.common.api.GoogleApiClient;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
final class EmailLoginContentController extends ContentControllerBase implements ButtonContentController {
    private static final ButtonType DEFAULT_BUTTON_TYPE = ButtonType.NEXT;
    private static final LoginFlowState LOGIN_FLOW_STATE = LoginFlowState.EMAIL_INPUT;
    private static final int RESOLVE_HINT_REQUEST_CODE = 152;
    private BottomFragment bottomFragment;
    private ButtonType buttonType;
    private StaticContentFragmentFactory.StaticContentFragment centerFragment;
    private TitleFragmentFactory.TitleFragment footerFragment;
    private TitleFragmentFactory.TitleFragment headerFragment;
    private OnCompleteListener onCompleteListener;
    private TextFragment textFragment;

    @Nullable
    private TopFragment topFragment;

    public static final class BottomFragment extends ContentFragment {
        private static final String RETRY_KEY = "retry";
        private Button nextButton;
        private boolean nextButtonEnabled;
        private ButtonType nextButtonType = EmailLoginContentController.DEFAULT_BUTTON_TYPE;
        private OnCompleteListener onCompleteListener;

        private void updateButtonText() {
            if (this.nextButton != null) {
                this.nextButton.setText(getNextButtonTextId());
            }
        }

        @Override // com.facebook.accountkit.ui.LoginFragment
        protected View createView(LayoutInflater layoutInflater, ViewGroup viewGroup, Bundle bundle) {
            View viewInflate = layoutInflater.inflate(R.layout.com_accountkit_fragment_email_login_bottom, viewGroup, false);
            UIManager uIManager = getUIManager();
            if (!(uIManager instanceof SkinManager) || ((SkinManager) uIManager).getSkin() != SkinManager.Skin.CONTEMPORARY) {
                return viewInflate;
            }
            View viewFindViewById = viewInflate.findViewById(R.id.com_accountkit_next_button);
            ((ViewGroup) viewInflate).removeView(viewFindViewById);
            viewFindViewById.setLayoutParams(new ViewGroup.LayoutParams(-1, -2));
            return viewFindViewById;
        }

        @Override // com.facebook.accountkit.ui.ContentFragment
        LoginFlowState getLoginFlowState() {
            return EmailLoginContentController.LOGIN_FLOW_STATE;
        }

        @StringRes
        public int getNextButtonTextId() {
            return getRetry() ? R.string.com_accountkit_resend_email_text : this.nextButtonType.getValue();
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

        @Override // com.facebook.accountkit.ui.ViewStateFragment
        protected void onViewReadyWithState(View view, Bundle bundle) {
            super.onViewReadyWithState(view, bundle);
            this.nextButton = (Button) view.findViewById(R.id.com_accountkit_next_button);
            if (this.nextButton != null) {
                this.nextButton.setEnabled(this.nextButtonEnabled);
                this.nextButton.setOnClickListener(new View.OnClickListener() { // from class: com.facebook.accountkit.ui.EmailLoginContentController.BottomFragment.1
                    @Override // android.view.View.OnClickListener
                    public void onClick(View view2) {
                        if (BottomFragment.this.onCompleteListener != null) {
                            BottomFragment.this.onCompleteListener.onNext(view2.getContext(), Buttons.EMAIL_LOGIN_NEXT.name());
                        }
                    }
                });
            }
            updateButtonText();
        }

        public void setNextButtonEnabled(boolean z) {
            this.nextButtonEnabled = z;
            if (this.nextButton != null) {
                this.nextButton.setEnabled(z);
            }
        }

        public void setNextButtonType(ButtonType buttonType) {
            this.nextButtonType = buttonType;
            updateButtonText();
        }

        public void setOnCompleteListener(@Nullable OnCompleteListener onCompleteListener) {
            this.onCompleteListener = onCompleteListener;
        }

        public void setRetry(boolean z) {
            getViewState().putBoolean("retry", z);
            updateButtonText();
        }
    }

    enum EmailSourceAppSupplied {
        NO_APP_SUPPLIED_EMAIL,
        APP_SUPPLIED_EMAIL_CHANGED,
        APP_SUPPLIED_EMAIL_USED
    }

    enum EmailSourceSelected {
        NO_SELECTABLE_EMAILS,
        SELECTED_CHANGED,
        SELECTED_NOT_USED,
        SELECTED_USED
    }

    public interface OnCompleteListener {
        void onNext(Context context, String str);
    }

    public static final class TextFragment extends TextContentFragment {
        private static final String ACCOUNT_KIT_URL = "https://www.accountkit.com/faq";

        @Override // com.facebook.accountkit.ui.TextContentFragment, com.facebook.accountkit.ui.LoginFragment
        protected View createView(LayoutInflater layoutInflater, ViewGroup viewGroup, Bundle bundle) {
            return layoutInflater.inflate(R.layout.com_accountkit_fragment_email_login_text, viewGroup, false);
        }

        @Override // com.facebook.accountkit.ui.TextContentFragment
        public /* bridge */ /* synthetic */ int getContentPaddingBottom() {
            return super.getContentPaddingBottom();
        }

        @Override // com.facebook.accountkit.ui.TextContentFragment
        public /* bridge */ /* synthetic */ int getContentPaddingTop() {
            return super.getContentPaddingTop();
        }

        @Override // com.facebook.accountkit.ui.ContentFragment
        LoginFlowState getLoginFlowState() {
            return EmailLoginContentController.LOGIN_FLOW_STATE;
        }

        @Override // com.facebook.accountkit.ui.TextContentFragment
        protected Spanned getText(String str) {
            return Html.fromHtml(getString(R.string.com_accountkit_email_login_text, new Object[]{str, AccountKit.getApplicationName(), ACCOUNT_KIT_URL}));
        }

        @Override // com.facebook.accountkit.ui.ContentFragment
        boolean isKeyboardFragment() {
            return false;
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

        @Override // com.facebook.accountkit.ui.TextContentFragment, android.app.Fragment
        public /* bridge */ /* synthetic */ void onStart() {
            super.onStart();
        }

        @Override // com.facebook.accountkit.ui.TextContentFragment
        public /* bridge */ /* synthetic */ void setContentPaddingBottom(int i) {
            super.setContentPaddingBottom(i);
        }

        @Override // com.facebook.accountkit.ui.TextContentFragment
        public /* bridge */ /* synthetic */ void setContentPaddingTop(int i) {
            super.setContentPaddingTop(i);
        }

        @Override // com.facebook.accountkit.ui.TextContentFragment
        public /* bridge */ /* synthetic */ void setNextButtonTextProvider(TextContentFragment.NextButtonTextProvider nextButtonTextProvider) {
            super.setNextButtonTextProvider(nextButtonTextProvider);
        }
    }

    public static final class TopFragment extends ContentFragment {
        private static final String APP_SUPPLIED_EMAIL_KEY = "appSuppliedEmail";
        private static final String SELECTED_EMAIL_KEY = "selectedEmail";
        private AutoCompleteTextView emailView;
        private TextInputLayout emailViewLayout;
        private OnCompleteListener onCompleteListener;
        private OnEmailChangedListener onEmailChangedListener;

        public interface OnEmailChangedListener {
            void onEmailChanged();
        }

        private void fillEmail() {
            GoogleApiClient googleApiClient;
            Activity activity = getActivity();
            List<String> deviceEmailsIfAvailable = Utility.getDeviceEmailsIfAvailable(activity.getApplicationContext());
            if (deviceEmailsIfAvailable != null) {
                this.emailView.setAdapter(new ArrayAdapter(activity, android.R.layout.simple_dropdown_item_1line, deviceEmailsIfAvailable));
                this.emailView.setOnItemClickListener(new AdapterView.OnItemClickListener() { // from class: com.facebook.accountkit.ui.EmailLoginContentController.TopFragment.3
                    @Override // android.widget.AdapterView.OnItemClickListener
                    public void onItemClick(AdapterView<?> adapterView, View view, int i, long j) {
                        TopFragment.this.setSelectedEmail(TopFragment.this.emailView.getText().toString());
                    }
                });
            }
            String appSuppliedEmail = getAppSuppliedEmail();
            if (!Utility.isNullOrEmpty(appSuppliedEmail)) {
                this.emailView.setText(appSuppliedEmail);
                this.emailView.setSelection(appSuppliedEmail.length());
            } else if (Utility.hasGooglePlayServices(getActivity()) && (googleApiClient = getGoogleApiClient()) != null && getCurrentState() == EmailLoginContentController.LOGIN_FLOW_STATE && Utility.isNullOrEmpty(getEmail())) {
                try {
                    getActivity().startIntentSenderForResult(Auth.CredentialsApi.getHintPickerIntent(googleApiClient, new HintRequest.Builder().setEmailAddressIdentifierSupported(true).build()).getIntentSender(), EmailLoginContentController.RESOLVE_HINT_REQUEST_CODE, null, 0, 0, 0);
                } catch (IntentSender.SendIntentException e) {
                    Log.w(TAG, "Failed to send intent", e);
                }
            }
        }

        @Override // com.facebook.accountkit.ui.LoginFragment
        protected View createView(LayoutInflater layoutInflater, ViewGroup viewGroup, Bundle bundle) {
            return layoutInflater.inflate(R.layout.com_accountkit_fragment_email_login_top, viewGroup, false);
        }

        public String getAppSuppliedEmail() {
            return getViewState().getString(APP_SUPPLIED_EMAIL_KEY);
        }

        @Nullable
        public String getEmail() {
            if (this.emailView == null) {
                return null;
            }
            return this.emailView.getText().toString();
        }

        @Override // com.facebook.accountkit.ui.ContentFragment
        LoginFlowState getLoginFlowState() {
            return EmailLoginContentController.LOGIN_FLOW_STATE;
        }

        public String getSelectedEmail() {
            return getViewState().getString(SELECTED_EMAIL_KEY);
        }

        @Override // com.facebook.accountkit.ui.ContentFragment
        boolean isKeyboardFragment() {
            return false;
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
            fillEmail();
        }

        @Override // com.facebook.accountkit.ui.ViewStateFragment
        protected void onViewReadyWithState(View view, Bundle bundle) {
            super.onViewReadyWithState(view, bundle);
            this.emailView = (AutoCompleteTextView) view.findViewById(R.id.com_accountkit_email);
            this.emailViewLayout = (TextInputLayout) view.findViewById(R.id.com_accountkit_email_layout);
            if (this.emailView != null) {
                this.emailView.addTextChangedListener(new TextWatcher() { // from class: com.facebook.accountkit.ui.EmailLoginContentController.TopFragment.1
                    @Override // android.text.TextWatcher
                    public void afterTextChanged(Editable editable) {
                        if (TopFragment.this.onEmailChangedListener != null) {
                            TopFragment.this.onEmailChangedListener.onEmailChanged();
                        }
                    }

                    @Override // android.text.TextWatcher
                    public void beforeTextChanged(CharSequence charSequence, int i, int i2, int i3) {
                    }

                    @Override // android.text.TextWatcher
                    public void onTextChanged(CharSequence charSequence, int i, int i2, int i3) {
                    }
                });
                this.emailView.setOnEditorActionListener(new TextView.OnEditorActionListener() { // from class: com.facebook.accountkit.ui.EmailLoginContentController.TopFragment.2
                    @Override // android.widget.TextView.OnEditorActionListener
                    public boolean onEditorAction(TextView textView, int i, KeyEvent keyEvent) {
                        if (i != 5 || Utility.isNullOrEmpty(TopFragment.this.getEmail())) {
                            return false;
                        }
                        if (TopFragment.this.onCompleteListener == null) {
                            return true;
                        }
                        TopFragment.this.onCompleteListener.onNext(textView.getContext(), Buttons.EMAIL_LOGIN_NEXT_KEYBOARD.name());
                        return true;
                    }
                });
                this.emailView.setInputType(33);
            }
        }

        public void setAppSuppliedEmail(String str) {
            getViewState().putString(APP_SUPPLIED_EMAIL_KEY, str);
        }

        public void setOnCompleteListener(@Nullable OnCompleteListener onCompleteListener) {
            this.onCompleteListener = onCompleteListener;
        }

        public void setOnEmailChangedListener(@Nullable OnEmailChangedListener onEmailChangedListener) {
            this.onEmailChangedListener = onEmailChangedListener;
        }

        public void setRequestedHintEmail(String str) {
            this.emailView.setText(str);
            this.emailView.setSelection(str.length());
        }

        public void setSelectedEmail(String str) {
            getViewState().putString(SELECTED_EMAIL_KEY, str);
        }
    }

    EmailLoginContentController(AccountKitConfiguration accountKitConfiguration) {
        super(accountKitConfiguration);
        this.buttonType = DEFAULT_BUTTON_TYPE;
        AccountKitController.initializeLogin();
    }

    static EmailSourceAppSupplied getEmailAppSuppliedSource(String str, String str2) {
        return !Utility.isNullOrEmpty(str) ? str.equals(str2) ? EmailSourceAppSupplied.APP_SUPPLIED_EMAIL_USED : EmailSourceAppSupplied.APP_SUPPLIED_EMAIL_CHANGED : EmailSourceAppSupplied.NO_APP_SUPPLIED_EMAIL;
    }

    static EmailSourceSelected getEmailSourceSelected(String str, String str2, List<String> list) {
        return !Utility.isNullOrEmpty(str) ? str.equals(str2) ? EmailSourceSelected.SELECTED_USED : EmailSourceSelected.SELECTED_CHANGED : (list == null || list.isEmpty()) ? EmailSourceSelected.NO_SELECTABLE_EMAILS : EmailSourceSelected.SELECTED_NOT_USED;
    }

    private OnCompleteListener getOnCompleteListener() {
        if (this.onCompleteListener == null) {
            this.onCompleteListener = new OnCompleteListener() { // from class: com.facebook.accountkit.ui.EmailLoginContentController.3
                @Override // com.facebook.accountkit.ui.EmailLoginContentController.OnCompleteListener
                public void onNext(Context context, String str) {
                    String email;
                    if (EmailLoginContentController.this.topFragment == null || (email = EmailLoginContentController.this.topFragment.getEmail()) == null) {
                        return;
                    }
                    String strTrim = email.trim();
                    if (Patterns.EMAIL_ADDRESS.matcher(strTrim).matches()) {
                        if (EmailLoginContentController.this.topFragment.emailViewLayout != null) {
                            EmailLoginContentController.this.topFragment.emailViewLayout.setError(null);
                        }
                        AccountKitController.Logger.logUIEmailLoginInteraction(str, EmailLoginContentController.getEmailAppSuppliedSource(EmailLoginContentController.this.topFragment.getAppSuppliedEmail(), strTrim).name(), EmailLoginContentController.getEmailSourceSelected(EmailLoginContentController.this.topFragment.getSelectedEmail(), strTrim, Utility.getDeviceEmailsIfAvailable(EmailLoginContentController.this.topFragment.getActivity().getApplicationContext())).name(), strTrim);
                        LocalBroadcastManager.getInstance(context).sendBroadcast(new Intent(LoginFlowBroadcastReceiver.ACTION_UPDATE).putExtra(LoginFlowBroadcastReceiver.EXTRA_EVENT, LoginFlowBroadcastReceiver.Event.EMAIL_LOGIN_COMPLETE).putExtra(LoginFlowBroadcastReceiver.EXTRA_EMAIL, strTrim));
                        return;
                    }
                    if (EmailLoginContentController.this.headerFragment != null) {
                        EmailLoginContentController.this.headerFragment.setTitleResourceId(R.string.com_accountkit_email_invalid, new String[0]);
                    }
                    if (EmailLoginContentController.this.topFragment.emailViewLayout != null) {
                        EmailLoginContentController.this.topFragment.emailViewLayout.setError(context.getText(R.string.com_accountkit_email_invalid));
                    }
                }
            };
        }
        return this.onCompleteListener;
    }

    private static void logEmailAutofill(String str) {
        Bundle bundle = new Bundle();
        bundle.putString(InternalLogger.EVENT_PARAM_EXTRAS_AUTOFILL_EMAIL_METHOD, str);
        AccountKitController.Logger.logEvent(InternalLogger.EVENT_NAME_EMAIL_AUTOFILLED, bundle);
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void updateNextButton() {
        if (this.topFragment == null || this.bottomFragment == null) {
            return;
        }
        this.bottomFragment.setNextButtonEnabled(!Utility.isNullOrEmpty(this.topFragment.getEmail()));
        this.bottomFragment.setNextButtonType(getButtonType());
    }

    @Override // com.facebook.accountkit.ui.ContentController
    public ContentFragment getBottomFragment() {
        if (this.bottomFragment == null) {
            setBottomFragment(new BottomFragment());
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
            setCenterFragment(StaticContentFragmentFactory.create(this.configuration.getUIManager(), getLoginFlowState(), R.layout.com_accountkit_fragment_email_login_center));
        }
        return this.centerFragment;
    }

    @Override // com.facebook.accountkit.ui.ContentController
    @Nullable
    public View getFocusView() {
        if (this.topFragment == null) {
            return null;
        }
        return this.topFragment.emailView;
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
            this.headerFragment = TitleFragmentFactory.create(this.configuration.getUIManager(), R.string.com_accountkit_email_login_title, new String[0]);
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
            setTextFragment(new TextFragment());
        }
        return this.textFragment;
    }

    @Override // com.facebook.accountkit.ui.ContentController
    @Nullable
    public ContentFragment getTopFragment() {
        if (this.topFragment == null) {
            setTopFragment(new TopFragment());
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
        AccountKitController.Logger.logUIEmailLoginShown(this.bottomFragment.getRetry());
    }

    @Override // com.facebook.accountkit.ui.ContentControllerBase, com.facebook.accountkit.ui.ContentController
    public void onActivityResult(int i, int i2, Intent intent) {
        Credential credential;
        super.onActivityResult(i, i2, intent);
        if (i != RESOLVE_HINT_REQUEST_CODE || i2 != -1 || (credential = (Credential) intent.getParcelableExtra(Credential.EXTRA_KEY)) == null || this.topFragment == null) {
            return;
        }
        this.topFragment.setRequestedHintEmail(credential.getId());
        logEmailAutofill(InternalLogger.EVENT_AUTOFILL_EMAIL_BY_GOOGLE);
    }

    @Override // com.facebook.accountkit.ui.ContentControllerBase, com.facebook.accountkit.ui.ContentController
    public void onResume(Activity activity) {
        super.onResume(activity);
        ViewUtility.showKeyboard(getFocusView());
    }

    @Override // com.facebook.accountkit.ui.ContentController
    public void setBottomFragment(@Nullable ContentFragment contentFragment) {
        if (contentFragment instanceof BottomFragment) {
            this.bottomFragment = (BottomFragment) contentFragment;
            this.bottomFragment.getViewState().putParcelable(ViewStateFragment.UI_MANAGER_KEY, this.configuration.getUIManager());
            this.bottomFragment.setOnCompleteListener(getOnCompleteListener());
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
        if (contentFragment instanceof StaticContentFragmentFactory.StaticContentFragment) {
            this.centerFragment = (StaticContentFragmentFactory.StaticContentFragment) contentFragment;
        }
    }

    @Override // com.facebook.accountkit.ui.ContentController
    public void setFooterFragment(@Nullable TitleFragmentFactory.TitleFragment titleFragment) {
        this.footerFragment = titleFragment;
    }

    @Override // com.facebook.accountkit.ui.ContentController
    public void setHeaderFragment(@Nullable TitleFragmentFactory.TitleFragment titleFragment) {
        this.headerFragment = titleFragment;
    }

    void setRetry() {
        if (this.headerFragment != null) {
            this.headerFragment.setTitleResourceId(R.string.com_accountkit_email_login_retry_title, new String[0]);
        }
        if (this.bottomFragment != null) {
            this.bottomFragment.setRetry(true);
        }
        if (this.textFragment != null) {
            this.textFragment.updateText();
        }
    }

    @Override // com.facebook.accountkit.ui.ContentController
    public void setTextFragment(@Nullable ContentFragment contentFragment) {
        if (contentFragment instanceof TextFragment) {
            this.textFragment = (TextFragment) contentFragment;
            this.textFragment.getViewState().putParcelable(ViewStateFragment.UI_MANAGER_KEY, this.configuration.getUIManager());
            this.textFragment.setNextButtonTextProvider(new TextContentFragment.NextButtonTextProvider() { // from class: com.facebook.accountkit.ui.EmailLoginContentController.1
                @Override // com.facebook.accountkit.ui.TextContentFragment.NextButtonTextProvider
                public String getNextButtonText() {
                    if (EmailLoginContentController.this.bottomFragment == null) {
                        return null;
                    }
                    return EmailLoginContentController.this.textFragment.getResources().getText(EmailLoginContentController.this.bottomFragment.getNextButtonTextId()).toString();
                }
            });
        }
    }

    @Override // com.facebook.accountkit.ui.ContentController
    public void setTopFragment(@Nullable ContentFragment contentFragment) {
        if (contentFragment instanceof TopFragment) {
            this.topFragment = (TopFragment) contentFragment;
            this.topFragment.getViewState().putParcelable(ViewStateFragment.UI_MANAGER_KEY, this.configuration.getUIManager());
            this.topFragment.setOnEmailChangedListener(new TopFragment.OnEmailChangedListener() { // from class: com.facebook.accountkit.ui.EmailLoginContentController.2
                @Override // com.facebook.accountkit.ui.EmailLoginContentController.TopFragment.OnEmailChangedListener
                public void onEmailChanged() {
                    EmailLoginContentController.this.updateNextButton();
                }
            });
            this.topFragment.setOnCompleteListener(getOnCompleteListener());
            if (this.configuration != null && this.configuration.getInitialEmail() != null) {
                this.topFragment.setAppSuppliedEmail(this.configuration.getInitialEmail());
            }
            updateNextButton();
        }
    }
}
