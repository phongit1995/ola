package chat.ola.vn.entry.b;

import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import chat.ola.vn.R;

/* JADX INFO: loaded from: classes.dex */
public class i {
    /* JADX WARN: Multi-variable type inference failed */
    /* JADX WARN: Type inference failed for: r2v0 */
    /* JADX WARN: Type inference failed for: r2v1, types: [chat.ola.vn.entry.b.j] */
    /* JADX WARN: Type inference failed for: r2v2, types: [chat.ola.vn.entry.b.j, java.lang.Object] */
    /* JADX WARN: Type inference failed for: r2v3 */
    /* JADX WARN: Type inference failed for: r2v4 */
    /* JADX WARN: Type inference failed for: r4v0, types: [android.view.View] */
    /* JADX WARN: Type inference failed for: r4v1, types: [android.view.View] */
    /* JADX WARN: Type inference failed for: r4v11 */
    /* JADX WARN: Type inference failed for: r4v12 */
    /* JADX WARN: Type inference failed for: r4v13 */
    /* JADX WARN: Type inference failed for: r4v14 */
    /* JADX WARN: Type inference failed for: r4v15 */
    /* JADX WARN: Type inference failed for: r4v16 */
    /* JADX WARN: Type inference failed for: r4v17 */
    /* JADX WARN: Type inference failed for: r4v18 */
    /* JADX WARN: Type inference failed for: r4v9 */
    public static j a(int i, View view, LayoutInflater layoutInflater) {
        Object abVar;
        ?? r2 = 0;
        r2 = 0;
        try {
            switch (i) {
                case 0:
                    View viewInflate = layoutInflater.inflate(R.layout.me_entry_layout, (ViewGroup) null);
                    abVar = new ab(viewInflate, 0);
                    view = viewInflate;
                    r2 = abVar;
                    r2.a(view);
                    view.setTag(r2);
                    return r2;
                case 1:
                    View viewInflate2 = layoutInflater.inflate(R.layout.me_entry_layout, (ViewGroup) null);
                    abVar = new ab(viewInflate2, R.layout.me_attached_media_layout);
                    view = viewInflate2;
                    r2 = abVar;
                    r2.a(view);
                    view.setTag(r2);
                    return r2;
                case 2:
                case 6:
                default:
                    r2.a(view);
                    view.setTag(r2);
                    return r2;
                case 3:
                    View viewInflate3 = layoutInflater.inflate(R.layout.me_entry_youtube_me_layout, (ViewGroup) null);
                    abVar = new y(viewInflate3, 0);
                    view = viewInflate3;
                    r2 = abVar;
                    r2.a(view);
                    view.setTag(r2);
                    return r2;
                case 4:
                    View viewInflate4 = layoutInflater.inflate(R.layout.me_entry_advertisment_general_me_layout, (ViewGroup) null);
                    abVar = new w();
                    view = viewInflate4;
                    r2 = abVar;
                    r2.a(view);
                    view.setTag(r2);
                    return r2;
                case 5:
                    View viewInflate5 = layoutInflater.inflate(R.layout.me_entry_advertisment_software_me_layout, (ViewGroup) null);
                    abVar = new x();
                    view = viewInflate5;
                    r2 = abVar;
                    r2.a(view);
                    view.setTag(r2);
                    return r2;
                case 7:
                    View viewInflate6 = layoutInflater.inflate(R.layout.me_entry_history_story_layout, (ViewGroup) null);
                    abVar = new z();
                    view = viewInflate6;
                    r2 = abVar;
                    r2.a(view);
                    view.setTag(r2);
                    return r2;
                case 8:
                    View viewInflate7 = layoutInflater.inflate(R.layout.me_entry_suggested_friend_layout, (ViewGroup) null);
                    abVar = new aa();
                    view = viewInflate7;
                    r2 = abVar;
                    r2.a(view);
                    view.setTag(r2);
                    return r2;
                case 9:
                    View viewInflate8 = layoutInflater.inflate(R.layout.ola_me_entry_top_post, (ViewGroup) null);
                    abVar = new ac();
                    view = viewInflate8;
                    r2 = abVar;
                    r2.a(view);
                    view.setTag(r2);
                    return r2;
            }
        } catch (Throwable th) {
            th.printStackTrace();
            return r2;
        }
        th.printStackTrace();
        return r2;
    }
}
