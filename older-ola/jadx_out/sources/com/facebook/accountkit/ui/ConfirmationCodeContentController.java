package com.facebook.accountkit.ui;

import android.content.ClipData;
import android.content.ClipboardManager;
import android.content.Context;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.text.Editable;
import android.text.TextWatcher;
import android.view.KeyEvent;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.EditText;
import android.widget.TextView;
import com.facebook.accountkit.PhoneNumber;
import com.facebook.accountkit.R;
import com.facebook.accountkit.internal.AccountKitController;
import com.facebook.accountkit.internal.Utility;
import com.facebook.accountkit.ui.NotifyingEditText;
import com.facebook.accountkit.ui.PrivacyPolicyFragment;
import com.facebook.accountkit.ui.StaticContentFragmentFactory;
import com.facebook.accountkit.ui.TitleFragmentFactory;

/* JADX INFO: loaded from: classes.dex */
abstract class ConfirmationCodeContentController extends ContentControllerBase implements ButtonContentController {
    private static final String ERROR_RESTART_KEY = "is_error_restart";
    private static final String NUMERIC_REGEX = "[0-9]+";

    @Nullable
    PrivacyPolicyFragment bottomFragment;
    private ButtonType buttonType;
    private StaticContentFragmentFactory.StaticContentFragment centerFragment;
    TitleFragmentFactory.TitleFragment footerFragment;

    @Nullable
    TitleFragment headerFragment;
    private StaticContentFragmentFactory.StaticContentFragment textFragment;

    @Nullable
    TopFragment topFragment;
    private static final LoginFlowState LOGIN_FLOW_STATE = LoginFlowState.CODE_INPUT;
    private static final ButtonType DEFAULT_BUTTON_TYPE = ButtonType.CONTINUE;

    public static abstract class TitleFragment extends TitleFragmentFactory.TitleFragment {

        @Nullable
        OnCompleteListener onCompleteListener;

        @Nullable
        PhoneNumber phoneNumber;
        boolean retry = false;

        public interface OnCompleteListener {
            void onEdit(Context context);
        }

        @Override // com.facebook.accountkit.ui.TitleFragmentFactory.TitleFragment, com.facebook.accountkit.ui.LoginFragment
        public View createView(LayoutInflater layoutInflater, ViewGroup viewGroup, Bundle bundle) {
            return layoutInflater.inflate(R.layout.com_accountkit_fragment_title, viewGroup, false);
        }

        @Override // android.app.Fragment
        public void onResume() {
            super.onResume();
            setPhoneNumberView();
        }

        @Override // com.facebook.accountkit.ui.TitleFragmentFactory.TitleFragment, com.facebook.accountkit.ui.ViewStateFragment
        protected void onViewReadyWithState(View view, Bundle bundle) {
            super.onViewReadyWithState(view, bundle);
            setPhoneNumberView();
        }

        void setOnCompleteListener(@Nullable OnCompleteListener onCompleteListener) {
            this.onCompleteListener = onCompleteListener;
        }

        void setPhoneNumber(PhoneNumber phoneNumber) {
            this.phoneNumber = phoneNumber;
            setPhoneNumberView();
        }

        abstract void setPhoneNumberView();

        void setRetry(boolean z) {
            this.retry = z;
            setPhoneNumberView();
        }
    }

    public static final class TopFragment extends ContentFragment {
        private static final String DETECTED_CONFIRMATION_CODE_KEY = "detectedConfirmationCode";
        private static final String TEXT_UPDATED_KEY = "textUpdated";

        @Nullable
        private EditText[] confirmationCodeViews;
        private PrivacyPolicyFragment.OnCompleteListener onCompleteListener;
        private OnConfirmationCodeChangedListener onConfirmationCodeChangedListener;

        interface OnConfirmationCodeChangedListener {
            void onConfirmationCodeChanged();
        }

        private void clearCodeWhenRestart() {
            if (this.confirmationCodeViews != null && getViewState().getBoolean(ConfirmationCodeContentController.ERROR_RESTART_KEY, false)) {
                for (EditText editText : this.confirmationCodeViews) {
                    editText.setText("");
                }
                getViewState().putBoolean(ConfirmationCodeContentController.ERROR_RESTART_KEY, false);
            }
        }

        /* JADX INFO: Access modifiers changed from: private */
        public EditText focusOnNext(View view) {
            if (this.confirmationCodeViews == null) {
                return null;
            }
            int confirmationCodeViewIndex = getConfirmationCodeViewIndex(view);
            if (confirmationCodeViewIndex >= this.confirmationCodeViews.length - 1) {
                this.confirmationCodeViews[this.confirmationCodeViews.length - 1].setSelection(1);
                return null;
            }
            EditText editText = this.confirmationCodeViews[confirmationCodeViewIndex + 1];
            editText.requestFocus();
            return editText;
        }

