package com.mg.ola.common.widget.date;

import android.content.Context;
import android.util.AttributeSet;
import chat.ola.vn.R;
import com.mg.ola.common.widget.date.ScrollPickerView;
import java.text.SimpleDateFormat;
import java.util.Date;

/* JADX INFO: loaded from: classes2.dex */
public class DateScrollPickerView extends ScrollPickerView {
    protected int a;
    protected int b;
    protected int c;
    private SimpleDateFormat d;

    public DateScrollPickerView(Context context) {
        super(context);
        a();
    }

    public DateScrollPickerView(Context context, AttributeSet attributeSet) {
        super(context, attributeSet);
        a();
    }

    protected void a() {
        this.d = new SimpleDateFormat("dd/MM/yyyy");
        a(getResources().getStringArray(R.array.scroll_picker_day_list), 5.0f, ScrollPickerView.ScrollType.Loop);
        a(new String[]{"/"}, 2.0f, ScrollPickerView.ScrollType.None);
        a(getResources().getStringArray(R.array.com_ttshrk_view_scroll_picker_month_list), 5.0f, ScrollPickerView.ScrollType.Loop);
        a(new String[]{"/"}, 2.0f, ScrollPickerView.ScrollType.None);
        a(getResources().getStringArray(R.array.com_ttshrk_view_scroll_picker_year_list), 10.0f, ScrollPickerView.ScrollType.Ranged);
        this.c = 0;
        this.b = 2;
        this.a = 4;
    }

    public void a(int i, boolean z) {
        if (z) {
            b(this.a, i - 1970);
        } else {
            a(this.a, i - 1970);
        }
    }

    public void b(int i, boolean z) {
        if (z) {
            b(this.b, i - 1);
        } else {
            a(this.b, i - 1);
        }
    }

    public void c(int i, boolean z) {
        if (z) {
            b(this.c, i - 1);
        } else {
            a(this.c, i - 1);
        }
    }

    public int getDay() {
        return a(this.c) + 1;
    }

    public int getMonth() {
        return a(this.b) + 1;
    }

    public int getYear() {
        return a(this.a) + 1970;
    }

    public void setCurrentDate(boolean z) {
        String[] strArrSplit = this.d.format(new Date()).split("/");
        a(Integer.parseInt(strArrSplit[0]), z);
        b(Integer.parseInt(strArrSplit[1]), z);
        c(Integer.parseInt(strArrSplit[2]), z);
    }
}
