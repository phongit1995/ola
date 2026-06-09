package com.facebook.accountkit.ui;

import android.app.Fragment;
import android.app.FragmentManager;
import android.app.FragmentTransaction;
import android.support.annotation.Nullable;
import com.facebook.accountkit.AccountKitError;
import com.facebook.accountkit.R;
import com.facebook.accountkit.internal.AccountKitController;
import com.facebook.accountkit.ui.AdvancedUIManager;
import com.facebook.accountkit.ui.SkinManager;
import com.facebook.accountkit.ui.TitleFragmentFactory;
import com.facebook.accountkit.ui.UIManager;
import java.lang.ref.WeakReference;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

/* JADX INFO: loaded from: classes.dex */
final class StateStackManager implements FragmentManager.OnBackStackChangedListener, AdvancedUIManager.AdvancedUIManagerListener, UIManager.UIManagerListener {
    private final WeakReference<AccountKitActivity> activityRef;
    private final AccountKitConfiguration configuration;
    private ContentController contentController;
    private final Map<LoginFlowState, ContentController> contentControllerMap = new HashMap();
    private final List<OnPopListener> onPopListeners = new ArrayList();
    private final List<OnPushListener> onPushListeners = new ArrayList();
    private final UIManager uiManager;

    private enum FragmentType {
        BODY,
        FOOTER,
        HEADER
    }

    interface OnPopListener {
        void onContentPopped();
    }

    interface OnPushListener {
        void onContentControllerReady(ContentController contentController);

        void onContentPushed();
    }

    StateStackManager(AccountKitActivity accountKitActivity, AccountKitConfiguration accountKitConfiguration) {
        this.activityRef = new WeakReference<>(accountKitActivity);
        accountKitActivity.getFragmentManager().addOnBackStackChangedListener(this);
        this.configuration = accountKitConfiguration;
        this.uiManager = accountKitConfiguration == null ? null : accountKitConfiguration.getUIManager();
        if (this.uiManager instanceof AdvancedUIManagerWrapper) {
            ((AdvancedUIManagerWrapper) this.uiManager).getAdvancedUIManager().setAdvancedUIManagerListener(this);
        } else if (this.uiManager != null) {
            this.uiManager.setUIManagerListener(this);
        }
    }

    @Nullable
    private ContentController ensureContentController(AccountKitActivity accountKitActivity, LoginFlowState loginFlowState, LoginFlowState loginFlowState2, boolean z) {
        ContentController phoneLoginContentController;
        ContentController contentController = this.contentControllerMap.get(loginFlowState);
        if (contentController != null) {
            return contentController;
        }
        switch (loginFlowState) {
            case NONE:
                return null;
            case PHONE_NUMBER_INPUT:
                phoneLoginContentController = new PhoneLoginContentController(this.configuration);
                break;
            case SENDING_CODE:
                phoneLoginContentController = new SendingCodeContentController(this.configuration);
                break;
            case SENT_CODE:
                switch (this.configuration.getLoginType()) {
                    case PHONE:
                        phoneLoginContentController = new PhoneSentCodeContentController(this.configuration);
                        break;
                    case EMAIL:
                        phoneLoginContentController = new EmailSentCodeContentController(this.configuration);
                        break;
                    default:
                        throw new RuntimeException("Unexpected login type: " + this.configuration.getLoginType().toString());
                }
                break;
            case ACCOUNT_VERIFIED:
                phoneLoginContentController = new AccountVerifiedContentController(this.configuration);
                break;
            case CONFIRM_ACCOUNT_VERIFIED:
                phoneLoginContentController = new ConfirmAccountVerifiedContentController(this.configuration);
                break;
            case CONFIRM_INSTANT_VERIFICATION_LOGIN:
                phoneLoginContentController = new VerifyingCodeContentController(this.configuration);
                break;
            case CODE_INPUT:
                phoneLoginContentController = new LoginConfirmationCodeContentController(this.configuration);
                break;
            case VERIFYING_CODE:
                phoneLoginContentController = new VerifyingCodeContentController(this.configuration);
                break;
            case VERIFIED:
                phoneLoginContentController = new VerifiedCodeContentController(this.configuration);
                break;
            case ERROR:
                phoneLoginContentController = new LoginErrorContentController(loginFlowState2, this.configuration);
                break;
            case EMAIL_INPUT:
                phoneLoginContentController = new EmailLoginContentController(this.configuration);
                break;
            case EMAIL_VERIFY:
                phoneLoginContentController = new EmailVerifyContentController(this.configuration);
                break;
            case RESEND:
                phoneLoginContentController = new ResendContentController(this.configuration);
                break;
            default:
                return null;
        }
        if (z) {
            Fragment fragmentFindFragmentById = accountKitActivity.getFragmentManager().findFragmentById(R.id.com_accountkit_header_fragment);
            if (fragmentFindFragmentById instanceof TitleFragmentFactory.TitleFragment) {
                phoneLoginContentController.setHeaderFragment((TitleFragmentFactory.TitleFragment) fragmentFindFragmentById);
            }
            phoneLoginContentController.setTopFragment(getContentFragment(accountKitActivity, R.id.com_accountkit_content_top_fragment));
            phoneLoginContentController.setCenterFragment(getContentFragment(accountKitActivity, R.id.com_accountkit_content_center_fragment));
            phoneLoginContentController.setBottomFragment(getContentFragment(accountKitActivity, R.id.com_accountkit_content_bottom_fragment));
            Fragment fragmentFindFragmentById2 = accountKitActivity.getFragmentManager().findFragmentById(R.id.com_accountkit_footer_fragment);
            if (fragmentFindFragmentById2 instanceof TitleFragmentFactory.TitleFragment) {
                phoneLoginContentController.setFooterFragment((TitleFragmentFactory.TitleFragment) fragmentFindFragmentById2);
            }
            phoneLoginContentController.onResume(accountKitActivity);
        }
        this.contentControllerMap.put(loginFlowState, phoneLoginContentController);
        return phoneLoginContentController;
    }

