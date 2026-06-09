package com.facebook.accountkit.ui;

import android.support.annotation.Nullable;
import android.telephony.PhoneNumberUtils;
import android.text.Editable;
import android.text.Selection;
import android.text.TextWatcher;
import com.google.i18n.phonenumbers.AsYouTypeFormatter;
import com.google.i18n.phonenumbers.PhoneNumberUtil;
import java.util.Locale;

/* JADX INFO: loaded from: classes.dex */
public class PhoneNumberTextWatcher implements TextWatcher {
    private AsYouTypeFormatter mFormatter;
    private boolean mSelfChange;

    public PhoneNumberTextWatcher() {
        this(Locale.getDefault().getCountry());
    }

    public PhoneNumberTextWatcher(String str) {
        this.mSelfChange = false;
        if (str == null) {
            throw new IllegalArgumentException();
        }
        this.mFormatter = PhoneNumberUtil.getInstance().getAsYouTypeFormatter(str);
    }

    private String getFormattedNumber(char c, boolean z) {
        return z ? this.mFormatter.inputDigitAndRememberPosition(c) : this.mFormatter.inputDigit(c);
    }

    @Nullable
    private String reformat(CharSequence charSequence, int i) {
        int i2 = i - 1;
        this.mFormatter.clear();
        int length = charSequence.length();
        String formattedNumber = null;
        char c = 0;
        boolean z = false;
        for (int i3 = 0; i3 < length; i3++) {
            char cCharAt = charSequence.charAt(i3);
            if (PhoneNumberUtils.isNonSeparator(cCharAt)) {
                if (c != 0) {
                    formattedNumber = getFormattedNumber(c, z);
                    z = false;
                }
                c = cCharAt;
            }
            if (i3 == i2) {
                z = true;
            }
        }
        return c != 0 ? getFormattedNumber(c, z) : formattedNumber;
    }

    @Override // android.text.TextWatcher
    public synchronized void afterTextChanged(Editable editable) {
        if (this.mSelfChange) {
            return;
        }
        String strReformat = reformat(editable, Selection.getSelectionEnd(editable));
        if (strReformat != null) {
            int rememberedPosition = this.mFormatter.getRememberedPosition();
            this.mSelfChange = true;
            editable.replace(0, editable.length(), strReformat, 0, strReformat.length());
            if (strReformat.equals(editable.toString())) {
                Selection.setSelection(editable, rememberedPosition);
            }
            this.mSelfChange = false;
        }
    }

    @Override // android.text.TextWatcher
    public synchronized void beforeTextChanged(CharSequence charSequence, int i, int i2, int i3) {
        if (this.mSelfChange) {
        }
    }

    @Override // android.text.TextWatcher
    public synchronized void onTextChanged(CharSequence charSequence, int i, int i2, int i3) {
        if (this.mSelfChange) {
        }
    }
}
