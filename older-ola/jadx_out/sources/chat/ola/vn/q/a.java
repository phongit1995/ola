package chat.ola.vn.q;

import android.graphics.Bitmap;
import android.net.Uri;
import android.text.style.ClickableSpan;
import android.view.View;
import android.widget.AdapterView;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import chat.ola.vn.activity.OlaImageViewerActivity;
import chat.ola.vn.c;
import chat.ola.vn.entity.ab;
import chat.ola.vn.entity.i;
import chat.ola.vn.entity.n;
import chat.ola.vn.m.j;
import chat.ola.vn.me.OlaUserMePageActivity;
import chat.ola.vn.mediastore.OlaMediaEntity;
import chat.ola.vn.message.d;
import chat.ola.vn.message.p;
import chat.ola.vn.message.r;
import chat.ola.vn.network.OlaNetworkService;
import chat.ola.vn.util.m;
import chat.ola.vn.util.o;
import com.mg.ola.common.widget.OlaTextView;
import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

/* JADX INFO: loaded from: classes.dex */
public class a implements View.OnClickListener, View.OnLongClickListener, OlaTextView.b {
    private static a a;

    private a() {
    }

    public static a a() {
        if (a == null) {
            a = new a();
        }
        return a;
    }

    private void a(d dVar, int i, View view) {
        c cVarC;
        String[] strArr;
        if (dVar != null) {
            try {
                dVar.g();
            } catch (Throwable unused) {
            }
            if (dVar.x()) {
                ab abVar = ((p) dVar).a().get(i);
                if (abVar.b != 0) {
                    String str = abVar.c;
                    switch (o.d(str)) {
                        case 1:
                            OlaImageViewerActivity.a(c.c(), view, (Bitmap) null, 0, OlaMediaEntity.a(2, (short) 1, str));
                            break;
                        case 2:
                            chat.ola.vn.util.b.a(c.c(), str, 0);
                            break;
                        case 3:
                            chat.ola.vn.util.b.b(c.c(), Uri.fromFile(new File(str)));
                            break;
                    }
                    return;
                }
                String str2 = abVar.c;
                switch (o.g(str2)) {
                    case 1:
                        try {
                            List<String> listG = dVar.f().G();
                            if (listG == null || listG.size() <= 0) {
                                cVarC = c.c();
                                strArr = new String[]{str2};
                            } else {
                                int size = listG.size() - 1;
                                while (size >= 0 && !m.b(listG.get(size), str2)) {
                                    size--;
                                }
                                if (size >= 0) {
                                    OlaImageViewerActivity.a(c.c(), view, (Bitmap) null, size, OlaMediaEntity.a(listG));
                                    return;
                                } else {
                                    cVarC = c.c();
                                    strArr = new String[]{str2};
                                }
                            }
                            OlaImageViewerActivity.a(cVarC, view, (Bitmap) null, 0, OlaMediaEntity.a(strArr));
                            return;
                        } catch (Throwable unused2) {
                            OlaImageViewerActivity.a(c.c(), view, (Bitmap) null, 0, OlaMediaEntity.a(str2));
                            return;
                        }
                    case 2:
                        chat.ola.vn.util.b.h(c.c(), str2);
                        return;
                    case 3:
                        chat.ola.vn.util.b.e(c.c(), i.k(str2));
                        return;
                    default:
                        return;
                }
            }
        }
    }

    @Override // com.mg.ola.common.widget.OlaTextView.b
    public void a(View view, ClickableSpan clickableSpan, CharSequence charSequence) {
        c cVarC;
        OlaNetworkService olaNetworkService;
        try {
            String string = charSequence.toString();
            char cCharAt = string.toLowerCase(Locale.US).charAt(0);
            if (cCharAt == '#') {
                cVarC = c.c();
                olaNetworkService = OlaApplication.b;
            } else {
                if (cCharAt != '@') {
                    if (cCharAt == 'h') {
                        chat.ola.vn.util.b.o(c.c(), string);
                        return;
                    } else {
                        if (cCharAt != 'r') {
                            return;
                        }
                        j.a(c.c(), string);
                        OlaApplication.b.d(string, (String) null, (short) 0);
                        return;
                    }
                }
                cVarC = c.c();
                olaNetworkService = OlaApplication.b;
                string = m.j(string);
            }
            chat.ola.vn.me.c.a(cVarC, olaNetworkService, string);
        } catch (Throwable unused) {
        }
    }

