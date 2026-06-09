package com.facebook.accountkit.ui;

import android.support.annotation.Nullable;
import android.view.View;
import com.facebook.accountkit.AccountKitError;
import com.facebook.accountkit.AccountKitException;
import com.facebook.accountkit.R;
import com.facebook.accountkit.internal.AccountKitController;
import com.facebook.accountkit.internal.InternalAccountKitError;
import com.facebook.accountkit.ui.StaticContentFragmentFactory;
import com.facebook.accountkit.ui.TitleFragmentFactory;

/* JADX INFO: loaded from: classes.dex */
final class SendingCodeContentController extends ContentControllerBase {
    private StaticContentFragmentFactory.StaticContentFragment bottomFragment;
    private StaticContentFragmentFactory.StaticContentFragment centerFragment;
    private TitleFragmentFactory.TitleFragment footerFragment;
    private TitleFragmentFactory.TitleFragment headerFragment;
    private StaticContentFragmentFactory.StaticContentFragment textFragment;
    private StaticContentFragmentFactory.StaticContentFragment topFragment;

    SendingCodeContentController(AccountKitConfiguration accountKitConfiguration) {
        super(accountKitConfiguration);
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
            setCenterFragment(StaticContentFragmentFactory.create(this.configuration.getUIManager(), getLoginFlowState(), R.layout.com_accountkit_fragment_sending_code_center));
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
        int i;
        if (this.headerFragment == null) {
            switch (this.configuration.getLoginType()) {
                case EMAIL:
                    i = R.string.com_accountkit_email_loading_title;
                    break;
                case PHONE:
                    i = R.string.com_accountkit_phone_loading_title;
                    break;
                default:
                    throw new AccountKitException(AccountKitError.Type.INTERNAL_ERROR, InternalAccountKitError.UNEXPECTED_STATE);
            }
            setHeaderFragment(TitleFragmentFactory.create(this.configuration.getUIManager(), i, new String[0]));
        }
        return this.headerFragment;
    }

    @Override // com.facebook.accountkit.ui.ContentController
    public LoginFlowState getLoginFlowState() {
        return LoginFlowState.SENDING_CODE;
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
        AccountKitController.Logger.logUISendingCode(true, this.configuration.getLoginType());
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
