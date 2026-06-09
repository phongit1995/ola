package chat.ola.vn.b;

import android.content.Context;
import android.text.SpannableStringBuilder;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.BaseAdapter;
import android.widget.ImageView;
import android.widget.TextView;
import chat.ola.vn.R;

/* JADX INFO: loaded from: classes.dex */
public class af extends BaseAdapter {
    protected LayoutInflater a;
    private boolean b = true;
    private chat.ola.vn.r.a.f c;
    private Context d;

    private class a {
        ImageView a;
        TextView b;
        TextView c;
        View d;

        a(View view) {
            this.d = view;
            this.a = (ImageView) this.d.findViewById(R.id.imgRoomIcon);
            this.b = (TextView) this.d.findViewById(R.id.txtItemTitle);
            this.c = (TextView) this.d.findViewById(R.id.txtItemSubTitle);
            this.d.setTag(this);
        }

        public void a(chat.ola.vn.entity.s sVar) {
            TextView textView;
            String strF;
            this.b.setText(sVar.d());
            SpannableStringBuilder spannableStringBuilder = new SpannableStringBuilder("(" + af.this.d.getString(R.string.message_room_member_count, chat.ola.vn.util.m.a(sVar.a())) + ") ");
            spannableStringBuilder.setSpan(Integer.valueOf(chat.ola.vn.f.z), 0, spannableStringBuilder.length(), 33);
            this.c.setText(spannableStringBuilder);
            if (chat.ola.vn.util.m.a(sVar.f())) {
                textView = this.c;
                strF = " ";
            } else {
                textView = this.c;
                strF = sVar.f();
            }
            textView.append(strF);
            if (sVar.c() != -1) {
                this.a.setVisibility(8);
            } else {
                this.a.setVisibility(0);
                this.a.setImageResource(R.drawable.ic_media_map);
            }
        }
    }

    public af(Context context, chat.ola.vn.r.a.f fVar) {
        this.c = fVar;
        this.d = context;
        this.a = LayoutInflater.from(context);
    }

    public void a(boolean z) {
        this.b = z;
    }

    @Override // android.widget.Adapter
    public int getCount() {
        try {
            return this.c.g() + (this.b ? 1 : 0);
        } catch (Throwable th) {
            th.printStackTrace();
            return 1;
        }
    }

    @Override // android.widget.Adapter
    public Object getItem(int i) {
        if (!this.b) {
            return this.c.c(i);
        }
        try {
            return i == 0 ? this.c.p() : this.c.c(i - 1);
        } catch (Throwable th) {
            th.printStackTrace();
            return null;
        }
    }

    @Override // android.widget.Adapter
    public long getItemId(int i) {
        return i;
    }

    @Override // android.widget.BaseAdapter, android.widget.Adapter
    public int getItemViewType(int i) {
        return (this.b && i == 0) ? 1 : 0;
    }

