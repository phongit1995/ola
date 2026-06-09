package com.facebook.accountkit.ui;

import android.app.Activity;
import android.content.Intent;
import android.os.Handler;
import android.support.annotation.Nullable;
import android.support.v4.content.LocalBroadcastManager;
import android.view.View;
import com.facebook.accountkit.R;
import com.facebook.accountkit.ui.LoginFlowBroadcastReceiver;
import com.facebook.accountkit.ui.StaticContentFragmentFactory;
import com.facebook.accountkit.ui.TitleFragmentFactory;

/* JADX INFO: loaded from: classes.dex */
abstract class SentCodeContentController extends ContentControllerBase {
    static final int COMPLETION_UI_DURATION_MS = 2000;
    private StaticContentFragmentFactory.StaticContentFragment bottomFragment;
    private StaticContentFragmentFactory.StaticContentFragment centerFragment;

    @Nullable
    Handler delayedTransitionHandler;

    @Nullable
    Runnable delayedTransitionRunnable;
    private TitleFragmentFactory.TitleFragment footerFragment;
    private TitleFragmentFactory.TitleFragment headerFragment;
    private StaticContentFragmentFactory.StaticContentFragment textFragment;
    private StaticContentFragmentFactory.StaticContentFragment topFragment;

    SentCodeContentController(AccountKitConfiguration accountKitConfiguration) {
        super(accountKitConfiguration);
    }

    void cancelTransition() {
        if (this.delayedTransitionHandler == null || this.delayedTransitionRunnable == null) {
            return;
        }
        this.delayedTransitionHandler.removeCallbacks(this.delayedTransitionRunnable);
        this.delayedTransitionRunnable = null;
        this.delayedTransitionHandler = null;
    }

    @Override // com.facebook.accountkit.ui.ContentController
    public ContentFragment getBottomFragment() {
        if (this.bottomFragment == null) {
            setBottomFragment(StaticContentFragmentFactory.create(this.configuration.getUIManager(), getLoginFlowState()));
        }
        return this.bottomFragment;
    }

    @Override // com.facebook.accountkit.ui.ContentController
    public ContentFragment getCenterFragment() {
        if (this.centerFragment == null) {
            setCenterFragment(StaticContentFragmentFactory.create(this.configuration.getUIManager(), getLoginFlowState(), R.layout.com_accountkit_fragment_sent_code_center));
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
            setHeaderFragment(TitleFragmentFactory.create(this.configuration.getUIManager(), R.string.com_accountkit_sent_title, new String[0]));
        }
        return this.headerFragment;
    }

    @Override // com.facebook.accountkit.ui.ContentController
    public LoginFlowState getLoginFlowState() {
        return LoginFlowState.SENT_CODE;
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

    @Override // com.facebook.accountkit.ui.ContentControllerBase, com.facebook.accountkit.ui.ContentController
    public void onPause(Activity activity) {
        cancelTransition();
        super.onPause(activity);
    }

    @Override // com.facebook.accountkit.ui.ContentControllerBase, com.facebook.accountkit.ui.ContentController
    public void onResume(final Activity activity) {
        super.onResume(activity);
        cancelTransition();
        this.delayedTransitionHandler = new Handler();
        this.delayedTransitionRunnable = new Runnable() { // from class: com.facebook.accountkit.ui.SentCodeContentController.1
            @Override // java.lang.Runnable
            public void run() {
                LocalBroadcastManager.getInstance(activity).sendBroadcast(new Intent(LoginFlowBroadcastReceiver.ACTION_UPDATE).putExtra(LoginFlowBroadcastReceiver.EXTRA_EVENT, LoginFlowBroadcastReceiver.Event.SENT_CODE_COMPLETE));
                SentCodeContentController.this.delayedTransitionHandler = null;
                SentCodeContentController.this.delayedTransitionRunnable = null;
            }
        };
        this.delayedTransitionHandler.postDelayed(this.delayedTransitionRunnable, 2000L);
    }

    @Override // com.facebook.accountkit.ui.ContentController
    public void setBottomFragment(@Nullable ContentFragment contentFragment) {
        if (contentFragment instanceof StaticContentFragmentFactory.StaticContentFragment) {
            this.bottomFragment = (StaticContentFragmentFactory.StaticContentFragment) contentFragment;
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
