package com.facebook.accountkit.ui;

/* JADX INFO: loaded from: classes.dex */
final class ActivityErrorHandler {
    private ActivityErrorHandler() {
    }

    static void onErrorRestart(AccountKitActivity accountKitActivity, LoginFlowState loginFlowState) {
        ContentController contentController = accountKitActivity.getContentController();
        if (contentController != null && (contentController instanceof LoginErrorContentController)) {
            accountKitActivity.onContentControllerDismissed(contentController);
        }
        accountKitActivity.popBackStack(loginFlowState, null);
    }
}
