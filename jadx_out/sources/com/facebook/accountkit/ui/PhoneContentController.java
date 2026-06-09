package com.facebook.accountkit.ui;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.content.IntentSender;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.annotation.StringRes;
import android.text.Editable;
import android.text.Html;
import android.text.Spanned;
import android.text.TextUtils;
import android.view.KeyEvent;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.EditText;
import android.widget.SpinnerAdapter;
import android.widget.TextView;
import com.facebook.accountkit.PhoneNumber;
import com.facebook.accountkit.R;
import com.facebook.accountkit.internal.AccountKitController;
import com.facebook.accountkit.internal.InternalLogger;
import com.facebook.accountkit.internal.Utility;
import com.facebook.accountkit.ui.AccountKitSpinner;
import com.facebook.accountkit.ui.PhoneCountryCodeAdapter;
import com.facebook.accountkit.ui.SkinManager;
import com.facebook.accountkit.ui.StaticContentFragmentFactory;
import com.facebook.accountkit.ui.TextContentFragment;
import com.facebook.accountkit.ui.TitleFragmentFactory;
import com.google.android.gms.auth.api.Auth;
import com.google.android.gms.auth.api.credentials.Credential;
import com.google.android.gms.auth.api.credentials.HintRequest;
import com.google.android.gms.common.api.GoogleApiClient;
import com.google.i18n.phonenumbers.NumberParseException;
import com.google.i18n.phonenumbers.PhoneNumberUtil;
import com.google.i18n.phonenumbers.Phonenumber;

/* JADX INFO: loaded from: classes.dex */
abstract class PhoneContentController extends ContentControllerBase implements ButtonContentController {
    private static final String COUNTRY_PHONE_PREFIX = "+";
    private static final int RESOLVE_HINT_REQUEST_CODE = 152;

    @Nullable
    BottomFragment bottomFragment;
    private ButtonType buttonType;
    private StaticContentFragmentFactory.StaticContentFragment centerFragment;
    private TitleFragmentFactory.TitleFragment footerFragment;

    @Nullable
    TitleFragmentFactory.TitleFragment headerFragment;
    OnCompleteListener onCompleteListener;

    @Nullable
    TextFragment textFragment;

    @Nullable
    TopFragment topFragment;
    private static final LoginFlowState LOGIN_FLOW_STATE = LoginFlowState.PHONE_NUMBER_INPUT;
    private static final ButtonType DEFAULT_BUTTON_TYPE = ButtonType.NEXT;

    public static final class BottomFragment extends ContentFragment {
        private static final String RETRY_KEY = "retry";

        @Nullable
        private Button nextButton;
        private boolean nextButtonEnabled;
        private ButtonType nextButtonType = PhoneContentController.DEFAULT_BUTTON_TYPE;

        @Nullable
        private OnCompleteListener onCompleteListener;

        private void updateButtonText() {
            if (this.nextButton != null) {
                this.nextButton.setText(getNextButtonTextId());
            }
        }

        @Override // com.facebook.accountkit.ui.LoginFragment
        protected View createView(LayoutInflater layoutInflater, ViewGroup viewGroup, Bundle bundle) {
            View viewInflate = layoutInflater.inflate(R.layout.com_accountkit_fragment_phone_login_bottom, viewGroup, false);
            if (!ViewUtility.isSkin(getUIManager(), SkinManager.Skin.CONTEMPORARY)) {
                return viewInflate;
            }
            View viewFindViewById = viewInflate.findViewById(R.id.com_accountkit_next_button);
            ((ViewGroup) viewInflate).removeView(viewFindViewById);
            viewFindViewById.setLayoutParams(new ViewGroup.LayoutParams(-1, -2));
            return viewFindViewById;
        }

        @Override // com.facebook.accountkit.ui.ContentFragment
        LoginFlowState getLoginFlowState() {
            return PhoneContentController.LOGIN_FLOW_STATE;
        }

