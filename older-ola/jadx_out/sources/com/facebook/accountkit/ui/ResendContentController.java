package com.facebook.accountkit.ui;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import android.support.annotation.StringRes;
import android.support.v4.content.LocalBroadcastManager;
import android.text.SpannableString;
import android.text.SpannableStringBuilder;
import android.text.TextPaint;
import android.text.method.LinkMovementMethod;
import android.text.style.ClickableSpan;
import android.text.style.ForegroundColorSpan;
import android.text.style.TypefaceSpan;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.TextView;
import com.facebook.accountkit.R;
import com.facebook.accountkit.internal.AccountKitController;
import com.facebook.accountkit.internal.ExperimentationConfiguration;
import com.facebook.accountkit.internal.Feature;
import com.facebook.accountkit.ui.LoginFlowBroadcastReceiver;
import com.facebook.accountkit.ui.StaticContentFragmentFactory;
import com.facebook.accountkit.ui.TitleFragmentFactory;
import java.util.List;
import java.util.concurrent.TimeUnit;

/* JADX INFO: loaded from: classes.dex */
final class ResendContentController extends ContentControllerBase {
    private static final LoginFlowState LOGIN_FLOW_STATE = LoginFlowState.RESEND;
    private BottomFragment bottomFragment;
    private StaticContentFragmentFactory.StaticContentFragment centerFragment;
    private TitleFragmentFactory.TitleFragment footerFragment;
    private TitleFragmentFactory.TitleFragment headerFragment;
    private StaticContentFragmentFactory.StaticContentFragment textFragment;
    private StaticContentFragmentFactory.StaticContentFragment topFragment;

    public static final class BottomFragment extends ContentFragment {
        private Handler countDownHandler;
        private OnCompleteListener onCompleteListener;
        private String phoneNumber;
        private TextView verifyPhoneNumberView;
        private static final long MILLIS_PER_SECOND = TimeUnit.SECONDS.toMillis(1);
        private static final String TAG = "ResendContentController$BottomFragment";
        private static final String FACEBOOK_NOTIFICATION_CHANNEL = TAG + ".FACEBOOK_NOTIFICATION_CHANNEL";
        private static final String VOICE_CALLBACK_NOTIFICATION_CHANNEL = TAG + ".VOICE_CALLBACK_NOTIFICATION_CHANNEL";
        private static final String RESEND_TIME_KEY = TAG + ".RESEND_TIME_KEY";

        public interface OnCompleteListener {
            void onConfirmationCodeCallback(Context context);

            void onEdit(Context context);

            void onFacebookNotification(Context context);

            void onResend(Context context);
        }

        private void setButtonText(Button button, @StringRes int i, @StringRes int i2) {
            SpannableStringBuilder spannableStringBuilderAppend = new SpannableStringBuilder(getString(i)).append((CharSequence) "\n");
            spannableStringBuilderAppend.setSpan(new TypefaceSpan("sans-serif-medium"), 0, spannableStringBuilderAppend.length(), 33);
            int length = spannableStringBuilderAppend.length();
            spannableStringBuilderAppend.append((CharSequence) getString(i2));
            spannableStringBuilderAppend.setSpan(new TypefaceSpan("sans-serif-light"), length, spannableStringBuilderAppend.length(), 33);
            spannableStringBuilderAppend.setSpan(new ForegroundColorSpan(ViewUtility.getButtonTextColor(button.getContext(), getUIManager())), length, spannableStringBuilderAppend.length(), 33);
            button.setText(spannableStringBuilderAppend);
        }

        private void updateNotificationViews() {
            View view = getView();
            if (view == null) {
                return;
            }
            view.findViewById(R.id.com_accountkit_send_in_fb_button).setVisibility(areFacebookNotificationsEnabled() ? 0 : 8);
            view.findViewById(R.id.com_accountkit_send_in_phone_call).setVisibility(areVoiceCallbackNotificationsEnabled() ? 0 : 8);
            view.findViewById(R.id.com_accountkit_other_ways_textview).setVisibility((areFacebookNotificationsEnabled() || areVoiceCallbackNotificationsEnabled()) ? 0 : 8);
        }

