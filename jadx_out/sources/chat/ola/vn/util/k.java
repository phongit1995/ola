package chat.ola.vn.util;

import android.content.Context;
import android.graphics.Color;
import android.graphics.drawable.ColorDrawable;
import android.widget.AdapterView;
import android.widget.ListAdapter;
import chat.ola.vn.R;

/* JADX INFO: loaded from: classes.dex */
public class k {
    public static com.mg.ola.common.widget.b a(Context context, ListAdapter listAdapter, AdapterView.OnItemClickListener onItemClickListener) {
        com.mg.ola.common.widget.b bVar = new com.mg.ola.common.widget.b(context);
        bVar.d(R.drawable.abs__menu_dropdown_panel_holo_dark);
        bVar.a(new ColorDrawable(Color.parseColor("#14ffffff")));
        bVar.g(1);
        bVar.a(listAdapter);
        bVar.d(true);
        bVar.f(context.getResources().getDimensionPixelSize(R.dimen.general_popup_width_min));
        bVar.a(onItemClickListener);
        return bVar;
    }
}