    /* JADX WARN: Multi-variable type inference failed */
    /* JADX WARN: Removed duplicated region for block: B:22:0x0042 A[Catch: Throwable -> 0x0059, TRY_ENTER, TRY_LEAVE, TryCatch #2 {Throwable -> 0x0059, blocks: (B:22:0x0042, B:29:0x005b), top: B:46:0x0040 }] */
    /* JADX WARN: Removed duplicated region for block: B:29:0x005b A[Catch: Throwable -> 0x0059, TRY_ENTER, TRY_LEAVE, TryCatch #2 {Throwable -> 0x0059, blocks: (B:22:0x0042, B:29:0x005b), top: B:46:0x0040 }] */
    /* JADX WARN: Removed duplicated region for block: B:33:0x006a A[Catch: Throwable -> 0x0056, TRY_LEAVE, TryCatch #1 {Throwable -> 0x0056, blocks: (B:23:0x004b, B:31:0x0064, B:33:0x006a), top: B:44:0x004b }] */
    /* JADX WARN: Removed duplicated region for block: B:37:0x0075 A[RETURN] */
    /* JADX WARN: Removed duplicated region for block: B:38:0x0076  */
    /* JADX WARN: Type inference failed for: r0v10 */
    /* JADX WARN: Type inference failed for: r0v11, types: [android.view.View] */
    /* JADX WARN: Type inference failed for: r0v13, types: [android.view.View] */
    /* JADX WARN: Type inference failed for: r0v14 */
    /* JADX WARN: Type inference failed for: r0v9 */
    /* JADX WARN: Type inference failed for: r7v10 */
    /* JADX WARN: Type inference failed for: r7v11 */
    /* JADX WARN: Type inference failed for: r7v12 */
    /* JADX WARN: Type inference failed for: r7v13, types: [chat.ola.vn.b.af$a] */
    /* JADX WARN: Type inference failed for: r7v16, types: [android.view.View] */
    /* JADX WARN: Type inference failed for: r7v18 */
    /* JADX WARN: Type inference failed for: r7v19 */
    /* JADX WARN: Type inference failed for: r7v20 */
    /* JADX WARN: Type inference failed for: r7v21 */
    /* JADX WARN: Type inference failed for: r7v3 */
    /* JADX WARN: Type inference failed for: r7v8, types: [android.view.View] */
    /* JADX WARN: Type inference failed for: r7v9 */
    @Override // android.widget.Adapter
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public android.view.View getView(int r6, android.view.View r7, android.view.ViewGroup r8) {
        /*
            r5 = this;
            int r0 = r5.getItemViewType(r6)
            r1 = 0
            switch(r0) {
                case 0: goto La;
                case 1: goto L40;
                default: goto L8;
            }
        L8:
            goto L73
        La:
            java.lang.Object r0 = r5.getItem(r6)     // Catch: java.lang.Throwable -> L39
            chat.ola.vn.message.f r0 = (chat.ola.vn.message.f) r0     // Catch: java.lang.Throwable -> L39
            if (r7 != 0) goto L26
            android.view.LayoutInflater r2 = r5.a     // Catch: java.lang.Throwable -> L39
            r3 = 2131427445(0x7f0b0075, float:1.8476506E38)
            android.view.View r2 = r2.inflate(r3, r1)     // Catch: java.lang.Throwable -> L39
            chat.ola.vn.g.k r7 = new chat.ola.vn.g.k     // Catch: java.lang.Throwable -> L24
            r7.<init>(r0, r2)     // Catch: java.lang.Throwable -> L24
            r2.setTag(r7)     // Catch: java.lang.Throwable -> L24
            goto L2e
        L24:
            r7 = move-exception
            goto L3c
        L26:
            java.lang.Object r0 = r7.getTag()     // Catch: java.lang.Throwable -> L39
            chat.ola.vn.g.k r0 = (chat.ola.vn.g.k) r0     // Catch: java.lang.Throwable -> L39
            r2 = r7
            r7 = r0
        L2e:
            if (r7 == 0) goto L38
            r0 = 1
            r7.k = r0     // Catch: java.lang.Throwable -> L24
            r7.l = r0     // Catch: java.lang.Throwable -> L24
            r7.b(r6)     // Catch: java.lang.Throwable -> L24
        L38:
            return r2
        L39:
            r0 = move-exception
            r2 = r7
            r7 = r0
        L3c:
            r7.printStackTrace()
            r7 = r2
        L40:
            if (r7 != 0) goto L5b
            android.view.LayoutInflater r0 = r5.a     // Catch: java.lang.Throwable -> L59
            r2 = 2131427512(0x7f0b00b8, float:1.8476642E38)
            android.view.View r0 = r0.inflate(r2, r1)     // Catch: java.lang.Throwable -> L59
            int r7 = chat.ola.vn.f.r     // Catch: java.lang.Throwable -> L56
            r0.setBackgroundColor(r7)     // Catch: java.lang.Throwable -> L56
            chat.ola.vn.b.af$a r7 = new chat.ola.vn.b.af$a     // Catch: java.lang.Throwable -> L56
            r7.<init>(r0)     // Catch: java.lang.Throwable -> L56
            goto L64
        L56:
            r6 = move-exception
            r7 = r0
            goto L70
        L59:
            r6 = move-exception
            goto L70
        L5b:
            java.lang.Object r0 = r7.getTag()     // Catch: java.lang.Throwable -> L59
            chat.ola.vn.b.af$a r0 = (chat.ola.vn.b.af.a) r0     // Catch: java.lang.Throwable -> L59
            r4 = r0
            r0 = r7
            r7 = r4
        L64:
            java.lang.Object r6 = r5.getItem(r6)     // Catch: java.lang.Throwable -> L56
            if (r6 == 0) goto L6f
            chat.ola.vn.entity.s r6 = (chat.ola.vn.entity.s) r6     // Catch: java.lang.Throwable -> L56
            r7.a(r6)     // Catch: java.lang.Throwable -> L56
        L6f:
            return r0
        L70:
            r6.printStackTrace()
        L73:
            if (r7 == 0) goto L76
            return r7
        L76:
            if (r8 == 0) goto L79
            return r8
        L79:
            android.view.View r6 = new android.view.View
            android.content.Context r7 = r5.d
            r6.<init>(r7)
            return r6
        */
        throw new UnsupportedOperationException("Method not decompiled: chat.ola.vn.b.af.getView(int, android.view.View, android.view.ViewGroup):android.view.View");
    }

    @Override // android.widget.BaseAdapter, android.widget.Adapter
    public int getViewTypeCount() {
        return this.b ? 2 : 1;
    }
}