        private void updatePhoneNumberView() {
            if (!isAdded() || this.phoneNumber == null) {
                return;
            }
            SpannableString spannableString = new SpannableString(getString(R.string.com_accountkit_code_sent_to, new Object[]{this.phoneNumber}));
            ClickableSpan clickableSpan = new ClickableSpan() { // from class: com.facebook.accountkit.ui.ResendContentController.BottomFragment.4
                @Override // android.text.style.ClickableSpan
                public void onClick(View view) {
                    AccountKitController.Logger.logUIResendInteraction(Buttons.EDIT_NUMBER.name());
                    if (BottomFragment.this.onCompleteListener != null) {
                        BottomFragment.this.onCompleteListener.onEdit(view.getContext());
                    }
                }

                @Override // android.text.style.ClickableSpan, android.text.style.CharacterStyle
                public void updateDrawState(TextPaint textPaint) {
                    super.updateDrawState(textPaint);
                    textPaint.setColor(ViewUtility.getButtonColor(BottomFragment.this.getActivity(), BottomFragment.this.getUIManager()));
                    textPaint.setUnderlineText(false);
                }
            };
            int iIndexOf = spannableString.toString().indexOf(this.phoneNumber);
            spannableString.setSpan(clickableSpan, iIndexOf, this.phoneNumber.length() + iIndexOf, 33);
            this.verifyPhoneNumberView.setText(spannableString);
            this.verifyPhoneNumberView.setMovementMethod(LinkMovementMethod.getInstance());
        }

        private void updateResendView() {
            View viewFindViewById;
            View view = getView();
            if (view == null || (viewFindViewById = view.findViewById(R.id.com_accountkit_resend_button)) == null) {
                return;
            }
            final Button button = (Button) viewFindViewById;
            final long resendTime = getResendTime();
            this.countDownHandler.post(new Runnable() { // from class: com.facebook.accountkit.ui.ResendContentController.BottomFragment.5
                @Override // java.lang.Runnable
                public void run() {
                    if (BottomFragment.this.isAdded()) {
                        long seconds = TimeUnit.MILLISECONDS.toSeconds(resendTime - System.currentTimeMillis());
                        if (seconds <= 0) {
                            button.setText(R.string.com_accountkit_button_resend_sms);
                            button.setEnabled(true);
                        } else {
                            button.setText(BottomFragment.this.getString(R.string.com_accountkit_button_resend_code_in, new Object[]{Long.valueOf(seconds)}));
                            BottomFragment.this.countDownHandler.postDelayed(this, BottomFragment.MILLIS_PER_SECOND);
                            button.setEnabled(false);
                        }
                    }
                }
            });
        }

        private void updateViewStates() {
            updatePhoneNumberView();
            updateNotificationViews();
            updateResendView();
        }

        public boolean areFacebookNotificationsEnabled() {
            return getViewState().getBoolean(FACEBOOK_NOTIFICATION_CHANNEL);
        }

        public boolean areVoiceCallbackNotificationsEnabled() {
            return getViewState().getBoolean(VOICE_CALLBACK_NOTIFICATION_CHANNEL);
        }

        @Override // com.facebook.accountkit.ui.LoginFragment
        protected View createView(LayoutInflater layoutInflater, ViewGroup viewGroup, Bundle bundle) {
            return layoutInflater.inflate(R.layout.com_accountkit_fragment_resend_bottom, viewGroup, false);
        }

        @Override // com.facebook.accountkit.ui.ContentFragment
        LoginFlowState getLoginFlowState() {
            return ResendContentController.LOGIN_FLOW_STATE;
        }