    @Nullable
    private ContentFragment getContentFragment(AccountKitActivity accountKitActivity, int i) {
        Fragment fragmentFindFragmentById = accountKitActivity.getFragmentManager().findFragmentById(i);
        if (fragmentFindFragmentById instanceof ContentFragment) {
            return (ContentFragment) fragmentFindFragmentById;
        }
        return null;
    }

    private void pushState(AccountKitActivity accountKitActivity, LoginFlowManager loginFlowManager, LoginFlowState loginFlowState, @Nullable OnPushListener onPushListener) {
        Fragment headerFragment;
        int i;
        int i2;
        ButtonType buttonType;
        LoginFlowState flowState = loginFlowManager.getFlowState();
        ContentController contentController = getContentController();
        ContentController contentControllerEnsureContentController = ensureContentController(accountKitActivity, flowState, loginFlowState, false);
        if (contentControllerEnsureContentController == null || contentController == contentControllerEnsureContentController) {
            return;
        }
        NotificationChannel notificationChannel = loginFlowManager instanceof PhoneLoginFlowManager ? ((PhoneLoginFlowManager) loginFlowManager).getNotificationChannel() : null;
        AccountKitController.Logger.logUIManager(this.uiManager);
        if ((flowState == LoginFlowState.RESEND && (contentControllerEnsureContentController instanceof ResendContentController)) || ((flowState == LoginFlowState.CODE_INPUT && (contentControllerEnsureContentController instanceof LoginConfirmationCodeContentController)) || (contentControllerEnsureContentController instanceof LoginErrorContentController))) {
            headerFragment = contentControllerEnsureContentController.getHeaderFragment();
        } else {
            headerFragment = this.uiManager.getHeaderFragment(flowState);
            AccountKitController.Logger.logUICustomFragment(this.configuration.getLoginType(), FragmentType.HEADER.name(), headerFragment != null);
        }
        Fragment bodyFragment = this.uiManager.getBodyFragment(flowState);
        AccountKitController.Logger.logUICustomFragment(this.configuration.getLoginType(), FragmentType.BODY.name(), bodyFragment != null);
        Fragment footerFragment = this.uiManager.getFooterFragment(flowState);
        AccountKitController.Logger.logUICustomFragment(this.configuration.getLoginType(), FragmentType.FOOTER.name(), footerFragment != null);
        if (headerFragment == null) {
            headerFragment = BaseUIManager.getDefaultHeaderFragment(this.uiManager, flowState, loginFlowManager.getLoginType(), notificationChannel);
        }
        if (bodyFragment == null) {
            bodyFragment = BaseUIManager.getDefaultBodyFragment(this.uiManager, flowState);
        }
        if (footerFragment == null) {
            footerFragment = BaseUIManager.getDefaultFooterFragment(this.uiManager);
        }
        TextPosition textPosition = this.uiManager.getTextPosition(flowState);
        if ((contentControllerEnsureContentController instanceof ButtonContentController) && (buttonType = this.uiManager.getButtonType(flowState)) != null) {
            ((ButtonContentController) contentControllerEnsureContentController).setButtonType(buttonType);
        }
        ContentFragment topFragment = contentControllerEnsureContentController.getTopFragment();
        ContentFragment textFragment = contentControllerEnsureContentController.getTextFragment();
        ContentFragment bottomFragment = contentControllerEnsureContentController.getBottomFragment();
        if (onPushListener != null) {
            this.onPushListeners.add(onPushListener);
            onPushListener.onContentControllerReady(contentControllerEnsureContentController);
        }
        if (textPosition == null) {
            textPosition = TextPosition.BELOW_BODY;
        }
        if (textFragment != null) {
            switch (textPosition) {
                case ABOVE_BODY:
                    i = R.dimen.com_accountkit_vertical_spacer_small_height;
                    i2 = 0;
                    break;
                case BELOW_BODY:
                    i2 = R.dimen.com_accountkit_vertical_spacer_small_height;
                    i = 0;
                    break;
                default:
                    i = 0;
                    i2 = 0;
                    break;
            }
            int dimensionPixelSize = i == 0 ? 0 : accountKitActivity.getResources().getDimensionPixelSize(i);
            int dimensionPixelSize2 = i2 != 0 ? accountKitActivity.getResources().getDimensionPixelSize(i2) : 0;
            if (textFragment instanceof TextContentFragment) {
                TextContentFragment textContentFragment = (TextContentFragment) textFragment;
                textContentFragment.setContentPaddingTop(dimensionPixelSize);
                textContentFragment.setContentPaddingBottom(dimensionPixelSize2);
            }
        }
        FragmentManager fragmentManager = accountKitActivity.getFragmentManager();
        if (contentController != null) {
            accountKitActivity.onContentControllerDismissed(contentController);
            if (contentController.isTransient()) {
                fragmentManager.popBackStack();
            }
        }
        if (ViewUtility.isSkin(this.uiManager, SkinManager.Skin.CONTEMPORARY)) {
            accountKitActivity.ensureNextButton(contentControllerEnsureContentController);
        }
        FragmentTransaction fragmentTransactionBeginTransaction = fragmentManager.beginTransaction();
        accountKitActivity.replace(fragmentTransactionBeginTransaction, R.id.com_accountkit_header_fragment, headerFragment);
        accountKitActivity.replace(fragmentTransactionBeginTransaction, R.id.com_accountkit_content_top_fragment, topFragment);
        accountKitActivity.replace(fragmentTransactionBeginTransaction, R.id.com_accountkit_content_top_text_fragment, textPosition == TextPosition.ABOVE_BODY ? textFragment : null);
        accountKitActivity.replace(fragmentTransactionBeginTransaction, R.id.com_accountkit_content_center_fragment, bodyFragment);
        int i3 = R.id.com_accountkit_content_bottom_text_fragment;
        if (textPosition != TextPosition.BELOW_BODY) {
            textFragment = null;
        }
        accountKitActivity.replace(fragmentTransactionBeginTransaction, i3, textFragment);
        if (!ViewUtility.isSkin(this.uiManager, SkinManager.Skin.CONTEMPORARY)) {
            accountKitActivity.replace(fragmentTransactionBeginTransaction, R.id.com_accountkit_content_bottom_fragment, bottomFragment);
            accountKitActivity.replace(fragmentTransactionBeginTransaction, R.id.com_accountkit_footer_fragment, footerFragment);
        }
        fragmentTransactionBeginTransaction.addToBackStack(null);
        ViewUtility.hideKeyboard(accountKitActivity);
        fragmentTransactionBeginTransaction.commit();
        contentControllerEnsureContentController.onResume(accountKitActivity);
    }

