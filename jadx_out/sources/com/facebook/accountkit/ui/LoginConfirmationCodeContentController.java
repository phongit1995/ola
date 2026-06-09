package com.facebook.accountkit.ui;

import android.content.Context;
import android.content.Intent;
import android.support.annotation.Nullable;
import android.support.v4.content.LocalBroadcastManager;
import android.text.SpannableString;
import android.text.TextPaint;
import android.text.method.LinkMovementMethod;
import android.text.style.ClickableSpan;
import android.view.View;
import com.facebook.accountkit.R;
import com.facebook.accountkit.internal.AccountKitController;
import com.facebook.accountkit.ui.ConfirmationCodeContentController;
import com.facebook.accountkit.ui.LoginFlowBroadcastReceiver;
import com.facebook.accountkit.ui.PrivacyPolicyFragment;
import com.facebook.accountkit.ui.TitleFragmentFactory;

/* JADX INFO: loaded from: classes.dex */
class LoginConfirmationCodeContentController extends ConfirmationCodeContentController {
    private OnCompleteListener onCompleteListener;

    private class OnCompleteListener implements ConfirmationCodeContentController.TitleFragment.OnCompleteListener, PrivacyPolicyFragment.OnCompleteListener {
        private OnCompleteListener() {
        }

        @Override // com.facebook.accountkit.ui.ConfirmationCodeContentController.TitleFragment.OnCompleteListener
        public void onEdit(Context context) {
            LocalBroadcastManager.getInstance(context).sendBroadcast(new Intent(LoginFlowBroadcastReceiver.ACTION_UPDATE).putExtra(LoginFlowBroadcastReceiver.EXTRA_EVENT, LoginFlowBroadcastReceiver.Event.PHONE_RESEND));
        }

        @Override // com.facebook.accountkit.ui.PrivacyPolicyFragment.OnCompleteListener
        public void onNext(Context context, String str) {
            if (LoginConfirmationCodeContentController.this.topFragment == null || LoginConfirmationCodeContentController.this.bottomFragment == null) {
                return;
            }
            String confirmationCode = LoginConfirmationCodeContentController.this.topFragment.getConfirmationCode();
            AccountKitController.Logger.logUIConfirmationCodeInteraction(str, LoginConfirmationCodeContentController.this.topFragment.getDetectedConfirmationCode(), confirmationCode);
            LocalBroadcastManager.getInstance(context).sendBroadcast(new Intent(LoginFlowBroadcastReceiver.ACTION_UPDATE).putExtra(LoginFlowBroadcastReceiver.EXTRA_EVENT, LoginFlowBroadcastReceiver.Event.PHONE_CONFIRMATION_CODE_COMPLETE).putExtra(LoginFlowBroadcastReceiver.EXTRA_CONFIRMATION_CODE, confirmationCode));
        }

        @Override // com.facebook.accountkit.ui.PrivacyPolicyFragment.OnCompleteListener
        public void onRetry(Context context) {
            LocalBroadcastManager.getInstance(context).sendBroadcast(new Intent(LoginFlowBroadcastReceiver.ACTION_UPDATE).putExtra(LoginFlowBroadcastReceiver.EXTRA_EVENT, LoginFlowBroadcastReceiver.Event.PHONE_CONFIRMATION_CODE_RETRY));
        }
    }

    public static final class TitleFragment extends ConfirmationCodeContentController.TitleFragment {

        @Nullable
        private NotificationChannel notificationChannel;

        public static TitleFragment create(UIManager uIManager, int i, @Nullable String... strArr) {
            TitleFragment titleFragment = new TitleFragment();
            titleFragment.getViewState().putParcelable(ViewStateFragment.UI_MANAGER_KEY, uIManager);
            titleFragment.setTitleResourceId(i, strArr);
            return titleFragment;
        }

        void setNotificationChannel(NotificationChannel notificationChannel) {
            this.notificationChannel = notificationChannel;
            setPhoneNumberView();
        }