        public long getResendTime() {
            return getViewState().getLong(RESEND_TIME_KEY);
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

        @Override // android.app.Fragment
        public void onPause() {
            super.onPause();
            this.countDownHandler.removeCallbacksAndMessages(null);
        }

        @Override // com.facebook.accountkit.ui.ViewStateFragment, android.app.Fragment
        public /* bridge */ /* synthetic */ void onSaveInstanceState(Bundle bundle) {
            super.onSaveInstanceState(bundle);
        }

        @Override // android.app.Fragment
        public void onStart() {
            super.onStart();
            updateViewStates();
        }

        @Override // android.app.Fragment
        public void onViewCreated(View view, Bundle bundle) {
            super.onViewCreated(view, bundle);
            this.countDownHandler = new Handler();
        }

        @Override // com.facebook.accountkit.ui.ViewStateFragment
        protected void onViewReadyWithState(View view, Bundle bundle) {
            super.onViewReadyWithState(view, bundle);
            View viewFindViewById = view.findViewById(R.id.com_accountkit_resend_button);
            this.verifyPhoneNumberView = (TextView) view.findViewById(R.id.com_accountkit_accountkit_verify_number);
            if (viewFindViewById != null) {
                viewFindViewById.setOnClickListener(new View.OnClickListener() { // from class: com.facebook.accountkit.ui.ResendContentController.BottomFragment.1
                    @Override // android.view.View.OnClickListener
                    public void onClick(View view2) {
                        AccountKitController.Logger.logUIResendInteraction(Buttons.TRY_AGAIN.name());
                        if (BottomFragment.this.onCompleteListener != null) {
                            BottomFragment.this.onCompleteListener.onResend(view2.getContext());
                        }
                    }
                });
            }
            Button button = (Button) view.findViewById(R.id.com_accountkit_send_in_fb_button);
            setButtonText(button, R.string.com_accountkit_button_send_code_in_fb, R.string.com_accountkit_button_send_code_in_fb_details);
            button.setOnClickListener(new View.OnClickListener() { // from class: com.facebook.accountkit.ui.ResendContentController.BottomFragment.2
                @Override // android.view.View.OnClickListener
                public void onClick(View view2) {
                    AccountKitController.Logger.logUIResendInteraction(Buttons.FB_NOTIFICATION.name());
                    if (BottomFragment.this.onCompleteListener != null) {
                        BottomFragment.this.onCompleteListener.onFacebookNotification(view2.getContext());
                    }
                }
            });
            Button button2 = (Button) view.findViewById(R.id.com_accountkit_send_in_phone_call);
            ExperimentationConfiguration experimentationConfiguration = AccountKitController.getExperimentationConfiguration();
            final boolean booleanValue = experimentationConfiguration.getBooleanValue(Feature.CALLBACK_BUTTON_ALTERNATE_TEXT);
            setButtonText(button2, R.string.com_accountkit_button_send_code_in_call, (experimentationConfiguration.exists() && booleanValue) ? R.string.com_accountkit_button_send_code_in_call_from_facebook_details : R.string.com_accountkit_button_send_code_in_call_details);
            button2.setOnClickListener(new View.OnClickListener() { // from class: com.facebook.accountkit.ui.ResendContentController.BottomFragment.3
                @Override // android.view.View.OnClickListener
                public void onClick(View view2) {
                    AccountKitController.Logger.logUIResendInteraction((booleanValue ? Buttons.CONFIRMATION_CODE_CALLBACK : Buttons.CONFIRMATION_CODE_CALLBACK_ALTERNATE).name());
                    if (BottomFragment.this.onCompleteListener != null) {
                        BottomFragment.this.onCompleteListener.onConfirmationCodeCallback(view2.getContext());
                    }
                }
            });
            updateViewStates();
        }

        public void setNotificationChannels(List<NotificationChannel> list) {
            getViewState().putBoolean(FACEBOOK_NOTIFICATION_CHANNEL, list.contains(NotificationChannel.FACEBOOK));
            getViewState().putBoolean(VOICE_CALLBACK_NOTIFICATION_CHANNEL, list.contains(NotificationChannel.VOICE_CALLBACK));
            updateNotificationViews();
        }

        public void setOnCompleteListener(@Nullable OnCompleteListener onCompleteListener) {
            this.onCompleteListener = onCompleteListener;
        }

        public void setPhoneNumber(String str) {
            this.phoneNumber = str;
            updatePhoneNumberView();
        }

        public void setResendTime(long j) {
            getViewState().putLong(RESEND_TIME_KEY, j);
            updateResendView();
        }
    }

    public static final class HeaderFragment extends TitleFragmentFactory.TitleFragment {
        public static HeaderFragment create(@NonNull UIManager uIManager, int i, @Nullable String... strArr) {
            HeaderFragment headerFragment = new HeaderFragment();
            headerFragment.getViewState().putParcelable(ViewStateFragment.UI_MANAGER_KEY, uIManager);
            headerFragment.setTitleResourceId(i, strArr);
            return headerFragment;
        }

        @Override // com.facebook.accountkit.ui.TitleFragmentFactory.TitleFragment, com.facebook.accountkit.ui.ViewStateFragment
        protected void onViewReadyWithState(View view, Bundle bundle) {
            super.onViewReadyWithState(view, bundle);
            this.titleView.setGravity(16);
        }
    }

    ResendContentController(AccountKitConfiguration accountKitConfiguration) {
        super(accountKitConfiguration);
    }