    public boolean a(final String str) {
        final ArrayList arrayList = new ArrayList();
        arrayList.add(OlaApplication.a(R.string.string_copy));
        arrayList.add(OlaApplication.a(R.string.string_copy_plus));
        chat.ola.vn.i.m mVar = new chat.ola.vn.i.m(c.c());
        mVar.a(str);
        mVar.a(arrayList);
        mVar.a(new AdapterView.OnItemClickListener() { // from class: chat.ola.vn.q.a.1
            @Override // android.widget.AdapterView.OnItemClickListener
            public void onItemClick(AdapterView<?> adapterView, View view, int i, long j) {
                String str2;
                try {
                    String str3 = (String) arrayList.get(i);
                    if (m.b(str3, OlaApplication.a(R.string.string_copy))) {
                        if (m.a(str)) {
                            return;
                        }
                        o.a(c.c(), str);
                    } else {
                        if (!m.b(str3, OlaApplication.a(R.string.string_copy_plus)) || m.a(str)) {
                            return;
                        }
                        String strA = o.a(c.c());
                        if (m.a(strA)) {
                            str2 = str;
                        } else {
                            str2 = strA + " " + str;
                        }
                        o.a(c.c(), str2);
                    }
                } catch (Throwable unused) {
                }
            }
        });
        mVar.show();
        return true;
    }

    @Override // com.mg.ola.common.widget.OlaTextView.b
    public void b(View view, ClickableSpan clickableSpan, CharSequence charSequence) {
        try {
            a(charSequence.toString());
        } catch (Throwable unused) {
        }
    }

    @Override // android.view.View.OnClickListener
    public void onClick(View view) {
        c cVarC;
        String strB;
        d dVar;
        int i;
        try {
            int id = view.getId();
            if (id == R.id.chatRssViewLayout) {
                try {
                    r rVar = (r) view.getTag();
                    rVar.g();
                    j.a(c.c(), rVar.y());
                    return;
                } catch (Throwable unused) {
                    chat.ola.vn.message.i iVar = (chat.ola.vn.message.i) view.getTag();
                    iVar.g();
                    if (iVar.a() == null || m.a(iVar.a().b)) {
                        cVarC = c.c();
                        strB = iVar.B();
                    } else {
                        cVarC = c.c();
                        strB = iVar.a().b;
                    }
                    chat.ola.vn.util.b.o(cVarC, strB);
                    return;
                }
            }
            if (id == R.id.messageSenderTextview) {
                chat.ola.vn.me.c.a(c.c(), OlaApplication.b, (String) view.getTag(), (n) null);
                return;
            }
            if (id == R.id.senderAvatarImageView) {
                String str = (String) view.getTag();
                c cVarC2 = c.c();
                if (cVarC2 == null || m.a(str)) {
                    return;
                }
                OlaUserMePageActivity.a(cVarC2, str);
                return;
            }
            switch (id) {
                case R.id.mediaImageView1 /* 2131297096 */:
                    dVar = (d) view.getTag();
                    i = 0;
                    break;
                case R.id.mediaImageView2 /* 2131297097 */:
                    dVar = (d) view.getTag();
                    i = 1;
                    break;
                case R.id.mediaImageView3 /* 2131297098 */:
                    dVar = (d) view.getTag();
                    i = 2;
                    break;
                case R.id.mediaImageView4 /* 2131297099 */:
                    dVar = (d) view.getTag();
                    i = 3;
                    break;
                case R.id.mediaImageView5 /* 2131297100 */:
                    dVar = (d) view.getTag();
                    i = 4;
                    break;
                default:
                    return;
            }
            a(dVar, i, view);
        } catch (Throwable unused2) {
        }
    }

    @Override // android.view.View.OnLongClickListener
    public boolean onLongClick(View view) {
        return false;
    }
}