        /* JADX INFO: Access modifiers changed from: private */
        public EditText focusOnPrevious(View view) {
            int confirmationCodeViewIndex;
            if (this.confirmationCodeViews == null || (confirmationCodeViewIndex = getConfirmationCodeViewIndex(view)) <= 0) {
                return null;
            }
            EditText editText = this.confirmationCodeViews[confirmationCodeViewIndex - 1];
            editText.requestFocus();
            return editText;
        }

        private int getConfirmationCodeViewIndex(View view) {
            if (this.confirmationCodeViews != null && view != null) {
                int length = this.confirmationCodeViews.length;
                for (int i = 0; i < length; i++) {
                    if (this.confirmationCodeViews[i] == view) {
                        return i;
                    }
                }
            }
            return -1;
        }

        /* JADX INFO: Access modifiers changed from: private */
        public boolean getTextUpdated() {
            return getViewState().getBoolean(TEXT_UPDATED_KEY, false);
        }

        /* JADX INFO: Access modifiers changed from: private */
        public void setTextUpdated(boolean z) {
            getViewState().putBoolean(TEXT_UPDATED_KEY, z);
        }

        private void updateDetectedConfirmationCode() {
            int length;
            if (this.confirmationCodeViews == null) {
                return;
            }
            String detectedConfirmationCode = getDetectedConfirmationCode();
            if (!Utility.isNullOrEmpty(detectedConfirmationCode) && (length = detectedConfirmationCode.length()) == this.confirmationCodeViews.length) {
                for (EditText editText : this.confirmationCodeViews) {
                    if (editText.getText().length() != 0) {
                        return;
                    }
                }
                for (int i = 0; i < length; i++) {
                    this.confirmationCodeViews[i].setText(Character.toString(detectedConfirmationCode.charAt(i)));
                }
                this.confirmationCodeViews[this.confirmationCodeViews.length - 1].setSelection(1);
            }
        }

        @Override // com.facebook.accountkit.ui.LoginFragment
        protected View createView(LayoutInflater layoutInflater, ViewGroup viewGroup, Bundle bundle) {
            return layoutInflater.inflate(R.layout.com_accountkit_fragment_confirmation_code_top, viewGroup, false);
        }

        @Nullable
        public String getConfirmationCode() {
            if (this.confirmationCodeViews == null) {
                return null;
            }
            StringBuilder sb = new StringBuilder();
            for (EditText editText : this.confirmationCodeViews) {
                sb.append((CharSequence) editText.getText());
            }
            return sb.toString();
        }

        @Nullable
        public String getDetectedConfirmationCode() {
            return getViewState().getString(DETECTED_CONFIRMATION_CODE_KEY);
        }

        @Nullable
        public View getFocusView() {
            if (this.confirmationCodeViews == null) {
                return null;
            }
            for (EditText editText : this.confirmationCodeViews) {
                if (editText.getText().length() == 0) {
                    return editText;
                }
            }
            return null;
        }

        @Override // com.facebook.accountkit.ui.ContentFragment
        LoginFlowState getLoginFlowState() {
            return ConfirmationCodeContentController.LOGIN_FLOW_STATE;
        }