    @Nullable
    ContentController getContentController() {
        return this.contentController;
    }

    OnPushListener getErrorOnPushListener(@Nullable final String str) {
        return new OnPushListener() { // from class: com.facebook.accountkit.ui.StateStackManager.1
            @Override // com.facebook.accountkit.ui.StateStackManager.OnPushListener
            public void onContentControllerReady(ContentController contentController) {
                if (contentController instanceof LoginErrorContentController) {
                    ((LoginErrorContentController) contentController).setErrorMessage(str);
                }
            }

            @Override // com.facebook.accountkit.ui.StateStackManager.OnPushListener
            public void onContentPushed() {
            }
        };
    }

    void multiPopBackStack(OnPopListener onPopListener) {
        AccountKitActivity accountKitActivity = this.activityRef.get();
        if (accountKitActivity == null) {
            return;
        }
        if (onPopListener != null) {
            this.onPopListeners.add(onPopListener);
        }
        accountKitActivity.getFragmentManager().popBackStack();
        accountKitActivity.ensureNextButton(null);
    }

    @Override // com.facebook.accountkit.ui.UIManager.UIManagerListener
    public void onBack() {
        AccountKitActivity accountKitActivity = this.activityRef.get();
        if (accountKitActivity == null) {
            return;
        }
        accountKitActivity.onBackPressed();
    }