        @StringRes
        public int getNextButtonTextId() {
            return getRetry() ? R.string.com_accountkit_button_resend_sms : this.nextButtonType.getValue();
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
                this.nextButton.setOnClickListener(new View.OnClickListener() { // from class: com.facebook.accountkit.ui.PhoneContentController.BottomFragment.1
                    @Override // android.view.View.OnClickListener
                    public void onClick(View view2) {
                        if (BottomFragment.this.onCompleteListener != null) {
                            BottomFragment.this.onCompleteListener.onNext(view2.getContext(), Buttons.PHONE_LOGIN_NEXT.name());
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

    interface OnCompleteListener {
        void onNext(Context context, String str);
    }

    enum PhoneNumberSource {
        UNKNOWN,
        APP_SUPPLIED_PHONE_NUMBER,
        APP_SUPPLIED_AND_DEVICE_PHONE_NUMBER,
        DEVICE_PHONE_NUMBER,
        DEVICE_PHONE_NUMBER_AND_APP_NUMBER_NOT_SUPPLIED,
        DEVICE_PHONE_NUMBER_NOT_SUPPLIED
    }

    public static final class TextFragment extends TextContentFragment {
        private static final String ACCOUNT_KIT_URL = "https://www.accountkit.com/faq";

        @Override // com.facebook.accountkit.ui.TextContentFragment, com.facebook.accountkit.ui.LoginFragment
        protected View createView(LayoutInflater layoutInflater, ViewGroup viewGroup, Bundle bundle) {
            return layoutInflater.inflate(R.layout.com_accountkit_fragment_phone_login_text, viewGroup, false);
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
            return PhoneContentController.LOGIN_FLOW_STATE;
        }

        @Override // com.facebook.accountkit.ui.TextContentFragment
        protected Spanned getText(String str) {
            return Html.fromHtml(getString(R.string.com_accountkit_phone_login_text, new Object[]{str, ACCOUNT_KIT_URL}));
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
        private static final String APP_SUPPLIED_PHONE_NUMBER_KEY = "appSuppliedPhoneNumber";
        private static final String DEFAULT_COUNTRY_CODE_NUMBER = "defaultCountryCodeNumber";
        private static final String DEVICE_PHONE_NUMBER_KEY = "devicePhoneNumber";
        private static final String INITIAL_COUNTRY_CODE_VALUE_KEY = "initialCountryCodeValue";
        private static final String LAST_PHONE_NUMBER = "lastPhoneNumber";
        private static final String READ_PHONE_STATE_ENABLED = "readPhoneStateEnabled";
        private static final String SMS_BLACKLIST_KEY = "smsBlacklist";
        private static final String SMS_WHITELIST_KEY = "smsWhitelist";
        private PhoneCountryCodeAdapter countryCodeAdapter;

        @Nullable
        private AccountKitSpinner countryCodeView;
        private boolean isPhoneNumberValid;

        @Nullable
        private OnCompleteListener onCompleteListener;

        @Nullable
        private OnPhoneNumberChangedListener onPhoneNumberChangedListener;

        @Nullable
        private EditText phoneNumberView;

        interface OnPhoneNumberChangedListener {
            void onPhoneNumberChanged();
        }

        @Nullable
        private String attemptToDiscoverPhoneNumber(Activity activity) {
            if (this.countryCodeView == null || !isReadPhoneStateEnabled()) {
                return null;
            }
            String phoneNumberIfAvailable = Utility.readPhoneNumberIfAvailable(activity.getApplicationContext());
            if (phoneNumberIfAvailable == null) {
                requestPhoneNumberFromGooglePlay(activity);
                return phoneNumberIfAvailable;
            }
            PhoneContentController.logPhoneNumberAutofill(InternalLogger.EVENT_AUTOFILL_NUMBER_BY_DEVICE);
            return phoneNumberIfAvailable;
        }

        @Nullable
        private PhoneNumber determinePhoneNumberForDisplay(Activity activity) {
            if (getLastPhoneNumber() != null) {
                return getLastPhoneNumber();
            }
            if (getAppSuppliedPhoneNumber() != null) {
                return getAppSuppliedPhoneNumber();
            }
            PhoneNumber phoneNumberCreatePhoneNumber = getDevicePhoneNumber() != null ? Utility.createPhoneNumber(getDevicePhoneNumber()) : null;
            return phoneNumberCreatePhoneNumber == null ? Utility.createPhoneNumber(attemptToDiscoverPhoneNumber(activity)) : phoneNumberCreatePhoneNumber;
        }

        private PhoneNumber getLastPhoneNumber() {
            return (PhoneNumber) getViewState().getParcelable(LAST_PHONE_NUMBER);
        }

        /* JADX INFO: Access modifiers changed from: private */
        public static String getPhoneNumberWithPrefix(String str) {
            return PhoneContentController.COUNTRY_PHONE_PREFIX + str;
        }

        private void requestPhoneNumberFromGooglePlay(Activity activity) {
            GoogleApiClient googleApiClient;
            if (getLastPhoneNumber() == null && Utility.hasGooglePlayServices(activity) && (googleApiClient = getGoogleApiClient()) != null) {
                try {
                    activity.startIntentSenderForResult(Auth.CredentialsApi.getHintPickerIntent(googleApiClient, new HintRequest.Builder().setPhoneNumberIdentifierSupported(true).build()).getIntentSender(), PhoneContentController.RESOLVE_HINT_REQUEST_CODE, null, 0, 0, 0);
                } catch (IntentSender.SendIntentException unused) {
                }
            }
        }

        /* JADX INFO: Access modifiers changed from: private */
        public void setAppSuppliedPhoneNumber(@Nullable PhoneNumber phoneNumber) {
            getViewState().putParcelable(APP_SUPPLIED_PHONE_NUMBER_KEY, phoneNumber);
        }

        /* JADX INFO: Access modifiers changed from: private */
        public void setDefaultCountryCodeValue(@Nullable String str) {
            getViewState().putString(DEFAULT_COUNTRY_CODE_NUMBER, str);
        }

        private void setDevicePhoneNumber(@Nullable String str) {
            getViewState().putString(DEVICE_PHONE_NUMBER_KEY, str);
        }

        private void setInitialCountryCodeValue(@Nullable PhoneCountryCodeAdapter.ValueData valueData) {
            getViewState().putParcelable(INITIAL_COUNTRY_CODE_VALUE_KEY, valueData);
        }

        private void setPhoneNumberText(@Nullable PhoneNumber phoneNumber) {
            EditText editText;
            String phoneNumberWithPrefix;
            if (this.phoneNumberView == null || this.countryCodeView == null) {
                return;
            }
            if (phoneNumber != null) {
                this.phoneNumberView.setText(phoneNumber.toString());
                updateFlag(phoneNumber.getCountryCode());
            } else {
                if (getInitialCountryCodeValue() != null) {
                    editText = this.phoneNumberView;
                    phoneNumberWithPrefix = getPhoneNumberWithPrefix(this.countryCodeAdapter.getItem(getInitialCountryCodeValue().position).countryCode);
                } else {
                    editText = this.phoneNumberView;
                    phoneNumberWithPrefix = "";
                }
                editText.setText(phoneNumberWithPrefix);
            }
            this.phoneNumberView.setSelection(this.phoneNumberView.getText().length());
        }

        /* JADX INFO: Access modifiers changed from: private */
        public void setSmsBlacklist(@Nullable String[] strArr) {
            getViewState().putStringArray(SMS_BLACKLIST_KEY, strArr);
        }

        /* JADX INFO: Access modifiers changed from: private */
        public void setSmsWhitelist(@Nullable String[] strArr) {
            getViewState().putStringArray(SMS_WHITELIST_KEY, strArr);
        }

        /* JADX INFO: Access modifiers changed from: private */
        public void updateFlag(String str) {
            if (this.phoneNumberView == null || this.countryCodeView == null) {
                return;
            }
            PhoneCountryCodeAdapter.ValueData valueData = (PhoneCountryCodeAdapter.ValueData) this.countryCodeView.getSelectedItem();
            int indexOfCountryCode = this.countryCodeAdapter.getIndexOfCountryCode(Utility.getCountryCode(str));
            if (indexOfCountryCode <= 0 || valueData.position == indexOfCountryCode) {
                return;
            }
            this.countryCodeView.setSelection(indexOfCountryCode, true);
        }

        @Override // com.facebook.accountkit.ui.LoginFragment
        protected View createView(LayoutInflater layoutInflater, ViewGroup viewGroup, Bundle bundle) {
            return layoutInflater.inflate(R.layout.com_accountkit_fragment_phone_login_top, viewGroup, false);
        }

        @Nullable
        public PhoneNumber getAppSuppliedPhoneNumber() {
            return (PhoneNumber) getViewState().getParcelable(APP_SUPPLIED_PHONE_NUMBER_KEY);
        }

        @Nullable
        public String getDefaultCountryCodeValue() {
            return getViewState().getString(DEFAULT_COUNTRY_CODE_NUMBER);
        }

        @Nullable
        public String getDevicePhoneNumber() {
            return getViewState().getString(DEVICE_PHONE_NUMBER_KEY);
        }

        @Nullable
        public PhoneCountryCodeAdapter.ValueData getInitialCountryCodeValue() {
            return (PhoneCountryCodeAdapter.ValueData) getViewState().getParcelable(INITIAL_COUNTRY_CODE_VALUE_KEY);
        }

        @Override // com.facebook.accountkit.ui.ContentFragment
        LoginFlowState getLoginFlowState() {
            return PhoneContentController.LOGIN_FLOW_STATE;
        }

        @Nullable
        public PhoneNumber getPhoneNumber() {
            if (this.phoneNumberView == null) {
                return null;
            }
            try {
                Phonenumber.PhoneNumber phoneNumber = PhoneNumberUtil.getInstance().parse(this.phoneNumberView.getText().toString(), "US");
                return new PhoneNumber(String.valueOf(phoneNumber.getCountryCode()), String.valueOf(phoneNumber.getNationalNumber()), phoneNumber.getCountryCodeSource().name());
            } catch (NumberParseException | IllegalArgumentException unused) {
                return null;
            }
        }

        @Nullable
        public String[] getSmsBlacklist() {
            return getViewState().getStringArray(SMS_BLACKLIST_KEY);
        }

        @Nullable
        public String[] getSmsWhitelist() {
            return getViewState().getStringArray(SMS_WHITELIST_KEY);
        }

        @Override // com.facebook.accountkit.ui.ContentFragment
        boolean isKeyboardFragment() {
            return false;
        }

        public boolean isPhoneNumberValid() {
            return this.isPhoneNumberValid;
        }

        public boolean isReadPhoneStateEnabled() {
            return getViewState().getBoolean(READ_PHONE_STATE_ENABLED);
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
            this.countryCodeView = (AccountKitSpinner) view.findViewById(R.id.com_accountkit_country_code);
            this.phoneNumberView = (EditText) view.findViewById(R.id.com_accountkit_phone_number);
            final Activity activity = getActivity();
            final EditText editText = this.phoneNumberView;
            final AccountKitSpinner accountKitSpinner = this.countryCodeView;
            if (activity == null || editText == null || accountKitSpinner == null) {
                return;
            }
            this.countryCodeAdapter = new PhoneCountryCodeAdapter(activity, getUIManager(), getSmsBlacklist(), getSmsWhitelist());
            accountKitSpinner.setAdapter((SpinnerAdapter) this.countryCodeAdapter);
            PhoneNumber phoneNumberDeterminePhoneNumberForDisplay = determinePhoneNumberForDisplay(activity);
            PhoneCountryCodeAdapter.ValueData initialValue = this.countryCodeAdapter.getInitialValue(phoneNumberDeterminePhoneNumberForDisplay, getDefaultCountryCodeValue());
            setInitialCountryCodeValue(initialValue);
            accountKitSpinner.setSelection(initialValue.position);
            accountKitSpinner.setOnSpinnerEventsListener(new AccountKitSpinner.OnSpinnerEventsListener() { // from class: com.facebook.accountkit.ui.PhoneContentController.TopFragment.1
                @Override // com.facebook.accountkit.ui.AccountKitSpinner.OnSpinnerEventsListener
                public void onSpinnerClosed() {
                    AccountKitController.Logger.logUICountryCode(false, ((PhoneCountryCodeAdapter.ValueData) accountKitSpinner.getSelectedItem()).countryCode);
                    TopFragment.this.setLastPhoneNumber(TopFragment.this.getPhoneNumber());
                    editText.setText(TopFragment.getPhoneNumberWithPrefix(((PhoneCountryCodeAdapter.ValueData) accountKitSpinner.getSelectedItem()).countryCode));
                    editText.setSelection(editText.getText().length());
                    ViewUtility.showKeyboard(editText);
                }

                @Override // com.facebook.accountkit.ui.AccountKitSpinner.OnSpinnerEventsListener
                public void onSpinnerOpened() {
                    AccountKitController.Logger.logUICountryCode(true, ((PhoneCountryCodeAdapter.ValueData) accountKitSpinner.getSelectedItem()).countryCode);
                    ViewUtility.hideKeyboard(activity);
                }
            });
            editText.addTextChangedListener(new PhoneNumberTextWatcher(initialValue.countryCode) { // from class: com.facebook.accountkit.ui.PhoneContentController.TopFragment.2
                @Override // com.facebook.accountkit.ui.PhoneNumberTextWatcher, android.text.TextWatcher
                public void afterTextChanged(Editable editable) {
                    super.afterTextChanged(editable);
                    String string = editable.toString();
                    boolean z = false;
                    if (TextUtils.isEmpty(string) || !string.startsWith(PhoneContentController.COUNTRY_PHONE_PREFIX)) {
                        TopFragment.this.isPhoneNumberValid = false;
                        accountKitSpinner.performClick();
                        return;
                    }
                    Phonenumber.PhoneNumber phoneNumberCreateI8nPhoneNumber = Utility.createI8nPhoneNumber(editable.toString());
                    TopFragment topFragment = TopFragment.this;
                    if (phoneNumberCreateI8nPhoneNumber != null && PhoneNumberUtil.getInstance().isValidNumber(phoneNumberCreateI8nPhoneNumber)) {
                        z = true;
                    }
                    topFragment.isPhoneNumberValid = z;
                    if (TopFragment.this.onPhoneNumberChangedListener != null) {
                        TopFragment.this.onPhoneNumberChangedListener.onPhoneNumberChanged();
                    }
                    TopFragment.this.setLastPhoneNumber(TopFragment.this.getPhoneNumber());
                    TopFragment.this.updateFlag(string);
                }
            });
            editText.setOnEditorActionListener(new TextView.OnEditorActionListener() { // from class: com.facebook.accountkit.ui.PhoneContentController.TopFragment.3
                @Override // android.widget.TextView.OnEditorActionListener
                public boolean onEditorAction(TextView textView, int i, KeyEvent keyEvent) {
                    if (i != 5 || !TopFragment.this.isPhoneNumberValid) {
                        return false;
                    }
                    if (TopFragment.this.onCompleteListener == null) {
                        return true;
                    }
                    TopFragment.this.onCompleteListener.onNext(textView.getContext(), Buttons.PHONE_LOGIN_NEXT_KEYBOARD.name());
                    return true;
                }
            });
            editText.setRawInputType(18);
            ViewUtility.showKeyboard(editText);
            setPhoneNumberText(phoneNumberDeterminePhoneNumberForDisplay);
        }

        public void setLastPhoneNumber(PhoneNumber phoneNumber) {
            getViewState().putParcelable(LAST_PHONE_NUMBER, phoneNumber);
        }

        public void setOnCompleteListener(@Nullable OnCompleteListener onCompleteListener) {
            this.onCompleteListener = onCompleteListener;
        }

        public void setOnPhoneNumberChangedListener(@Nullable OnPhoneNumberChangedListener onPhoneNumberChangedListener) {
            this.onPhoneNumberChangedListener = onPhoneNumberChangedListener;
        }

        public void setReadPhoneStateEnabled(boolean z) {
            getViewState().putBoolean(READ_PHONE_STATE_ENABLED, z);
        }

        void setRequestedPhoneNumber(String str) {
            if (Utility.createI8nPhoneNumber(str) != null) {
                PhoneContentController.logPhoneNumberAutofill(InternalLogger.EVENT_AUTOFILL_NUMBER_BY_GOOGLE);
            }
            setDevicePhoneNumber(str);
            setPhoneNumberText(Utility.createPhoneNumber(str));
        }
    }

    PhoneContentController(AccountKitConfiguration accountKitConfiguration) {
        super(accountKitConfiguration);
        this.buttonType = DEFAULT_BUTTON_TYPE;
    }

    static PhoneNumberSource getPhoneNumberSource(@Nullable PhoneNumber phoneNumber, @Nullable PhoneNumber phoneNumber2, @Nullable String str) {
        if (phoneNumber == null) {
            return PhoneNumberSource.UNKNOWN;
        }
        if (!Utility.isNullOrEmpty(str)) {
            if (phoneNumber2 != null && str.equals(phoneNumber2.getRawPhoneNumber()) && str.equals(phoneNumber.getRawPhoneNumber())) {
                return PhoneNumberSource.APP_SUPPLIED_AND_DEVICE_PHONE_NUMBER;
            }
            if (str.equals(phoneNumber.getRawPhoneNumber())) {
                return PhoneNumberSource.DEVICE_PHONE_NUMBER;
            }
        }
        return (phoneNumber2 == null || !phoneNumber2.equals(phoneNumber)) ? (str == null && phoneNumber2 == null) ? PhoneNumberSource.DEVICE_PHONE_NUMBER_AND_APP_NUMBER_NOT_SUPPLIED : PhoneNumberSource.DEVICE_PHONE_NUMBER_NOT_SUPPLIED : PhoneNumberSource.APP_SUPPLIED_PHONE_NUMBER;
    }

    /* JADX INFO: Access modifiers changed from: private */
    public static void logPhoneNumberAutofill(String str) {
        Bundle bundle = new Bundle();
        bundle.putString(InternalLogger.EVENT_PARAM_EXTRAS_AUTOFILL_NUMBER_METHOD, str);
        AccountKitController.Logger.logEvent(InternalLogger.EVENT_NAME_PHONE_AUTOFILLED, bundle);
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void updateNextButton() {
        if (this.topFragment == null || this.bottomFragment == null) {
            return;
        }
        this.bottomFragment.setNextButtonEnabled(this.topFragment.isPhoneNumberValid());
        this.bottomFragment.setNextButtonType(getButtonType());
    }

    @Override // com.facebook.accountkit.ui.ContentController
    public BottomFragment getBottomFragment() {
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
            setCenterFragment(StaticContentFragmentFactory.create(this.configuration.getUIManager(), getLoginFlowState(), R.layout.com_accountkit_fragment_phone_login_center));
        }
        return this.centerFragment;
    }

    @Override // com.facebook.accountkit.ui.ContentController
    @Nullable
    public View getFocusView() {
        if (this.topFragment == null) {
            return null;
        }
        return this.topFragment.phoneNumberView;
    }

    @Override // com.facebook.accountkit.ui.ContentController
    public TitleFragmentFactory.TitleFragment getFooterFragment() {
        if (this.footerFragment == null) {
            setFooterFragment(TitleFragmentFactory.create(this.configuration.getUIManager()));
        }
        return this.footerFragment;
    }

    @Override // com.facebook.accountkit.ui.ContentController
    public LoginFlowState getLoginFlowState() {
        return LOGIN_FLOW_STATE;
    }

    abstract OnCompleteListener getOnCompleteListener();

    @Override // com.facebook.accountkit.ui.ContentController
    public ContentFragment getTextFragment() {
        if (this.textFragment == null) {
            setTextFragment(new TextFragment());
        }
        return this.textFragment;
    }

    @Override // com.facebook.accountkit.ui.ContentController
    @Nullable
    public TopFragment getTopFragment() {
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
        if (this.topFragment == null || this.bottomFragment == null) {
            return;
        }
        PhoneCountryCodeAdapter.ValueData initialCountryCodeValue = this.topFragment.getInitialCountryCodeValue();
        AccountKitController.Logger.logUIPhoneLoginShown(initialCountryCodeValue == null ? null : initialCountryCodeValue.countryCode, initialCountryCodeValue != null ? initialCountryCodeValue.countryCodeSource : null, this.bottomFragment.getRetry());
    }

    @Override // com.facebook.accountkit.ui.ContentControllerBase, com.facebook.accountkit.ui.ContentController
    public void onActivityResult(int i, int i2, Intent intent) {
        super.onActivityResult(i, i2, intent);
        if (i == RESOLVE_HINT_REQUEST_CODE && i2 == -1 && this.topFragment != null) {
            this.topFragment.setRequestedPhoneNumber(((Credential) intent.getParcelableExtra(Credential.EXTRA_KEY)).getId());
        }
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

    @Override // com.facebook.accountkit.ui.ContentController
    public void setTextFragment(@Nullable ContentFragment contentFragment) {
        if (contentFragment instanceof TextFragment) {
            this.textFragment = (TextFragment) contentFragment;
            this.textFragment.getViewState().putParcelable(ViewStateFragment.UI_MANAGER_KEY, this.configuration.getUIManager());
            this.textFragment.setNextButtonTextProvider(new TextContentFragment.NextButtonTextProvider() { // from class: com.facebook.accountkit.ui.PhoneContentController.1
                @Override // com.facebook.accountkit.ui.TextContentFragment.NextButtonTextProvider
                @Nullable
                public String getNextButtonText() {
                    if (PhoneContentController.this.bottomFragment == null) {
                        return null;
                    }
                    return PhoneContentController.this.textFragment.getResources().getText(PhoneContentController.this.bottomFragment.getNextButtonTextId()).toString();
                }
            });
        }
    }

    @Override // com.facebook.accountkit.ui.ContentController
    public void setTopFragment(@Nullable ContentFragment contentFragment) {
        if (contentFragment instanceof TopFragment) {
            this.topFragment = (TopFragment) contentFragment;
            this.topFragment.getViewState().putParcelable(ViewStateFragment.UI_MANAGER_KEY, this.configuration.getUIManager());
            this.topFragment.setOnPhoneNumberChangedListener(new TopFragment.OnPhoneNumberChangedListener() { // from class: com.facebook.accountkit.ui.PhoneContentController.2
                @Override // com.facebook.accountkit.ui.PhoneContentController.TopFragment.OnPhoneNumberChangedListener
                public void onPhoneNumberChanged() {
                    PhoneContentController.this.updateNextButton();
                }
            });
            this.topFragment.setOnCompleteListener(getOnCompleteListener());
            if (this.configuration.getInitialPhoneNumber() != null) {
                this.topFragment.setAppSuppliedPhoneNumber(this.configuration.getInitialPhoneNumber());
            }
            if (this.configuration.getDefaultCountryCode() != null) {
                this.topFragment.setDefaultCountryCodeValue(this.configuration.getDefaultCountryCode());
            }
            if (this.configuration.getSmsBlacklist() != null) {
                this.topFragment.setSmsBlacklist(this.configuration.getSmsBlacklist());
            }
            if (this.configuration.getSmsWhitelist() != null) {
                this.topFragment.setSmsWhitelist(this.configuration.getSmsWhitelist());
            }
            this.topFragment.setReadPhoneStateEnabled(this.configuration.isReadPhoneStateEnabled());
            updateNextButton();
        }
    }
}
