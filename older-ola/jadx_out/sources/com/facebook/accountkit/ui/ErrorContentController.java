package com.facebook.accountkit.ui;

import android.support.annotation.Nullable;
import android.view.View;
import com.facebook.accountkit.R;
import com.facebook.accountkit.internal.AccountKitController;
import com.facebook.accountkit.ui.StaticContentFragmentFactory;
import com.facebook.accountkit.ui.TitleFragmentFactory;

/* JADX INFO: loaded from: classes.dex */
abstract class ErrorContentController extends ContentControllerBase {
    private static final LoginFlowState LOGIN_FLOW_STATE = LoginFlowState.ERROR;
    private StaticContentFragmentFactory.StaticContentFragment centerFragment;
    private TitleFragmentFactory.TitleFragment footerFragment;
    private TitleFragmentFactory.TitleFragment headerFragment;
    private StaticContentFragmentFactory.StaticContentFragment textFragment;
    private StaticContentFragmentFactory.StaticContentFragment topFragment;

    ErrorContentController(AccountKitConfiguration accountKitConfiguration) {
        super(accountKitConfiguration);
    }

    @Override // com.facebook.accountkit.ui.ContentController
    public ContentFragment getCenterFragment() {
        if (this.centerFragment == null) {
            setCenterFragment(StaticContentFragmentFactory.create(this.configuration.getUIManager(), getLoginFlowState(), R.layout.com_accountkit_fragment_error_center));
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
            this.headerFragment = TitleFragmentFactory.create(this.configuration.getUIManager(), R.string.com_accountkit_error_title, new String[0]);
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
        AccountKitController.Logger.logUIError(true, this.configuration.getLoginType());
    }

    @Override // com.facebook.accountkit.ui.ContentController
    public void setCenterFragment(@Nullable ContentFragment contentFragment) {
        if (contentFragment instanceof StaticContentFragmentFactory.StaticContentFragment) {
            this.centerFragment = (StaticContentFragmentFactory.StaticContentFragment) contentFragment;
        }
    }

    void setErrorMessage(@Nullable String str) {
        if (this.headerFragment != null) {
            this.headerFragment.setTitle(str);
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
