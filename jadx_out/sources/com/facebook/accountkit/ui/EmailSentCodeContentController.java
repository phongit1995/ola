package com.facebook.accountkit.ui;

import com.facebook.accountkit.internal.AccountKitController;

/* JADX INFO: loaded from: classes.dex */
final class EmailSentCodeContentController extends SentCodeContentController {
    EmailSentCodeContentController(AccountKitConfiguration accountKitConfiguration) {
        super(accountKitConfiguration);
    }

    @Override // com.facebook.accountkit.ui.ContentControllerBase
    protected void logImpression() {
        AccountKitController.Logger.logUISentCode(true, LoginType.EMAIL);
    }
}