        @Override // com.facebook.accountkit.ui.ConfirmationCodeContentController.TitleFragment
        void setPhoneNumberView() {
            int i;
            String string;
            if (isAdded() && this.notificationChannel != null) {
                switch (this.notificationChannel) {
                    case FACEBOOK:
                        i = R.string.com_accountkit_facebook_code_entry_title;
                        break;
                    case VOICE_CALLBACK:
                        i = R.string.com_accountkit_voice_call_code_entry_title;
                        break;
                    default:
                        if (this.phoneNumber == null) {
                            return;
                        }
                        if (this.retry) {
                            string = getString(R.string.com_accountkit_verify_confirmation_code_title) + "\n" + this.phoneNumber.toString();
                        } else {
                            string = getString(R.string.com_accountkit_enter_code_sent_to, new Object[]{this.phoneNumber.toString()});
                        }
                        SpannableString spannableString = new SpannableString(string);
                        ClickableSpan clickableSpan = new ClickableSpan() { // from class: com.facebook.accountkit.ui.LoginConfirmationCodeContentController.TitleFragment.1
                            @Override // android.text.style.ClickableSpan
                            public void onClick(View view) {
                                AccountKitController.Logger.logUIResendInteraction(Buttons.PHONE_NUMBER.name());
                                if (TitleFragment.this.onCompleteListener != null) {
                                    TitleFragment.this.onCompleteListener.onEdit(view.getContext());
                                }
                            }

                            @Override // android.text.style.ClickableSpan, android.text.style.CharacterStyle
                            public void updateDrawState(TextPaint textPaint) {
                                super.updateDrawState(textPaint);
                                textPaint.setColor(ViewUtility.getButtonColor(TitleFragment.this.getActivity(), TitleFragment.this.getUIManager()));
                                textPaint.setUnderlineText(false);
                            }
                        };
                        int iIndexOf = spannableString.toString().indexOf(this.phoneNumber.toString());
                        spannableString.setSpan(clickableSpan, iIndexOf, this.phoneNumber.toString().length() + iIndexOf, 33);
                        this.titleView.setText(spannableString);
                        this.titleView.setMovementMethod(LinkMovementMethod.getInstance());
                        return;
                }
                setTitleResourceId(i, new String[0]);
            }
        }
    }

    LoginConfirmationCodeContentController(AccountKitConfiguration accountKitConfiguration) {
        super(accountKitConfiguration);
    }

    private OnCompleteListener getOnCompleteListener() {
        if (this.onCompleteListener == null) {
            this.onCompleteListener = new OnCompleteListener();
        }
        return this.onCompleteListener;
    }

    @Override // com.facebook.accountkit.ui.ContentController
    public TitleFragmentFactory.TitleFragment getHeaderFragment() {
        if (this.headerFragment == null) {
            setHeaderFragment(TitleFragment.create(this.configuration.getUIManager(), R.string.com_accountkit_confirmation_code_title, new String[0]));
        }
        return this.headerFragment;
    }

    @Override // com.facebook.accountkit.ui.ContentController
    public void setBottomFragment(@Nullable ContentFragment contentFragment) {
        if (contentFragment instanceof PrivacyPolicyFragment) {
            this.bottomFragment = (PrivacyPolicyFragment) contentFragment;
            this.bottomFragment.setOnCompleteListener(getOnCompleteListener());
            updateNextButton();
        }
    }

    @Override // com.facebook.accountkit.ui.ContentController
    public void setHeaderFragment(@Nullable TitleFragmentFactory.TitleFragment titleFragment) {
        if (titleFragment instanceof TitleFragment) {
            this.headerFragment = (TitleFragment) titleFragment;
            this.headerFragment.setOnCompleteListener(getOnCompleteListener());
        }
    }

    void setNotificationChannel(NotificationChannel notificationChannel) {
        if (this.headerFragment == null) {
            return;
        }
        ((TitleFragment) this.headerFragment).setNotificationChannel(notificationChannel);
    }

    @Override // com.facebook.accountkit.ui.ContentController
    public void setTopFragment(@Nullable ContentFragment contentFragment) {
        if (contentFragment instanceof ConfirmationCodeContentController.TopFragment) {
            this.topFragment = (ConfirmationCodeContentController.TopFragment) contentFragment;
            this.topFragment.getViewState().putParcelable(ViewStateFragment.UI_MANAGER_KEY, this.configuration.getUIManager());
            this.topFragment.setOnConfirmationCodeChangedListener(new ConfirmationCodeContentController.TopFragment.OnConfirmationCodeChangedListener() { // from class: com.facebook.accountkit.ui.LoginConfirmationCodeContentController.1
                @Override // com.facebook.accountkit.ui.ConfirmationCodeContentController.TopFragment.OnConfirmationCodeChangedListener
                public void onConfirmationCodeChanged() {
                    LoginConfirmationCodeContentController.this.updateNextButton();
                }
            });
            this.topFragment.setOnCompleteListener(getOnCompleteListener());
        }
    }
}
