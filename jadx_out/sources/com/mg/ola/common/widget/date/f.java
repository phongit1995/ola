package com.mg.ola.common.widget.date;

import android.content.Context;
import com.mg.ola.common.widget.date.ScrollPickerView;

/* JADX INFO: loaded from: classes2.dex */
class f {
    public static a a(Context context, ScrollPickerView.ScrollType scrollType) {
        switch (scrollType) {
            case Loop:
                return new c(context);
            case Ranged:
                return new e(context);
            case None:
                return new b(context);
            default:
                return null;
        }
    }
}
