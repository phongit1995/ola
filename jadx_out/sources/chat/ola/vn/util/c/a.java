package chat.ola.vn.util.c;

import android.media.RingtoneManager;
import android.net.Uri;
import android.support.v7.widget.helper.ItemTouchHelper;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;

/* JADX INFO: loaded from: classes.dex */
public interface a {
    public static final Uri A;
    public static final Uri B;
    public static final Uri g_;
    public static final Uri h_;
    public static final Uri i;
    public static final Uri j;
    public static final Uri k;
    public static final Uri l;
    public static final Uri o;
    public static final Uri p;
    public static final Uri q;
    public static final Uri r;
    public static final Uri s;
    public static final Uri t;
    public static final Uri u;
    public static final Uri v;
    public static final Uri w;
    public static final Uri x;
    public static final Uri y;
    public static final Uri z;
    public static final long[] a = {0, 300};
    public static final long[] b = {0, 100};
    public static final long[] c = {0, 150};
    public static final int[] d = {800, ItemTouchHelper.Callback.DEFAULT_DRAG_ANIMATION_DURATION};
    public static final int[] e = {500, 500};
    public static final int[] f = {500, 500};
    public static final int[] g = {ItemTouchHelper.Callback.DEFAULT_SWIPE_ANIMATION_DURATION, ItemTouchHelper.Callback.DEFAULT_SWIPE_ANIMATION_DURATION};
    public static final String h = "android.resource://" + OlaApplication.f() + "/";

    static {
        StringBuilder sb = new StringBuilder();
        sb.append(h);
        sb.append(R.raw.incomming_message);
        i = Uri.parse(sb.toString());
        j = RingtoneManager.getDefaultUri(2);
        k = Uri.parse(h + R.raw.ola_buzz);
        l = Uri.parse(h + R.raw.incomming_message_light);
        g_ = Uri.parse(h + R.raw.push_to_talk);
        h_ = Uri.parse(h + R.raw.me_notification);
        o = Uri.parse(h + R.raw.post_me_fail);
        p = Uri.parse(h + R.raw.post_me_success);
        q = Uri.parse(h + R.raw.login_success);
        r = Uri.parse(h + R.raw.ola_knock);
        s = Uri.parse(h + R.raw.pull_down);
        t = Uri.parse(h + R.raw.refresh_ok);
        u = Uri.parse(h + R.raw.like_me);
        v = Uri.parse(h + R.raw.kiss);
        w = Uri.parse(h + R.raw.camera_shutter_sound);
        x = Uri.parse(h + R.raw.camera_send);
        y = Uri.parse(h + R.raw.sticker_pop);
        z = Uri.parse(h + R.raw.flying_move);
        A = Uri.parse(h + R.raw.ken_received);
        B = Uri.parse(h + R.raw.ken_sent);
    }
}