        public boolean isConfirmationCodeValid() {
            if (this.confirmationCodeViews == null) {
                return false;
            }
            for (EditText editText : this.confirmationCodeViews) {
                if (editText.getText().length() != 1) {
                    return false;
                }
            }
            return true;
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

        @Override // android.app.Fragment
        public void onResume() {
            super.onResume();
            clearCodeWhenRestart();
            ViewUtility.showKeyboard(getFocusView());
        }

        public void onRetry() {
            if (this.confirmationCodeViews == null) {
                return;
            }
            for (EditText editText : this.confirmationCodeViews) {
                editText.setText("");
            }
            if (this.confirmationCodeViews.length > 0) {
                this.confirmationCodeViews[0].requestFocus();
            }
        }

        @Override // com.facebook.accountkit.ui.ViewStateFragment, android.app.Fragment
        public /* bridge */ /* synthetic */ void onSaveInstanceState(Bundle bundle) {
            super.onSaveInstanceState(bundle);
        }

        @Override // com.facebook.accountkit.ui.ViewStateFragment
        protected void onViewReadyWithState(View view, Bundle bundle) {
            super.onViewReadyWithState(view, bundle);
            UIManager uIManager = getUIManager();
            if (uIManager instanceof BaseUIManager) {
                LoginFlowState flowState = ((BaseUIManager) uIManager).getFlowState();
                if (flowState == LoginFlowState.ERROR) {
                    this.confirmationCodeViews = null;
                    getViewState().putBoolean(ConfirmationCodeContentController.ERROR_RESTART_KEY, true);
                    return;
                } else if (flowState == LoginFlowState.VERIFIED) {
                    return;
                }
            }
            this.confirmationCodeViews = new EditText[]{(EditText) view.findViewById(R.id.com_accountkit_confirmation_code_1), (EditText) view.findViewById(R.id.com_accountkit_confirmation_code_2), (EditText) view.findViewById(R.id.com_accountkit_confirmation_code_3), (EditText) view.findViewById(R.id.com_accountkit_confirmation_code_4), (EditText) view.findViewById(R.id.com_accountkit_confirmation_code_5), (EditText) view.findViewById(R.id.com_accountkit_confirmation_code_6)};
            for (EditText editText : this.confirmationCodeViews) {
                if (editText.getText().length() != 0) {
                    editText.clearFocus();
                }
            }
            TextView.OnEditorActionListener onEditorActionListener = new TextView.OnEditorActionListener() { // from class: com.facebook.accountkit.ui.ConfirmationCodeContentController.TopFragment.1
                @Override // android.widget.TextView.OnEditorActionListener
                public boolean onEditorAction(TextView textView, int i, KeyEvent keyEvent) {
                    if (i != 5 || !TopFragment.this.isConfirmationCodeValid() || TopFragment.this.onCompleteListener == null) {
                        return true;
                    }
                    TopFragment.this.onCompleteListener.onNext(textView.getContext(), Buttons.ENTER_CONFIRMATION_CODE_KEYBOARD.name());
                    return true;
                }
            };
            View.OnKeyListener onKeyListener = new View.OnKeyListener() { // from class: com.facebook.accountkit.ui.ConfirmationCodeContentController.TopFragment.2
                @Override // android.view.View.OnKeyListener
                public boolean onKey(View view2, int i, KeyEvent keyEvent) {
                    EditText editTextFocusOnPrevious = (EditText) view2;
                    if (i >= 7 && i <= 16 && keyEvent.getAction() == 0) {
                        editTextFocusOnPrevious.setText(Character.toString((char) keyEvent.getUnicodeChar()));
                        return true;
                    }
                    if (i != 67 || keyEvent.getAction() != 0) {
                        return false;
                    }
                    if (editTextFocusOnPrevious.getText().length() != 0 || (editTextFocusOnPrevious = TopFragment.this.focusOnPrevious(editTextFocusOnPrevious)) != null) {
                        editTextFocusOnPrevious.setText("");
                    }
                    return true;
                }
            };
            for (final EditText editText2 : this.confirmationCodeViews) {
                editText2.setRawInputType(18);
                editText2.setOnEditorActionListener(onEditorActionListener);
                editText2.setOnKeyListener(onKeyListener);
                if (editText2 instanceof NotifyingEditText) {
                    NotifyingEditText notifyingEditText = (NotifyingEditText) editText2;
                    notifyingEditText.setOnSoftKeyListener(onKeyListener);
                    notifyingEditText.setPasteListener(new NotifyingEditText.PasteListener() { // from class: com.facebook.accountkit.ui.ConfirmationCodeContentController.TopFragment.3
                        @Override // com.facebook.accountkit.ui.NotifyingEditText.PasteListener
                        public void onTextPaste() {
                            char[] confirmationCodeToPaste = ConfirmationCodeContentController.getConfirmationCodeToPaste(TopFragment.this.getActivity());
                            if (confirmationCodeToPaste == null || TopFragment.this.confirmationCodeViews == null) {
                                return;
                            }
                            for (int i = 0; i < confirmationCodeToPaste.length; i++) {
                                TopFragment.this.confirmationCodeViews[i].setText(String.valueOf(confirmationCodeToPaste[i]));
                            }
                        }
                    });
                }
                editText2.addTextChangedListener(new TextWatcher() { // from class: com.facebook.accountkit.ui.ConfirmationCodeContentController.TopFragment.4
                    @Override // android.text.TextWatcher
                    public void afterTextChanged(Editable editable) {
                        if (!TopFragment.this.getTextUpdated()) {
                            TopFragment.this.setTextUpdated(true);
                            AccountKitController.Logger.logUIConfirmationCodeInteraction(Buttons.CONFIRMATION_CODE_FIRST_DIGIT.name(), null);
                        }
                        if (editable.length() == 1) {
                            TopFragment.this.focusOnNext(editText2);
                        }
                        if (TopFragment.this.onConfirmationCodeChangedListener != null) {
                            TopFragment.this.onConfirmationCodeChangedListener.onConfirmationCodeChanged();
                        }
                    }

                    @Override // android.text.TextWatcher
                    public void beforeTextChanged(CharSequence charSequence, int i, int i2, int i3) {
                    }

                    @Override // android.text.TextWatcher
                    public void onTextChanged(CharSequence charSequence, int i, int i2, int i3) {
                    }
                });
            }
            updateDetectedConfirmationCode();
            ViewUtility.showKeyboard(getFocusView());
        }

        public void setDetectedConfirmationCode(@Nullable String str) {
            getViewState().putString(DETECTED_CONFIRMATION_CODE_KEY, str);
            updateDetectedConfirmationCode();
        }

        public void setOnCompleteListener(@Nullable PrivacyPolicyFragment.OnCompleteListener onCompleteListener) {
            this.onCompleteListener = onCompleteListener;
        }

        public void setOnConfirmationCodeChangedListener(@Nullable OnConfirmationCodeChangedListener onConfirmationCodeChangedListener) {
            this.onConfirmationCodeChangedListener = onConfirmationCodeChangedListener;
        }
    }

