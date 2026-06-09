package com.facebook.accountkit.ui;

import android.app.Fragment;
import android.app.FragmentTransaction;
import android.content.Intent;
import android.content.IntentFilter;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.v4.content.LocalBroadcastManager;
import android.view.KeyEvent;
import android.view.MenuItem;
import com.facebook.accountkit.AccountKitUpdateResult;
import com.facebook.accountkit.R;
import com.facebook.accountkit.internal.AccountKitController;
import com.facebook.accountkit.ui.SkinManager;
import com.facebook.accountkit.ui.UIManager;

/* JADX INFO: loaded from: classes.dex */
public final class AccountKitUpdateActivity extends AccountKitActivityBase implements UIManager.UIManagerListener {
    private static final IntentFilter UPDATE_FLOW_BROADCAST_RECEIVER_FILTER = UpdateStateStackManager.getIntentFilter();
    private String finalUpdateState;
    private AccountKitUpdateResult.UpdateResult result = AccountKitUpdateResult.UpdateResult.CANCELLED;
    private UpdateStateStackManager updateStateStackManager;

    private void sendResult(int i, AccountKitUpdateResultImpl accountKitUpdateResultImpl) {
        Intent intent = new Intent();
        intent.putExtra(AccountKitUpdateResult.RESULT_KEY, accountKitUpdateResultImpl);
        setResult(i, intent);
        finish();
    }

    @Override // android.support.v4.app.FragmentActivity, android.app.Activity
    protected void onActivityResult(int i, int i2, Intent intent) {
        super.onActivityResult(i, i2, intent);
        ContentController contentController = this.updateStateStackManager.getContentController();
        if (contentController != null) {
            contentController.onActivityResult(i, i2, intent);
        }
    }

    @Override // com.facebook.accountkit.ui.UIManager.UIManagerListener
    public void onBack() {
        onBackPressed();
    }

    @Override // android.support.v4.app.FragmentActivity, android.app.Activity
    public void onBackPressed() {
        if (this.updateStateStackManager.getContentController() == null) {
            super.onBackPressed();
        } else {
            this.updateStateStackManager.popState();
        }
    }

    @Override // com.facebook.accountkit.ui.UIManager.UIManagerListener
    public void onCancel() {
        sendCancelResult();
    }

    @Override // com.facebook.accountkit.ui.AccountKitActivityBase, android.support.v7.app.AppCompatActivity, android.support.v4.app.FragmentActivity, android.support.v4.app.SupportActivity, android.app.Activity
    public void onCreate(@Nullable Bundle bundle) {
        super.onCreate(bundle);
        this.uiManager.setUIManagerListener(this);
        this.updateStateStackManager = new UpdateStateStackManager(this, this.configuration);
        AccountKitController.onUpdateActivityCreate(this, bundle);
        LocalBroadcastManager.getInstance(this).registerReceiver(this.updateStateStackManager, UPDATE_FLOW_BROADCAST_RECEIVER_FILTER);
    }

    @Override // com.facebook.accountkit.ui.AccountKitActivityBase, android.support.v7.app.AppCompatActivity, android.support.v4.app.FragmentActivity, android.app.Activity
    protected void onDestroy() {
        LocalBroadcastManager.getInstance(this).unregisterReceiver(this.updateStateStackManager);
        super.onDestroy();
        AccountKitController.onUpdateActivityDestroy(this);
    }

    @Override // android.support.v7.app.AppCompatActivity, android.app.Activity, android.view.KeyEvent.Callback
    public boolean onKeyDown(int i, KeyEvent keyEvent) {
        if (i != 4) {
            return super.onKeyDown(i, keyEvent);
        }
        onBackPressed();
        return true;
    }

    @Override // android.app.Activity
    public boolean onOptionsItemSelected(MenuItem menuItem) {
        if (menuItem.getItemId() != 16908332) {
            return super.onOptionsItemSelected(menuItem);
        }
        onBackPressed();
        return true;
    }