    @Override // com.facebook.accountkit.ui.ContentController
    public ContentFragment getBottomFragment() {
        if (this.bottomFragment == null) {
            setBottomFragment(new BottomFragment());
        }
        return this.bottomFragment;
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
            setHeaderFragment(HeaderFragment.create(this.configuration.getUIManager(), R.string.com_accountkit_resend_title, new String[0]));
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
            this.textFragment = StaticContentFragmentFactory.create(this.configuration.getUIManager(), getLoginFlowState());
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

    @Override // com.facebook.accountkit.ui.ContentControllerBase
    protected void logImpression() {
        AccountKitController.Logger.logUIResend(true);
    }

    @Override // com.facebook.accountkit.ui.ContentController
    public void setBottomFragment(@Nullable ContentFragment contentFragment) {
        if (contentFragment instanceof BottomFragment) {
            this.bottomFragment = (BottomFragment) contentFragment;
            this.bottomFragment.getViewState().putParcelable(ViewStateFragment.UI_MANAGER_KEY, this.configuration.getUIManager());
            this.bottomFragment.setOnCompleteListener(new BottomFragment.OnCompleteListener() { // from class: com.facebook.accountkit.ui.ResendContentController.1
                @Override // com.facebook.accountkit.ui.ResendContentController.BottomFragment.OnCompleteListener
                public void onConfirmationCodeCallback(Context context) {
                    LocalBroadcastManager.getInstance(context).sendBroadcast(new Intent(LoginFlowBroadcastReceiver.ACTION_UPDATE).putExtra(LoginFlowBroadcastReceiver.EXTRA_EVENT, LoginFlowBroadcastReceiver.Event.PHONE_RESEND_VOICE_CALL_NOTIFICATION));
                }

                @Override // com.facebook.accountkit.ui.ResendContentController.BottomFragment.OnCompleteListener
                public void onEdit(Context context) {
                    LocalBroadcastManager.getInstance(context).sendBroadcast(new Intent(LoginFlowBroadcastReceiver.ACTION_UPDATE).putExtra(LoginFlowBroadcastReceiver.EXTRA_EVENT, LoginFlowBroadcastReceiver.Event.PHONE_RESEND));
                }

                @Override // com.facebook.accountkit.ui.ResendContentController.BottomFragment.OnCompleteListener
                public void onFacebookNotification(Context context) {
                    LocalBroadcastManager.getInstance(context).sendBroadcast(new Intent(LoginFlowBroadcastReceiver.ACTION_UPDATE).putExtra(LoginFlowBroadcastReceiver.EXTRA_EVENT, LoginFlowBroadcastReceiver.Event.PHONE_RESEND_FACEBOOK_NOTIFICATION));
                }

                @Override // com.facebook.accountkit.ui.ResendContentController.BottomFragment.OnCompleteListener
                public void onResend(Context context) {
                    LocalBroadcastManager.getInstance(context).sendBroadcast(new Intent(LoginFlowBroadcastReceiver.ACTION_UPDATE).putExtra(LoginFlowBroadcastReceiver.EXTRA_EVENT, LoginFlowBroadcastReceiver.Event.PHONE_RESEND));
                }
            });
        }
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

    void setNotificationChannels(List<NotificationChannel> list) {
        if (this.bottomFragment != null) {
            this.bottomFragment.setNotificationChannels(list);
        }
    }

    public void setPhoneNumber(@Nullable String str) {
        if (this.bottomFragment != null) {
            this.bottomFragment.setPhoneNumber(str);
        }
    }

    void setResendTime(long j) {
        if (this.bottomFragment != null) {
            this.bottomFragment.setResendTime(j);
        }
    }

    @Override // com.facebook.accountkit.ui.ContentController
    public void setTextFragment(@Nullable ContentFragment contentFragment) {
        if (contentFragment instanceof StaticContentFragmentFactory.StaticContentFragment) {
            this.textFragment = (StaticContentFragmentFactory.StaticContentFragment) contentFragment;
        }
    }

    @Override // com.facebook.accountkit.ui.ContentController
    public void setTopFragment(@Nullable ContentFragment contentFragment) {
        if (contentFragment instanceof StaticContentFragmentFactory.StaticContentFragment) {
            this.topFragment = (StaticContentFragmentFactory.StaticContentFragment) contentFragment;
        }
    }
}
