package chat.ola.vn.entry.b;

import android.app.Activity;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;
import chat.ola.vn.R;

/* JADX INFO: loaded from: classes.dex */
public class a {
    public ViewGroup a;
    public ImageView b;
    public ImageView c;
    public TextView d;
    public TextView e;

    public a(Activity activity) {
        this.b = (ImageView) activity.findViewById(R.id.btnActionButtonLeft);
        this.c = (ImageView) activity.findViewById(R.id.btnActionButtonRight);
        this.d = (TextView) activity.findViewById(R.id.txtActionTitle);
        this.e = (TextView) activity.findViewById(R.id.txtActionSubTitle);
        this.a = (ViewGroup) activity.findViewById(R.id.linearWrap);
    }
}