    @Override // android.support.v4.app.FragmentActivity, android.app.Activity
    protected void onPause() {
        super.onPause();
        ContentController contentController = this.updateStateStackManager.getContentController();
        if (contentController != null) {
            contentController.onPause(this);
        }
    }

    @Override // android.support.v4.app.FragmentActivity, android.app.Activity
    protected void onResume() {
        super.onResume();
        ContentController contentController = this.updateStateStackManager.getContentController();
        if (contentController != null) {
            contentController.onResume(this);
        }
    }

    @Override // com.facebook.accountkit.ui.AccountKitActivityBase, android.support.v7.app.AppCompatActivity, android.support.v4.app.FragmentActivity, android.support.v4.app.SupportActivity, android.app.Activity
    protected void onSaveInstanceState(Bundle bundle) {
        AccountKitController.onUpdateActivitySaveInstanceState(this, bundle);
        super.onSaveInstanceState(bundle);
    }

    void sendCancelResult() {
        sendResult(0, new AccountKitUpdateResultImpl(null, null, true));
    }

    @Override // com.facebook.accountkit.ui.AccountKitActivityBase
    void sendResult() {
        sendResult(this.result == AccountKitUpdateResult.UpdateResult.SUCCESS ? -1 : 0, new AccountKitUpdateResultImpl(this.finalUpdateState, this.error, false));
    }

    void setFinalUpdateState(String str) {
        this.finalUpdateState = str;
    }

    void setUpdateResult(AccountKitUpdateResult.UpdateResult updateResult) {
        this.result = updateResult;
    }

    void updateUI(UpdateFlowState updateFlowState, ContentController contentController) {
        Fragment headerFragment = (updateFlowState == UpdateFlowState.CODE_INPUT_ERROR || updateFlowState == UpdateFlowState.PHONE_NUMBER_INPUT_ERROR) ? contentController.getHeaderFragment() : BaseUIManager.getDefaultHeaderFragment(this.uiManager, updateFlowState);
        Fragment defaultBodyFragment = BaseUIManager.getDefaultBodyFragment(this.uiManager, updateFlowState);
        Fragment defaultFooterFragment = BaseUIManager.getDefaultFooterFragment(this.uiManager);
        ContentFragment topFragment = contentController.getTopFragment();
        ContentFragment textFragment = contentController.getTextFragment();
        ContentFragment bottomFragment = contentController.getBottomFragment();
        if (textFragment != null) {
            int dimensionPixelSize = getResources().getDimensionPixelSize(R.dimen.com_accountkit_vertical_spacer_small_height);
            if (textFragment instanceof TextContentFragment) {
                TextContentFragment textContentFragment = (TextContentFragment) textFragment;
                textContentFragment.setContentPaddingTop(dimensionPixelSize);
                textContentFragment.setContentPaddingBottom(0);
            }
        }
        ensureNextButton(contentController);
        FragmentTransaction fragmentTransactionBeginTransaction = getFragmentManager().beginTransaction();
        replace(fragmentTransactionBeginTransaction, R.id.com_accountkit_header_fragment, headerFragment);
        replace(fragmentTransactionBeginTransaction, R.id.com_accountkit_content_top_fragment, topFragment);
        replace(fragmentTransactionBeginTransaction, R.id.com_accountkit_content_top_text_fragment, null);
        replace(fragmentTransactionBeginTransaction, R.id.com_accountkit_content_center_fragment, defaultBodyFragment);
        replace(fragmentTransactionBeginTransaction, R.id.com_accountkit_content_bottom_text_fragment, textFragment);
        if (!ViewUtility.isSkin(this.uiManager, SkinManager.Skin.CONTEMPORARY)) {
            replace(fragmentTransactionBeginTransaction, R.id.com_accountkit_content_bottom_fragment, bottomFragment);
            replace(fragmentTransactionBeginTransaction, R.id.com_accountkit_footer_fragment, defaultFooterFragment);
        }
        fragmentTransactionBeginTransaction.addToBackStack(null);
        ViewUtility.hideKeyboard(this);
        fragmentTransactionBeginTransaction.commit();
        contentController.onResume(this);
    }
}