    ConfirmationCodeContentController(AccountKitConfiguration accountKitConfiguration) {
        super(accountKitConfiguration);
        this.buttonType = DEFAULT_BUTTON_TYPE;
    }

    /* JADX INFO: Access modifiers changed from: private */
    public static char[] getConfirmationCodeToPaste(Context context) {
        String currentPasteText = getCurrentPasteText(context);
        if (currentPasteText != null && currentPasteText.length() == 6 && currentPasteText.matches(NUMERIC_REGEX)) {
            return currentPasteText.toCharArray();
        }
        return null;
    }

    private static String getCurrentPasteText(Context context) {
        if (context == null) {
            return null;
        }
        ClipboardManager clipboardManager = (ClipboardManager) context.getSystemService("clipboard");
        if (clipboardManager.hasPrimaryClip()) {
            ClipData.Item itemAt = clipboardManager.getPrimaryClip().getItemAt(0);
            if (itemAt.getText() != null) {
                return itemAt.getText().toString();
            }
        }
        return null;
    }

    @Override // com.facebook.accountkit.ui.ContentController
    public ContentFragment getBottomFragment() {
        if (this.bottomFragment == null) {
            setBottomFragment(PrivacyPolicyFragment.create(this.configuration.getUIManager(), LOGIN_FLOW_STATE, getButtonType()));
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
            setCenterFragment(StaticContentFragmentFactory.create(this.configuration.getUIManager(), getLoginFlowState(), R.layout.com_accountkit_fragment_confirmation_code_center));
        }
        return this.centerFragment;
    }

    @Override // com.facebook.accountkit.ui.ContentController
    @Nullable
    public View getFocusView() {
        if (this.topFragment == null) {
            return null;
        }
        return this.topFragment.getFocusView();
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
        return LoginFlowState.CODE_INPUT;
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
        AccountKitController.Logger.logUIConfirmationCodeShown(this.bottomFragment.getRetry());
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

    void setDetectedConfirmationCode(@Nullable String str) {
        if (this.topFragment == null) {
            return;
        }
        this.topFragment.setDetectedConfirmationCode(str);
    }

    @Override // com.facebook.accountkit.ui.ContentController
    public void setFooterFragment(@Nullable TitleFragmentFactory.TitleFragment titleFragment) {
        this.footerFragment = titleFragment;
    }

    void setPhoneNumber(@Nullable PhoneNumber phoneNumber) {
        if (this.headerFragment != null) {
            this.headerFragment.setPhoneNumber(phoneNumber);
        }
    }

    void setRetry(boolean z) {
        if (this.headerFragment != null) {
            this.headerFragment.setRetry(z);
        }
        if (this.bottomFragment != null) {
            this.bottomFragment.setRetry(z);
        }
        if (!z || this.topFragment == null) {
            return;
        }
        this.topFragment.onRetry();
    }

    @Override // com.facebook.accountkit.ui.ContentController
    public void setTextFragment(@Nullable ContentFragment contentFragment) {
        if (contentFragment instanceof StaticContentFragmentFactory.StaticContentFragment) {
            this.textFragment = (StaticContentFragmentFactory.StaticContentFragment) contentFragment;
        }
    }

    void updateNextButton() {
        if (this.topFragment == null || this.bottomFragment == null) {
            return;
        }
        this.bottomFragment.setNextButtonEnabled(this.topFragment.isConfirmationCodeValid());
        this.bottomFragment.setNextButtonType(getButtonType());
    }
}