    @Override // android.app.FragmentManager.OnBackStackChangedListener
    public void onBackStackChanged() {
        AccountKitActivity accountKitActivity = this.activityRef.get();
        if (accountKitActivity == null) {
            return;
        }
        updateContentController(accountKitActivity);
    }

    @Override // com.facebook.accountkit.ui.UIManager.UIManagerListener
    public void onCancel() {
        AccountKitActivity accountKitActivity = this.activityRef.get();
        if (accountKitActivity == null) {
            return;
        }
        accountKitActivity.sendCancelResult();
    }

    void popBackStack(LoginFlowState loginFlowState, @Nullable OnPopListener onPopListener) {
        AccountKitActivity accountKitActivity = this.activityRef.get();
        if (accountKitActivity == null) {
            return;
        }
        if (onPopListener != null) {
            this.onPopListeners.add(onPopListener);
        }
        ContentController contentControllerEnsureContentController = ensureContentController(accountKitActivity, loginFlowState, LoginFlowState.NONE, false);
        if (loginFlowState == LoginFlowState.PHONE_NUMBER_INPUT || loginFlowState == LoginFlowState.EMAIL_INPUT) {
            accountKitActivity.getFragmentManager().popBackStack(0, 0);
        } else {
            accountKitActivity.getFragmentManager().popBackStack();
        }
        accountKitActivity.ensureNextButton(contentControllerEnsureContentController);
    }

    void pushError(AccountKitActivity accountKitActivity, LoginFlowManager loginFlowManager, LoginFlowState loginFlowState, AccountKitError accountKitError, @Nullable OnPushListener onPushListener) {
        this.uiManager.onError(accountKitError);
        pushState(accountKitActivity, loginFlowManager, loginFlowState, onPushListener);
    }

    void pushState(AccountKitActivity accountKitActivity, LoginFlowManager loginFlowManager, @Nullable OnPushListener onPushListener) {
        pushState(accountKitActivity, loginFlowManager, LoginFlowState.NONE, onPushListener);
    }

    void updateContentController(AccountKitActivity accountKitActivity) {
        ContentController contentControllerEnsureContentController;
        ContentFragment contentFragment = getContentFragment(accountKitActivity, R.id.com_accountkit_content_top_fragment);
        if (contentFragment == null || (contentControllerEnsureContentController = ensureContentController(accountKitActivity, contentFragment.getLoginFlowState(), LoginFlowState.NONE, true)) == null) {
            return;
        }
        this.contentController = contentControllerEnsureContentController;
        ArrayList arrayList = new ArrayList(this.onPopListeners);
        this.onPopListeners.clear();
        Iterator it2 = arrayList.iterator();
        while (it2.hasNext()) {
            ((OnPopListener) it2.next()).onContentPopped();
        }
        ArrayList arrayList2 = new ArrayList(this.onPushListeners);
        this.onPushListeners.clear();
        Iterator it3 = arrayList2.iterator();
        while (it3.hasNext()) {
            ((OnPushListener) it3.next()).onContentPushed();
        }
    }
}
