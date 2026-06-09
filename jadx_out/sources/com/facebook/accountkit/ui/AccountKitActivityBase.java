package com.facebook.accountkit.ui;

import android.app.Fragment;
import android.app.FragmentManager;
import android.app.FragmentTransaction;
import android.graphics.Rect;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.app.AppCompatDelegate;
import android.view.View;
import com.facebook.accountkit.AccountKitError;
import com.facebook.accountkit.R;
import com.facebook.accountkit.internal.AccountKitController;
import com.facebook.accountkit.internal.InternalAccountKitError;
import com.facebook.accountkit.ui.KeyboardObserver;
import com.facebook.accountkit.ui.SkinManager;

/* JADX INFO: Access modifiers changed from: package-private */
/* JADX INFO: loaded from: classes.dex */
public abstract class AccountKitActivityBase extends AppCompatActivity {
    public static final String ACCOUNT_KIT_ACTIVITY_CONFIGURATION = AccountKitConfiguration.TAG;
    private static final String TAG = AccountKitUpdateActivity.class.getSimpleName();
    private static final String VIEW_STATE_KEY = TAG + ".viewState";

    @Nullable
    AccountKitConfiguration configuration;
    AccountKitError error;
    private KeyboardObserver keyboardObserver;
    UIManager uiManager;
    private final Bundle viewState = new Bundle();

    AccountKitActivityBase() {
    }

    void ensureNextButton(ContentController contentController) {
        int i;
        if (ViewUtility.isSkin(this.uiManager, SkinManager.Skin.CONTEMPORARY)) {
            FragmentManager fragmentManager = getFragmentManager();
            if (contentController == null) {
                FragmentTransaction fragmentTransactionBeginTransaction = fragmentManager.beginTransaction();
                if (remove(fragmentTransactionBeginTransaction, R.id.com_accountkit_content_bottom_fragment) == null) {
                    remove(fragmentTransactionBeginTransaction, R.id.com_accountkit_content_bottom_keyboard_fragment);
                }
                fragmentTransactionBeginTransaction.commit();
                return;
            }
            ContentFragment bottomFragment = contentController.getBottomFragment();
            FragmentTransaction fragmentTransactionBeginTransaction2 = fragmentManager.beginTransaction();
            if (bottomFragment.isKeyboardFragment()) {
                remove(fragmentTransactionBeginTransaction2, R.id.com_accountkit_content_bottom_fragment);
                i = R.id.com_accountkit_content_bottom_keyboard_fragment;
            } else {
                remove(fragmentTransactionBeginTransaction2, R.id.com_accountkit_content_bottom_keyboard_fragment);
                i = R.id.com_accountkit_content_bottom_fragment;
            }
            replace(fragmentTransactionBeginTransaction2, i, bottomFragment);
            fragmentTransactionBeginTransaction2.commit();
        }
    }

    @Override // android.support.v7.app.AppCompatActivity, android.support.v4.app.FragmentActivity, android.support.v4.app.SupportActivity, android.app.Activity
    public void onCreate(@Nullable Bundle bundle) {
        super.onCreate(bundle);
        this.configuration = (AccountKitConfiguration) getIntent().getParcelableExtra(ACCOUNT_KIT_ACTIVITY_CONFIGURATION);
        if (this.configuration == null) {
            this.error = new AccountKitError(AccountKitError.Type.INITIALIZATION_ERROR, InternalAccountKitError.INVALID_INTENT_EXTRAS_CONFIGURATION);
            sendResult();
            return;
        }
        this.uiManager = this.configuration.getUIManager();
        if (!ViewUtility.doesTextColorContrast(this, this.configuration.getUIManager())) {
            AccountKitController.Logger.logInvalidUIManager();
            this.error = new AccountKitError(AccountKitError.Type.INITIALIZATION_ERROR, InternalAccountKitError.INVALID_BACKGROUND_CONTRACT);
            sendResult();
            return;
        }
        int themeId = this.configuration.getUIManager().getThemeId();
        if (themeId != -1) {
            setTheme(themeId);
        }
        AppCompatDelegate.setCompatVectorFromResourcesEnabled(true);
        if (!ViewUtility.isTablet(this)) {
            setRequestedOrientation(1);
        }
        setContentView(R.layout.com_accountkit_activity_layout);
        final ConstrainedLinearLayout constrainedLinearLayout = (ConstrainedLinearLayout) findViewById(R.id.com_accountkit_content_view);
        View viewFindViewById = findViewById(R.id.com_accountkit_scroll_view);
        if (constrainedLinearLayout != null && viewFindViewById != null && constrainedLinearLayout.getMinHeight() < 0 && constrainedLinearLayout.getRootView() != null) {
            this.keyboardObserver = new KeyboardObserver(viewFindViewById);
            this.keyboardObserver.setOnVisibleFrameChangedListener(new KeyboardObserver.OnVisibleFrameChangedListener() { // from class: com.facebook.accountkit.ui.AccountKitActivityBase.1
                @Override // com.facebook.accountkit.ui.KeyboardObserver.OnVisibleFrameChangedListener
                public void onVisibleFrameChanged(Rect rect) {
                    int iHeight = rect.height();
                    if (iHeight >= 0) {
                        constrainedLinearLayout.setMinHeight(iHeight);
                    }
                }
            });
        }
        if (bundle != null) {
            this.viewState.putAll(bundle.getBundle(VIEW_STATE_KEY));
        }
        ViewUtility.applyThemeBackground(this, this.configuration.getUIManager(), findViewById(R.id.com_accountkit_background));
    }

    @Override // android.support.v7.app.AppCompatActivity, android.support.v4.app.FragmentActivity, android.app.Activity
    protected void onDestroy() {
        super.onDestroy();
        if (this.keyboardObserver != null) {
            this.keyboardObserver.setOnVisibleFrameChangedListener(null);
            this.keyboardObserver = null;
        }
    }

    @Override // android.support.v7.app.AppCompatActivity, android.support.v4.app.FragmentActivity, android.support.v4.app.SupportActivity, android.app.Activity
    protected void onSaveInstanceState(Bundle bundle) {
        bundle.putBundle(VIEW_STATE_KEY, this.viewState);
        super.onSaveInstanceState(bundle);
    }

    Fragment remove(FragmentTransaction fragmentTransaction, int i) {
        Fragment fragmentFindFragmentById = getFragmentManager().findFragmentById(i);
        if (fragmentFindFragmentById != null) {
            fragmentTransaction.remove(fragmentFindFragmentById);
        }
        return fragmentFindFragmentById;
    }

    void replace(FragmentTransaction fragmentTransaction, int i, Fragment fragment) {
        if (getFragmentManager().findFragmentById(i) != fragment) {
            fragmentTransaction.replace(i, fragment);
        }
    }

    abstract void sendResult();
}
