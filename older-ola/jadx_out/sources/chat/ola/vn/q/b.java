package chat.ola.vn.q;

import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.view.animation.Animation;
import android.view.animation.AnimationUtils;
import android.widget.AdapterView;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import chat.ola.vn.activity.BuyVipActivity;
import chat.ola.vn.activity.OlaChatViewActivity;
import chat.ola.vn.activity.OlaCropImageActivity;
import chat.ola.vn.activity.OlaImageViewerActivity;
import chat.ola.vn.activity.OlaSuggestedFriendListActivity;
import chat.ola.vn.activity.OlaVipStoreActivity;
import chat.ola.vn.c;
import chat.ola.vn.c.t;
import chat.ola.vn.c.x;
import chat.ola.vn.checkin.OlaVenueDetailActivity;
import chat.ola.vn.cloud.OlaCloudAlbumListActivity;
import chat.ola.vn.cloud.OlaCloudPhotoListActivity;
import chat.ola.vn.entity.d;
import chat.ola.vn.entity.g;
import chat.ola.vn.entity.i;
import chat.ola.vn.entity.k;
import chat.ola.vn.entity.w;
import chat.ola.vn.entry.c.f;
import chat.ola.vn.h;
import chat.ola.vn.m.j;
import chat.ola.vn.m.z;
import chat.ola.vn.me.OlaAdMeLikeListActivity;
import chat.ola.vn.me.OlaMeCommentActivity;
import chat.ola.vn.me.OlaMeComposerActivity;
import chat.ola.vn.me.OlaMeLikerListActivity;
import chat.ola.vn.me.OlaUserMePageActivity;
import chat.ola.vn.mediastore.OlaMediaEntity;
import chat.ola.vn.network.OlaNetworkService;
import chat.ola.vn.util.m;
import chat.ola.vn.util.o;
import com.mg.ola.common.c.c;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public class b implements OlaCropImageActivity.a {
    private static b a;

    private b() {
    }

    private i a(chat.ola.vn.entry.b bVar, int i) {
        try {
            String str = bVar.i.get(i);
            if (m.a(str)) {
                return null;
            }
            i iVar = new i();
            iVar.a(str);
            return iVar;
        } catch (Throwable unused) {
            return null;
        }
    }

    public static b a() {
        if (a == null) {
            a = new b();
        }
        return a;
    }

    private void a(Context context, View view, int i) {
        try {
            chat.ola.vn.i.i.a(context, a((chat.ola.vn.entry.b) view.getTag(), i));
        } catch (Throwable unused) {
        }
    }

    private void a(Context context, View view, int i, chat.ola.vn.entry.b bVar) {
        OlaImageViewerActivity.a(context, view, i, bVar);
        try {
            String str = bVar.f().get(i);
            if (i.i(str) != 1 || m.b(h.a(), bVar.b.a())) {
                return;
            }
            OlaApplication.b.n(str, f.a(new chat.ola.vn.d.b(bVar)));
        } catch (Throwable unused) {
        }
    }

    private void a(Context context, View view, d dVar) {
        try {
            int iF = dVar.a.f();
            if (dVar.a.i() == 1) {
                dVar.a.c((short) 0);
                dVar.a.a(iF - 1);
            } else {
                dVar.a.c((short) 1);
                dVar.a.a(iF + 1);
                Animation animationLoadAnimation = AnimationUtils.loadAnimation(context, R.anim.zoom_icon_animation);
                animationLoadAnimation.setDuration(100L);
                view.startAnimation(animationLoadAnimation);
            }
            d.a(context, dVar);
            c.c().j();
        } catch (Throwable unused) {
        }
    }

    private void a(Context context, View view, chat.ola.vn.entry.b bVar) {
        View viewFindViewById;
        Animation animationLoadAnimation;
        if (bVar.h() == 0) {
            OlaNetworkService olaNetworkService = OlaApplication.b;
            if (olaNetworkService != null) {
                olaNetworkService.a(bVar.b.e(), bVar.b.i() != 2);
            }
            int iD = bVar.b.D();
            try {
                if (bVar.b.i() == 2) {
                    bVar.b.c((short) 0);
                    bVar.b.c(iD - 1);
                    viewFindViewById = view.findViewById(R.id.txtMeItemDislikeIcon);
                    animationLoadAnimation = AnimationUtils.loadAnimation(context, R.anim.zoom_out_icon_animation);
                } else {
                    if (bVar.b.i() == 1) {
                        int iF = bVar.b.f();
                        bVar.b.c((short) 0);
                        bVar.b.a(iF - 1);
                    }
                    bVar.b.c((short) 2);
                    bVar.b.c(iD + 1);
                    viewFindViewById = view.findViewById(R.id.txtMeItemDislikeIcon);
                    animationLoadAnimation = AnimationUtils.loadAnimation(context, R.anim.zoom_icon_animation);
                }
                animationLoadAnimation.setDuration(100L);
                viewFindViewById.startAnimation(animationLoadAnimation);
            } catch (Throwable unused) {
            }
            c.c().j();
        }
    }

    private void a(final Context context, View view, final List<String> list) {
        com.mg.ola.common.c.a aVar;
        com.mg.ola.common.c.b bVar = new com.mg.ola.common.c.b(context);
        bVar.a(true);
        Iterator<String> it2 = list.iterator();
        while (it2.hasNext()) {
            switch (o.g(it2.next())) {
                case 1:
                    aVar = new com.mg.ola.common.c.a(context, R.drawable.ic_media_photo, "");
                    bVar.a(aVar);
                    break;
                case 2:
                    aVar = new com.mg.ola.common.c.a(context, R.drawable.ic_media_video, "");
                    bVar.a(aVar);
                    break;
                case 3:
                    aVar = new com.mg.ola.common.c.a(context, R.drawable.ic_media_sound, "");
                    bVar.a(aVar);
                    break;
            }
        }
        bVar.a(new c.a() { // from class: chat.ola.vn.q.b.6
            @Override // com.mg.ola.common.c.c.a
            public void a(com.mg.ola.common.c.c cVar, int i) {
                String str = (String) list.get(i);
                switch (o.g(str)) {
                    case 2:
                        chat.ola.vn.util.b.h(context, str);
                        break;
                    case 3:
                        chat.ola.vn.util.b.f(context, str);
                        break;
                }
            }
        });
        bVar.a(view);
    }

    private void a(Context context, chat.ola.vn.entry.b bVar, long j) {
        OlaMeCommentActivity.a(context, bVar.b.e());
    }

    private void a(final Context context, final chat.ola.vn.entry.b bVar, final String str) {
        String string;
        final String strC = bVar.c();
        if (strC == null) {
            return;
        }
        final g gVar = bVar.b;
        final ArrayList arrayList = new ArrayList();
        if (m.a(strC, h.a())) {
            string = context.getString(R.string.string_copy);
        } else {
            arrayList.add(context.getString(R.string.string_chat));
            arrayList.add(context.getString(R.string.string_copy));
            string = context.getString(R.string.string_ban_from_clan);
        }
        arrayList.add(string);
        arrayList.add(context.getString(R.string.string_delete_me));
        arrayList.add(context.getString(R.string.string_more_action));
        chat.ola.vn.i.m mVar = new chat.ola.vn.i.m(context);
        mVar.a(arrayList);
        mVar.a(new AdapterView.OnItemClickListener() { // from class: chat.ola.vn.q.b.11
            @Override // android.widget.AdapterView.OnItemClickListener
            public void onItemClick(AdapterView<?> adapterView, View view, int i, long j) {
                Context context2;
                String string2;
                String string3;
                String string4;
                String string5;
                DialogInterface.OnClickListener onClickListener;
                String str2;
                try {
                    String str3 = (String) arrayList.get(i);
                    if (str3.equalsIgnoreCase(context.getString(R.string.string_chat))) {
                        OlaChatViewActivity.a(context, OlaApplication.b, strC, (short) 0);
                        return;
                    }
                    if (!str3.equalsIgnoreCase(context.getString(R.string.string_copy))) {
                        if (str3.equalsIgnoreCase(context.getString(R.string.string_ban_from_clan))) {
                            context2 = context;
                            string2 = context.getString(R.string.string_ban_from_clan);
                            string3 = context.getString(R.string.message_ban_from_clan_confirm_format, strC, str);
                            string4 = context.getString(R.string.string_ban_from_clan);
                            string5 = context.getString(R.string.string_cancel);
                            onClickListener = new DialogInterface.OnClickListener() { // from class: chat.ola.vn.q.b.11.1
                                @Override // android.content.DialogInterface.OnClickListener
                                public void onClick(DialogInterface dialogInterface, int i2) {
                                    if (i2 == 0) {
                                        try {
                                            OlaApplication.b.g(strC, str);
                                        } catch (Throwable unused) {
                                            return;
                                        }
                                    }
                                    dialogInterface.dismiss();
                                }
                            };
                        } else if (!str3.equalsIgnoreCase(context.getString(R.string.string_delete_me))) {
                            if (str3.equalsIgnoreCase(context.getString(R.string.string_more_action))) {
                                b.this.c(context, bVar, str);
                                return;
                            }
                            return;
                        } else {
                            context2 = context;
                            string2 = context.getString(R.string.string_delete_me);
                            string3 = context.getString(R.string.message_delete_me_format, strC);
                            string4 = context.getString(R.string.string_delete_me);
                            string5 = context.getString(R.string.string_cancel);
                            onClickListener = new DialogInterface.OnClickListener() { // from class: chat.ola.vn.q.b.11.2
                                @Override // android.content.DialogInterface.OnClickListener
                                public void onClick(DialogInterface dialogInterface, int i2) {
                                    if (i2 == 0) {
                                        OlaNetworkService olaNetworkService = OlaApplication.b;
                                        if (olaNetworkService != null) {
                                            if (bVar.h() == 0) {
                                                olaNetworkService.b(gVar.e());
                                            } else if (bVar.h() == 1) {
                                                olaNetworkService.r(gVar.m());
                                            } else if (bVar.h() == 2) {
                                                olaNetworkService.s(gVar.m());
                                            }
                                        }
                                        h.u.a(bVar);
                                        chat.ola.vn.c.c().j();
                                    }
                                    dialogInterface.dismiss();
                                }
                            };
                        }
                        chat.ola.vn.i.i.d(context2, string2, string3, string4, string5, onClickListener);
                        return;
                    }
                    if (gVar.c() != null) {
                        str2 = " #\u001b" + gVar.c() + "#";
                    } else {
                        str2 = "";
                    }
                    try {
                        if (bVar.g() != null) {
                            Iterator<String> it2 = bVar.g().iterator();
                            while (it2.hasNext()) {
                                str2 = str2 + " #\u001b" + it2.next() + "#";
                            }
                        }
                    } catch (Throwable unused) {
                    }
                    o.a(context, gVar.b() + str2);
                } catch (Throwable unused2) {
                }
            }
        });
        mVar.show();
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void a(final Context context, chat.ola.vn.message.f fVar, final String str) {
        final ArrayList arrayList = new ArrayList();
        arrayList.add(context.getString(R.string.string_copy_nick));
        arrayList.add(context.getString(R.string.string_copy_plus));
        arrayList.add(context.getString(R.string.string_block_me));
        arrayList.add(context.getString(R.string.string_bad_nick_report));
        chat.ola.vn.i.m mVar = new chat.ola.vn.i.m(context);
        if (fVar != null) {
            mVar.setTitle(fVar.L());
        } else {
            mVar.a(str);
        }
        mVar.a(arrayList);
        mVar.a(new AdapterView.OnItemClickListener() { // from class: chat.ola.vn.q.b.7
            @Override // android.widget.AdapterView.OnItemClickListener
            public void onItemClick(AdapterView<?> adapterView, View view, int i, long j) {
                String str2;
                try {
                    String str3 = (String) arrayList.get(i);
                    if (str3.equals(context.getString(R.string.string_copy_nick))) {
                        o.a(context, "@" + str);
                        return;
                    }
                    if (!str3.equals(context.getString(R.string.string_copy_plus))) {
                        if (str3.equals(context.getString(R.string.string_block_me))) {
                            if (OlaApplication.b != null) {
                                OlaApplication.b.m(str);
                                return;
                            }
                            return;
                        } else {
                            if (str3.equals(context.getString(R.string.string_bad_nick_report))) {
                                chat.ola.vn.i.i.a(context, str);
                                return;
                            }
                            return;
                        }
                    }
                    String strA = o.a(context);
                    if (m.a(strA)) {
                        str2 = "@" + str;
                    } else {
                        str2 = strA + " @" + str;
                    }
                    o.a(context, str2);
                } catch (Throwable unused) {
                }
            }
        });
        mVar.show();
    }

    private void a(final Context context, final String str) {
        try {
            final ArrayList arrayList = new ArrayList();
            final chat.ola.vn.message.f fVarE = h.t.e(str, (short) 0);
            if (fVarE == null) {
                arrayList.add(context.getString(R.string.string_make_friend));
            }
            arrayList.add(context.getString(R.string.string_chat));
            arrayList.add(context.getString(R.string.string_view_vip_store));
            arrayList.add(context.getString(R.string.string_more_action));
            chat.ola.vn.i.m mVar = new chat.ola.vn.i.m(context);
            if (fVarE != null) {
                mVar.setTitle(fVarE.L());
            } else {
                mVar.a(str);
            }
            mVar.a(arrayList);
            mVar.a(new AdapterView.OnItemClickListener() { // from class: chat.ola.vn.q.b.1
                @Override // android.widget.AdapterView.OnItemClickListener
                public void onItemClick(AdapterView<?> adapterView, View view, int i, long j) {
                    try {
                        String str2 = (String) arrayList.get(i);
                        if (str2.equals(context.getString(R.string.string_make_friend))) {
                            return;
                        }
                        if (str2.equals(context.getString(R.string.string_chat))) {
                            OlaChatViewActivity.a(context, OlaApplication.b, str, (short) 0);
                        } else if (m.b(str2, context.getString(R.string.string_view_vip_store))) {
                            OlaVipStoreActivity.a(context, str);
                        } else if (str2.equals(context.getString(R.string.string_more_action))) {
                            b.this.a(context, fVarE, str);
                        }
                    } catch (Throwable unused) {
                    }
                }
            });
            mVar.show();
        } catch (Throwable unused) {
        }
    }

    private void b(Context context, View view, chat.ola.vn.entry.b bVar) {
        if (bVar.h() == 0) {
            if (OlaApplication.b.b(bVar.b.e(), bVar.b.i() != 1)) {
                int iF = bVar.b.f();
                chat.ola.vn.c cVarC = chat.ola.vn.c.c();
                try {
                    if (bVar.b.i() == 1) {
                        bVar.b.c((short) 0);
                        bVar.b.a(iF - 1);
                        View viewFindViewById = view.findViewById(R.id.txtMeItemLikeIcon);
                        Animation animationLoadAnimation = AnimationUtils.loadAnimation(context, R.anim.zoom_out_icon_animation);
                        animationLoadAnimation.setDuration(100L);
                        viewFindViewById.startAnimation(animationLoadAnimation);
                    } else {
                        if (bVar.b.i() == 2) {
                            bVar.b.c(bVar.b.D() - 1);
                        }
                        bVar.b.c((short) 1);
                        bVar.b.a(iF + 1);
                        View viewFindViewById2 = view.findViewById(R.id.txtMeItemLikeIcon);
                        Animation animationLoadAnimation2 = AnimationUtils.loadAnimation(context, R.anim.zoom_icon_animation);
                        animationLoadAnimation2.setDuration(100L);
                        viewFindViewById2.startAnimation(animationLoadAnimation2);
                        cVarC.b(viewFindViewById2, cVarC.z());
                    }
                } catch (Throwable unused) {
                }
                cVarC.j();
            }
        }
    }

    private void b(Context context, chat.ola.vn.entry.b bVar) {
        String strG;
        if (bVar.b.k() == 11) {
            OlaMeComposerActivity.b(context, bVar.b.e());
            return;
        }
        if (!h.u.a(h.u.g()) && h.u.c() == 0 && (strG = h.u.g()) != null && !strG.startsWith("#")) {
            String str = "@" + strG;
        }
        String strB = chat.ola.vn.util.i.b(bVar.b.b(), "@" + h.a());
        String strA = chat.ola.vn.util.i.a((CharSequence) bVar.b.b());
        if (!m.a(strA)) {
            if (m.a(strB)) {
                strB = strA;
            } else {
                strB = strB + " " + strA;
            }
        }
        if (m.a(strB)) {
            strB = null;
        }
        OlaMeComposerActivity.a(context, "@" + bVar.b.a(), strB, bVar.b.e());
    }

    private void b(final Context context, final chat.ola.vn.entry.b bVar, final String str) {
        String string;
        final String strC = bVar.c();
        if (strC == null) {
            return;
        }
        final g gVar = bVar.b;
        final ArrayList arrayList = new ArrayList();
        if (m.a(strC, h.a())) {
            string = context.getString(R.string.string_copy);
        } else {
            arrayList.add(context.getString(R.string.string_chat));
            arrayList.add(context.getString(R.string.string_copy));
            string = context.getString(R.string.string_ban_from_clan);
        }
        arrayList.add(string);
        arrayList.add(context.getString(R.string.string_delete_me));
        arrayList.add(context.getString(R.string.string_more_action));
        chat.ola.vn.i.m mVar = new chat.ola.vn.i.m(context);
        mVar.a(arrayList);
        mVar.a(new AdapterView.OnItemClickListener() { // from class: chat.ola.vn.q.b.12
            @Override // android.widget.AdapterView.OnItemClickListener
            public void onItemClick(AdapterView<?> adapterView, View view, int i, long j) {
                Context context2;
                String string2;
                String string3;
                String string4;
                String string5;
                DialogInterface.OnClickListener onClickListener;
                String str2;
                try {
                    String str3 = (String) arrayList.get(i);
                    if (str3.equalsIgnoreCase(context.getString(R.string.string_chat))) {
                        OlaChatViewActivity.a(context, OlaApplication.b, strC, (short) 0);
                        return;
                    }
                    if (!str3.equalsIgnoreCase(context.getString(R.string.string_copy))) {
                        if (str3.equalsIgnoreCase(context.getString(R.string.string_ban_from_clan))) {
                            context2 = context;
                            string2 = context.getString(R.string.string_ban_from_clan);
                            string3 = context.getString(R.string.message_ban_from_clan_confirm_format, strC, str);
                            string4 = context.getString(R.string.string_ban_from_clan);
                            string5 = context.getString(R.string.string_cancel);
                            onClickListener = new DialogInterface.OnClickListener() { // from class: chat.ola.vn.q.b.12.1
                                @Override // android.content.DialogInterface.OnClickListener
                                public void onClick(DialogInterface dialogInterface, int i2) {
                                    if (i2 == 0) {
                                        try {
                                            OlaApplication.b.g(strC, str);
                                        } catch (Throwable unused) {
                                            return;
                                        }
                                    }
                                    dialogInterface.dismiss();
                                }
                            };
                        } else if (!str3.equalsIgnoreCase(context.getString(R.string.string_delete_me))) {
                            if (str3.equalsIgnoreCase(context.getString(R.string.string_more_action))) {
                                b.this.d(context, bVar, str);
                                return;
                            }
                            return;
                        } else {
                            context2 = context;
                            string2 = context.getString(R.string.string_delete_me);
                            string3 = context.getString(R.string.message_delete_me_format, strC);
                            string4 = context.getString(R.string.string_delete_me);
                            string5 = context.getString(R.string.string_cancel);
                            onClickListener = new DialogInterface.OnClickListener() { // from class: chat.ola.vn.q.b.12.2
                                @Override // android.content.DialogInterface.OnClickListener
                                public void onClick(DialogInterface dialogInterface, int i2) {
                                    if (i2 == 0) {
                                        OlaNetworkService olaNetworkService = OlaApplication.b;
                                        if (olaNetworkService != null) {
                                            if (bVar.h() == 0) {
                                                olaNetworkService.b(gVar.e());
                                            } else if (bVar.h() == 1) {
                                                olaNetworkService.r(gVar.m());
                                            } else if (bVar.h() == 2) {
                                                olaNetworkService.s(gVar.m());
                                            }
                                        }
                                        h.u.a(bVar);
                                        chat.ola.vn.c.c().j();
                                    }
                                    dialogInterface.dismiss();
                                }
                            };
                        }
                        chat.ola.vn.i.i.d(context2, string2, string3, string4, string5, onClickListener);
                        return;
                    }
                    if (gVar.c() != null) {
                        str2 = " #\u001b" + gVar.c() + "#";
                    } else {
                        str2 = "";
                    }
                    try {
                        if (bVar.g() != null) {
                            Iterator<String> it2 = bVar.g().iterator();
                            while (it2.hasNext()) {
                                str2 = str2 + " #\u001b" + it2.next() + "#";
                            }
                        }
                    } catch (Throwable unused) {
                    }
                    o.a(context, gVar.b() + str2);
                } catch (Throwable unused2) {
                }
            }
        });
        mVar.show();
    }

    private void c(Context context, View view) {
        try {
            chat.ola.vn.entry.b bVar = (chat.ola.vn.entry.b) view.getTag();
            if (bVar.k == null || bVar.k.isEmpty()) {
                return;
            }
            if (bVar.k.size() != 1) {
                a(context, view, bVar.k);
                return;
            }
            String str = bVar.k.get(0);
            if (m.a(str)) {
                return;
            }
            i iVar = new i();
            iVar.a(str);
            chat.ola.vn.i.i.c(context, iVar);
        } catch (Throwable unused) {
        }
    }

    private void c(Context context, chat.ola.vn.entry.b bVar) {
        try {
            String strG = h.u.g();
            if (!m.a(strG) && strG.startsWith("#")) {
                if (m.b(h.a(), null)) {
                    b(context, bVar, (String) null);
                    return;
                }
                if (!m.b(h.a(), null) && !m.b(h.a(), null)) {
                    d(context, bVar);
                    return;
                }
                a(context, bVar, (String) null);
                return;
            }
            f(context, bVar);
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void c(final Context context, chat.ola.vn.entry.b bVar, final String str) {
        final String strC = bVar.c();
        if (strC == null) {
            return;
        }
        final g gVar = bVar.b;
        final ArrayList arrayList = new ArrayList();
        arrayList.add(context.getString(R.string.message_delete_all_me_from_clan_of, strC));
        arrayList.add(context.getString(R.string.string_copy_plus));
        chat.ola.vn.i.m mVar = new chat.ola.vn.i.m(context);
        mVar.a(arrayList);
        mVar.a(new AdapterView.OnItemClickListener() { // from class: chat.ola.vn.q.b.13
            @Override // android.widget.AdapterView.OnItemClickListener
            public void onItemClick(AdapterView<?> adapterView, View view, int i, long j) {
                String str2;
                try {
                    String str3 = (String) arrayList.get(i);
                    if (str3.equalsIgnoreCase(context.getString(R.string.message_delete_all_me_from_clan_of, strC))) {
                        chat.ola.vn.i.i.d(context, context.getString(R.string.string_delete_me), context.getString(R.string.message_delete_all_me_from_clan_format, strC, str), context.getString(R.string.string_delete_all), context.getString(R.string.string_cancel), new DialogInterface.OnClickListener() { // from class: chat.ola.vn.q.b.13.1
                            @Override // android.content.DialogInterface.OnClickListener
                            public void onClick(DialogInterface dialogInterface, int i2) {
                                if (i2 == 0) {
                                    try {
                                        OlaApplication.b.h(strC, str);
                                    } catch (Throwable unused) {
                                        return;
                                    }
                                }
                                dialogInterface.dismiss();
                            }
                        });
                        return;
                    }
                    if (str3.equalsIgnoreCase(context.getString(R.string.string_copy_plus))) {
                        if (gVar.c() != null) {
                            str2 = " #\u001b" + gVar.c() + "#";
                        } else {
                            str2 = "";
                        }
                        String str4 = gVar.b() + str2;
                        if (m.a(str4)) {
                            return;
                        }
                        String strA = o.a(context);
                        if (!m.a(strA)) {
                            str4 = strA + " " + str4;
                        }
                        o.a(context, str4);
                    }
                } catch (Throwable unused) {
                }
            }
        });
        mVar.show();
    }

    private void d(Context context, View view) {
        try {
            chat.ola.vn.entry.b bVar = (chat.ola.vn.entry.b) view.getTag();
            if (bVar.j == null || bVar.j.isEmpty()) {
                return;
            }
            if (bVar.j.size() != 1) {
                a(context, view, bVar.j);
                return;
            }
            String str = bVar.j.get(0);
            if (m.a(str)) {
                return;
            }
            i iVar = new i();
            iVar.a(str);
            chat.ola.vn.i.i.a(context, iVar);
        } catch (Throwable unused) {
        }
    }

    private void d(final Context context, final chat.ola.vn.entry.b bVar) {
        final String strC = bVar.c();
        if (strC == null) {
            return;
        }
        final g gVar = bVar.b;
        final ArrayList arrayList = new ArrayList();
        if (!m.a(strC, h.a())) {
            arrayList.add(context.getString(R.string.string_chat));
        }
        arrayList.add(context.getString(R.string.string_copy));
        arrayList.add(context.getString(R.string.string_copy_plus));
        arrayList.add(context.getString(R.string.string_more_action));
        chat.ola.vn.i.m mVar = new chat.ola.vn.i.m(context);
        mVar.a(arrayList);
        mVar.a(new AdapterView.OnItemClickListener() { // from class: chat.ola.vn.q.b.9
            @Override // android.widget.AdapterView.OnItemClickListener
            public void onItemClick(AdapterView<?> adapterView, View view, int i, long j) {
                String str;
                String str2;
                Context context2;
                String str3;
                try {
                    String str4 = (String) arrayList.get(i);
                    if (str4.equalsIgnoreCase(context.getString(R.string.string_chat))) {
                        OlaChatViewActivity.a(context, OlaApplication.b, strC, (short) 0);
                        return;
                    }
                    if (str4.equalsIgnoreCase(context.getString(R.string.string_copy))) {
                        if (gVar.c() != null) {
                            str3 = " #\u001b" + gVar.c() + "#";
                        } else {
                            str3 = "";
                        }
                        try {
                            if (bVar.g() != null) {
                                Iterator<String> it2 = bVar.g().iterator();
                                while (it2.hasNext()) {
                                    str3 = str3 + " #\u001b" + it2.next() + "#";
                                }
                            }
                        } catch (Throwable unused) {
                        }
                        context2 = context;
                        str2 = gVar.b() + str3;
                    } else {
                        if (!str4.equalsIgnoreCase(context.getString(R.string.string_copy_plus))) {
                            if (str4.equalsIgnoreCase(context.getString(R.string.string_more_action))) {
                                b.this.e(context, bVar);
                                return;
                            }
                            return;
                        }
                        if (gVar.c() != null) {
                            str = " #\u001b" + gVar.c() + "#";
                        } else {
                            str = "";
                        }
                        str2 = gVar.b() + str;
                        if (m.a(str2)) {
                            return;
                        }
                        String strA = o.a(context);
                        if (!m.a(strA)) {
                            str2 = strA + " " + str2;
                        }
                        context2 = context;
                    }
                    o.a(context2, str2);
                } catch (Throwable unused2) {
                }
            }
        });
        mVar.show();
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void d(final Context context, chat.ola.vn.entry.b bVar, final String str) {
        final String strC = bVar.c();
        if (strC == null) {
            return;
        }
        final g gVar = bVar.b;
        final ArrayList arrayList = new ArrayList();
        arrayList.add(context.getString(R.string.string_broadcast_to_clan));
        arrayList.add(context.getString(R.string.string_post_me_top_clan));
        arrayList.add(context.getString(R.string.string_discard_me_top_clan));
        arrayList.add(context.getString(R.string.message_delete_all_me_from_clan_of, strC));
        arrayList.add(context.getString(R.string.string_copy_plus));
        chat.ola.vn.i.m mVar = new chat.ola.vn.i.m(context);
        mVar.a(arrayList);
        mVar.a(new AdapterView.OnItemClickListener() { // from class: chat.ola.vn.q.b.14
            @Override // android.widget.AdapterView.OnItemClickListener
            public void onItemClick(AdapterView<?> adapterView, View view, int i, long j) {
                String str2;
                try {
                    String str3 = (String) arrayList.get(i);
                    if (str3.equalsIgnoreCase(context.getString(R.string.string_broadcast_to_clan))) {
                        OlaNetworkService olaNetworkService = OlaApplication.b;
                        if (olaNetworkService != null) {
                            olaNetworkService.b(gVar.e(), str);
                            return;
                        }
                        return;
                    }
                    if (str3.equalsIgnoreCase(context.getString(R.string.string_post_me_top_clan))) {
                        OlaNetworkService olaNetworkService2 = OlaApplication.b;
                        if (olaNetworkService2 != null) {
                            olaNetworkService2.a(gVar.e(), str);
                            return;
                        }
                        return;
                    }
                    if (str3.equalsIgnoreCase(context.getString(R.string.string_discard_me_top_clan))) {
                        OlaNetworkService olaNetworkService3 = OlaApplication.b;
                        if (olaNetworkService3 != null) {
                            olaNetworkService3.q(str);
                            return;
                        }
                        return;
                    }
                    if (str3.equalsIgnoreCase(context.getString(R.string.message_delete_all_me_from_clan_of, strC))) {
                        chat.ola.vn.i.i.d(context, context.getString(R.string.string_delete_me), context.getString(R.string.message_delete_all_me_from_clan_format, strC, str), context.getString(R.string.string_delete_all), context.getString(R.string.string_cancel), new DialogInterface.OnClickListener() { // from class: chat.ola.vn.q.b.14.1
                            @Override // android.content.DialogInterface.OnClickListener
                            public void onClick(DialogInterface dialogInterface, int i2) {
                                if (i2 == 0) {
                                    try {
                                        OlaApplication.b.h(strC, str);
                                    } catch (Throwable unused) {
                                        return;
                                    }
                                }
                                dialogInterface.dismiss();
                            }
                        });
                        return;
                    }
                    if (str3.equalsIgnoreCase(context.getString(R.string.string_copy_plus))) {
                        if (gVar.c() != null) {
                            str2 = " #\u001b" + gVar.c() + "#";
                        } else {
                            str2 = "";
                        }
                        String str4 = gVar.b() + str2;
                        if (m.a(str4)) {
                            return;
                        }
                        String strA = o.a(context);
                        if (!m.a(strA)) {
                            str4 = strA + " " + str4;
                        }
                        o.a(context, str4);
                    }
                } catch (Throwable unused) {
                }
            }
        });
        mVar.show();
    }

    private void e(Context context, View view) {
        try {
            chat.ola.vn.entry.b bVar = (chat.ola.vn.entry.b) view.getTag();
            if (m.a(bVar.m)) {
                return;
            }
            switch (bVar.l) {
                case 1:
                    chat.ola.vn.i.i.a(context, bVar.m, bVar.q);
                    break;
                case 2:
                    i iVar = new i();
                    iVar.a(bVar.m);
                    chat.ola.vn.i.i.a(context, iVar);
                    break;
                default:
                    chat.ola.vn.i.i.e(context, bVar.m);
                    break;
            }
        } catch (Throwable unused) {
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void e(final Context context, final chat.ola.vn.entry.b bVar) {
        if (bVar.c() == null) {
            return;
        }
        final ArrayList arrayList = new ArrayList();
        arrayList.add(context.getString(R.string.string_share));
        arrayList.add(context.getString(R.string.general_tab_translater));
        chat.ola.vn.i.m mVar = new chat.ola.vn.i.m(context);
        mVar.a(arrayList);
        mVar.a(new AdapterView.OnItemClickListener() { // from class: chat.ola.vn.q.b.10
            @Override // android.widget.AdapterView.OnItemClickListener
            public void onItemClick(AdapterView<?> adapterView, View view, int i, long j) {
                try {
                    String str = (String) arrayList.get(i);
                    if (str.equalsIgnoreCase(context.getString(R.string.string_share))) {
                        b.this.h(context, bVar);
                    } else if (str.equalsIgnoreCase(context.getString(R.string.general_tab_translater))) {
                        z.a(context, bVar.c.toString());
                    }
                } catch (Throwable unused) {
                }
            }
        });
        mVar.show();
    }

    private void f(final Context context, final chat.ola.vn.entry.b bVar) {
        String string;
        final String strC = bVar.c();
        if (strC == null) {
            return;
        }
        final g gVar = bVar.b;
        final ArrayList arrayList = new ArrayList();
        if (bVar.h() != 0) {
            if (bVar.h() == 1 || bVar.h() == 2) {
                arrayList.add(context.getString(R.string.string_copy));
                arrayList.add(context.getString(R.string.string_copy_plus));
                string = context.getString(R.string.string_delete_me);
            }
            chat.ola.vn.i.m mVar = new chat.ola.vn.i.m(context);
            mVar.a(arrayList);
            mVar.a(new AdapterView.OnItemClickListener() { // from class: chat.ola.vn.q.b.2
                @Override // android.widget.AdapterView.OnItemClickListener
                public void onItemClick(AdapterView<?> adapterView, View view, int i, long j) {
                    String str;
                    Context context2;
                    try {
                        String str2 = (String) arrayList.get(i);
                        if (str2.equalsIgnoreCase(context.getString(R.string.string_bad_nick_report))) {
                            chat.ola.vn.i.i.a(context, strC);
                            return;
                        }
                        if (str2.equalsIgnoreCase(context.getString(R.string.string_discard_me_top))) {
                            if (OlaApplication.b != null) {
                                OlaApplication.b.p();
                                return;
                            }
                            return;
                        }
                        if (str2.equalsIgnoreCase(context.getString(R.string.string_chat))) {
                            OlaChatViewActivity.a(context, OlaApplication.b, strC, (short) 0);
                            return;
                        }
                        if (m.b(str2, context.getString(R.string.string_view_vip_store))) {
                            OlaVipStoreActivity.a(context, strC);
                            return;
                        }
                        if (m.b(str2, context.getString(R.string.string_copy_nick))) {
                            o.a(context, "@" + strC);
                            return;
                        }
                        if (str2.equalsIgnoreCase(context.getString(R.string.string_make_friend))) {
                            return;
                        }
                        if (str2.equalsIgnoreCase(context.getString(R.string.string_share))) {
                            b.this.h(context, bVar);
                            return;
                        }
                        if (str2.equalsIgnoreCase(context.getString(R.string.string_post_me_top))) {
                            OlaNetworkService olaNetworkService = OlaApplication.b;
                            if (olaNetworkService != null) {
                                olaNetworkService.a(gVar.e());
                                return;
                            }
                            return;
                        }
                        if (str2.equalsIgnoreCase(context.getString(R.string.general_tab_translater))) {
                            z.a(context, bVar.c.toString());
                            return;
                        }
                        if (str2.equalsIgnoreCase(context.getString(R.string.string_copy))) {
                            String str3 = gVar.c() != null ? " #\u001b" + gVar.c() + "#" : "";
                            try {
                                if (bVar.g() != null) {
                                    for (String str4 : bVar.g()) {
                                        if (!m.c(gVar.c(), str4)) {
                                            str3 = str3 + " #\u001b" + str4 + "#";
                                        }
                                    }
                                }
                            } catch (Throwable unused) {
                            }
                            context2 = context;
                            str = gVar.b() + str3;
                        } else {
                            if (!str2.equalsIgnoreCase(context.getString(R.string.string_copy_plus))) {
                                if (str2.equalsIgnoreCase(context.getString(R.string.string_delete_me))) {
                                    chat.ola.vn.i.i.d(context, context.getString(R.string.string_delete_me), context.getString(R.string.message_delete_me_format, strC), context.getString(R.string.string_delete_me), context.getString(R.string.string_cancel), new DialogInterface.OnClickListener() { // from class: chat.ola.vn.q.b.2.1
                                        @Override // android.content.DialogInterface.OnClickListener
                                        public void onClick(DialogInterface dialogInterface, int i2) {
                                            if (i2 == 0) {
                                                OlaNetworkService olaNetworkService2 = OlaApplication.b;
                                                if (olaNetworkService2 != null) {
                                                    if (bVar.h() == 0) {
                                                        olaNetworkService2.b(gVar.e());
                                                    } else if (bVar.h() == 1) {
                                                        olaNetworkService2.r(gVar.m());
                                                    } else if (bVar.h() == 2) {
                                                        olaNetworkService2.s(gVar.m());
                                                    }
                                                }
                                                h.u.a(bVar);
                                                chat.ola.vn.c.c().j();
                                            }
                                            dialogInterface.dismiss();
                                        }
                                    });
                                    return;
                                } else {
                                    if (str2.equalsIgnoreCase(context.getString(R.string.string_more_action))) {
                                        b.this.g(context, bVar);
                                        return;
                                    }
                                    return;
                                }
                            }
                            str = gVar.b() + (gVar.c() != null ? " #\u001b" + gVar.c() + "#" : "");
                            if (m.a(str)) {
                                return;
                            }
                            String strA = o.a(context);
                            if (!m.a(strA)) {
                                str = strA + " " + str;
                            }
                            context2 = context;
                        }
                        o.a(context2, str);
                    } catch (Throwable unused2) {
                    }
                }
            });
            mVar.show();
        }
        if (!m.a(strC, h.a())) {
            arrayList.add(context.getString(R.string.string_chat));
        }
        arrayList.add(context.getString(R.string.string_copy));
        arrayList.add(context.getString(R.string.string_copy_plus));
        arrayList.add(context.getString(R.string.string_delete_me));
        string = context.getString(R.string.string_more_action);
        arrayList.add(string);
        chat.ola.vn.i.m mVar2 = new chat.ola.vn.i.m(context);
        mVar2.a(arrayList);
        mVar2.a(new AdapterView.OnItemClickListener() { // from class: chat.ola.vn.q.b.2
            @Override // android.widget.AdapterView.OnItemClickListener
            public void onItemClick(AdapterView<?> adapterView, View view, int i, long j) {
                String str;
                Context context2;
                try {
                    String str2 = (String) arrayList.get(i);
                    if (str2.equalsIgnoreCase(context.getString(R.string.string_bad_nick_report))) {
                        chat.ola.vn.i.i.a(context, strC);
                        return;
                    }
                    if (str2.equalsIgnoreCase(context.getString(R.string.string_discard_me_top))) {
                        if (OlaApplication.b != null) {
                            OlaApplication.b.p();
                            return;
                        }
                        return;
                    }
                    if (str2.equalsIgnoreCase(context.getString(R.string.string_chat))) {
                        OlaChatViewActivity.a(context, OlaApplication.b, strC, (short) 0);
                        return;
                    }
                    if (m.b(str2, context.getString(R.string.string_view_vip_store))) {
                        OlaVipStoreActivity.a(context, strC);
                        return;
                    }
                    if (m.b(str2, context.getString(R.string.string_copy_nick))) {
                        o.a(context, "@" + strC);
                        return;
                    }
                    if (str2.equalsIgnoreCase(context.getString(R.string.string_make_friend))) {
                        return;
                    }
                    if (str2.equalsIgnoreCase(context.getString(R.string.string_share))) {
                        b.this.h(context, bVar);
                        return;
                    }
                    if (str2.equalsIgnoreCase(context.getString(R.string.string_post_me_top))) {
                        OlaNetworkService olaNetworkService = OlaApplication.b;
                        if (olaNetworkService != null) {
                            olaNetworkService.a(gVar.e());
                            return;
                        }
                        return;
                    }
                    if (str2.equalsIgnoreCase(context.getString(R.string.general_tab_translater))) {
                        z.a(context, bVar.c.toString());
                        return;
                    }
                    if (str2.equalsIgnoreCase(context.getString(R.string.string_copy))) {
                        String str3 = gVar.c() != null ? " #\u001b" + gVar.c() + "#" : "";
                        try {
                            if (bVar.g() != null) {
                                for (String str4 : bVar.g()) {
                                    if (!m.c(gVar.c(), str4)) {
                                        str3 = str3 + " #\u001b" + str4 + "#";
                                    }
                                }
                            }
                        } catch (Throwable unused) {
                        }
                        context2 = context;
                        str = gVar.b() + str3;
                    } else {
                        if (!str2.equalsIgnoreCase(context.getString(R.string.string_copy_plus))) {
                            if (str2.equalsIgnoreCase(context.getString(R.string.string_delete_me))) {
                                chat.ola.vn.i.i.d(context, context.getString(R.string.string_delete_me), context.getString(R.string.message_delete_me_format, strC), context.getString(R.string.string_delete_me), context.getString(R.string.string_cancel), new DialogInterface.OnClickListener() { // from class: chat.ola.vn.q.b.2.1
                                    @Override // android.content.DialogInterface.OnClickListener
                                    public void onClick(DialogInterface dialogInterface, int i2) {
                                        if (i2 == 0) {
                                            OlaNetworkService olaNetworkService2 = OlaApplication.b;
                                            if (olaNetworkService2 != null) {
                                                if (bVar.h() == 0) {
                                                    olaNetworkService2.b(gVar.e());
                                                } else if (bVar.h() == 1) {
                                                    olaNetworkService2.r(gVar.m());
                                                } else if (bVar.h() == 2) {
                                                    olaNetworkService2.s(gVar.m());
                                                }
                                            }
                                            h.u.a(bVar);
                                            chat.ola.vn.c.c().j();
                                        }
                                        dialogInterface.dismiss();
                                    }
                                });
                                return;
                            } else {
                                if (str2.equalsIgnoreCase(context.getString(R.string.string_more_action))) {
                                    b.this.g(context, bVar);
                                    return;
                                }
                                return;
                            }
                        }
                        str = gVar.b() + (gVar.c() != null ? " #\u001b" + gVar.c() + "#" : "");
                        if (m.a(str)) {
                            return;
                        }
                        String strA = o.a(context);
                        if (!m.a(strA)) {
                            str = strA + " " + str;
                        }
                        context2 = context;
                    }
                    o.a(context2, str);
                } catch (Throwable unused2) {
                }
            }
        });
        mVar2.show();
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void g(final Context context, final chat.ola.vn.entry.b bVar) {
        String string;
        final String strC = bVar.c();
        if (strC == null) {
            return;
        }
        final g gVar = bVar.b;
        final ArrayList arrayList = new ArrayList();
        if (bVar.h() != 0) {
            if (bVar.h() == 1 || bVar.h() == 2) {
                arrayList.add(context.getString(R.string.string_copy));
                arrayList.add(context.getString(R.string.string_copy_plus));
                string = context.getString(R.string.string_delete_me);
            }
            chat.ola.vn.i.m mVar = new chat.ola.vn.i.m(context);
            mVar.a(arrayList);
            mVar.a(new AdapterView.OnItemClickListener() { // from class: chat.ola.vn.q.b.3
                @Override // android.widget.AdapterView.OnItemClickListener
                public void onItemClick(AdapterView<?> adapterView, View view, int i, long j) {
                    String str;
                    String str2;
                    Context context2;
                    String str3;
                    try {
                        String str4 = (String) arrayList.get(i);
                        if (str4.equalsIgnoreCase(context.getString(R.string.string_discard_me_top))) {
                            if (OlaApplication.b != null) {
                                OlaApplication.b.p();
                                return;
                            }
                            return;
                        }
                        if (str4.equalsIgnoreCase(context.getString(R.string.string_chat))) {
                            OlaChatViewActivity.a(context, OlaApplication.b, strC, (short) 0);
                            return;
                        }
                        if (str4.equalsIgnoreCase(context.getString(R.string.string_make_friend))) {
                            return;
                        }
                        if (str4.equalsIgnoreCase(context.getString(R.string.string_share))) {
                            b.this.h(context, bVar);
                            return;
                        }
                        if (str4.equalsIgnoreCase(context.getString(R.string.string_post_me_top))) {
                            OlaNetworkService olaNetworkService = OlaApplication.b;
                            if (olaNetworkService != null) {
                                olaNetworkService.a(gVar.e());
                                return;
                            }
                            return;
                        }
                        if (str4.equalsIgnoreCase(context.getString(R.string.general_tab_translater))) {
                            z.a(context, bVar.c.toString());
                            return;
                        }
                        if (str4.equalsIgnoreCase(context.getString(R.string.string_copy))) {
                            if (gVar.c() != null) {
                                str3 = " #\u001b" + gVar.c() + "#";
                            } else {
                                str3 = "";
                            }
                            try {
                                if (bVar.g() != null) {
                                    Iterator<String> it2 = bVar.g().iterator();
                                    while (it2.hasNext()) {
                                        str3 = str3 + " #\u001b" + it2.next() + "#";
                                    }
                                }
                            } catch (Throwable unused) {
                            }
                            context2 = context;
                            str2 = gVar.b() + str3;
                        } else {
                            if (!str4.equalsIgnoreCase(context.getString(R.string.string_copy_plus))) {
                                if (str4.equalsIgnoreCase(context.getString(R.string.string_delete_me))) {
                                    chat.ola.vn.i.i.d(context, context.getString(R.string.string_delete_me), context.getString(R.string.message_delete_me_format, strC), context.getString(R.string.string_delete_me), context.getString(R.string.string_cancel), new DialogInterface.OnClickListener() { // from class: chat.ola.vn.q.b.3.1
                                        @Override // android.content.DialogInterface.OnClickListener
                                        public void onClick(DialogInterface dialogInterface, int i2) {
                                            if (i2 == 0) {
                                                OlaNetworkService olaNetworkService2 = OlaApplication.b;
                                                if (olaNetworkService2 != null) {
                                                    if (bVar.h() == 0) {
                                                        olaNetworkService2.b(gVar.e());
                                                    } else if (bVar.h() == 1) {
                                                        olaNetworkService2.r(gVar.m());
                                                    } else if (bVar.h() == 2) {
                                                        olaNetworkService2.s(gVar.m());
                                                    }
                                                }
                                                h.u.a(bVar);
                                                chat.ola.vn.c.c().j();
                                            }
                                            dialogInterface.dismiss();
                                        }
                                    });
                                    return;
                                }
                                return;
                            }
                            if (gVar.c() != null) {
                                str = " #\u001b" + gVar.c() + "#";
                            } else {
                                str = "";
                            }
                            str2 = gVar.b() + str;
                            if (m.a(str2)) {
                                return;
                            }
                            String strA = o.a(context);
                            if (!m.a(strA)) {
                                str2 = strA + " " + str2;
                            }
                            context2 = context;
                        }
                        o.a(context2, str2);
                    } catch (Throwable unused2) {
                    }
                }
            });
            mVar.show();
        }
        if (!m.a(strC, h.a())) {
            arrayList.add(context.getString(R.string.string_share));
        }
        arrayList.add(context.getString(R.string.string_post_me_top));
        string = context.getString(R.string.general_tab_translater);
        arrayList.add(string);
        chat.ola.vn.i.m mVar2 = new chat.ola.vn.i.m(context);
        mVar2.a(arrayList);
        mVar2.a(new AdapterView.OnItemClickListener() { // from class: chat.ola.vn.q.b.3
            @Override // android.widget.AdapterView.OnItemClickListener
            public void onItemClick(AdapterView<?> adapterView, View view, int i, long j) {
                String str;
                String str2;
                Context context2;
                String str3;
                try {
                    String str4 = (String) arrayList.get(i);
                    if (str4.equalsIgnoreCase(context.getString(R.string.string_discard_me_top))) {
                        if (OlaApplication.b != null) {
                            OlaApplication.b.p();
                            return;
                        }
                        return;
                    }
                    if (str4.equalsIgnoreCase(context.getString(R.string.string_chat))) {
                        OlaChatViewActivity.a(context, OlaApplication.b, strC, (short) 0);
                        return;
                    }
                    if (str4.equalsIgnoreCase(context.getString(R.string.string_make_friend))) {
                        return;
                    }
                    if (str4.equalsIgnoreCase(context.getString(R.string.string_share))) {
                        b.this.h(context, bVar);
                        return;
                    }
                    if (str4.equalsIgnoreCase(context.getString(R.string.string_post_me_top))) {
                        OlaNetworkService olaNetworkService = OlaApplication.b;
                        if (olaNetworkService != null) {
                            olaNetworkService.a(gVar.e());
                            return;
                        }
                        return;
                    }
                    if (str4.equalsIgnoreCase(context.getString(R.string.general_tab_translater))) {
                        z.a(context, bVar.c.toString());
                        return;
                    }
                    if (str4.equalsIgnoreCase(context.getString(R.string.string_copy))) {
                        if (gVar.c() != null) {
                            str3 = " #\u001b" + gVar.c() + "#";
                        } else {
                            str3 = "";
                        }
                        try {
                            if (bVar.g() != null) {
                                Iterator<String> it2 = bVar.g().iterator();
                                while (it2.hasNext()) {
                                    str3 = str3 + " #\u001b" + it2.next() + "#";
                                }
                            }
                        } catch (Throwable unused) {
                        }
                        context2 = context;
                        str2 = gVar.b() + str3;
                    } else {
                        if (!str4.equalsIgnoreCase(context.getString(R.string.string_copy_plus))) {
                            if (str4.equalsIgnoreCase(context.getString(R.string.string_delete_me))) {
                                chat.ola.vn.i.i.d(context, context.getString(R.string.string_delete_me), context.getString(R.string.message_delete_me_format, strC), context.getString(R.string.string_delete_me), context.getString(R.string.string_cancel), new DialogInterface.OnClickListener() { // from class: chat.ola.vn.q.b.3.1
                                    @Override // android.content.DialogInterface.OnClickListener
                                    public void onClick(DialogInterface dialogInterface, int i2) {
                                        if (i2 == 0) {
                                            OlaNetworkService olaNetworkService2 = OlaApplication.b;
                                            if (olaNetworkService2 != null) {
                                                if (bVar.h() == 0) {
                                                    olaNetworkService2.b(gVar.e());
                                                } else if (bVar.h() == 1) {
                                                    olaNetworkService2.r(gVar.m());
                                                } else if (bVar.h() == 2) {
                                                    olaNetworkService2.s(gVar.m());
                                                }
                                            }
                                            h.u.a(bVar);
                                            chat.ola.vn.c.c().j();
                                        }
                                        dialogInterface.dismiss();
                                    }
                                });
                                return;
                            }
                            return;
                        }
                        if (gVar.c() != null) {
                            str = " #\u001b" + gVar.c() + "#";
                        } else {
                            str = "";
                        }
                        str2 = gVar.b() + str;
                        if (m.a(str2)) {
                            return;
                        }
                        String strA = o.a(context);
                        if (!m.a(strA)) {
                            str2 = strA + " " + str2;
                        }
                        context2 = context;
                    }
                    o.a(context2, str2);
                } catch (Throwable unused2) {
                }
            }
        });
        mVar2.show();
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void h(final Context context, final chat.ola.vn.entry.b bVar) {
        chat.ola.vn.i.i.a(context, R.string.dialog_title_inform, R.string.me_message_share_confirm, R.string.string_share, R.string.string_close, new DialogInterface.OnClickListener() { // from class: chat.ola.vn.q.b.4
            @Override // android.content.DialogInterface.OnClickListener
            public void onClick(DialogInterface dialogInterface, int i) {
                if (i == 0) {
                    b.this.a(context, bVar);
                }
                dialogInterface.dismiss();
            }
        });
    }

    @Override // chat.ola.vn.activity.OlaCropImageActivity.a
    public void D() {
        chat.ola.vn.c.c().j();
    }

    @Override // chat.ola.vn.activity.OlaCropImageActivity.a
    public void E() {
        chat.ola.vn.c.c().j();
    }

    @Override // chat.ola.vn.activity.OlaCropImageActivity.a
    public void F() {
    }

    @Override // chat.ola.vn.activity.OlaCropImageActivity.a
    public void G() {
    }

    protected void a(final Context context, chat.ola.vn.entry.b bVar) {
        String str;
        short s;
        StringBuilder sb = new StringBuilder();
        sb.append("\n");
        sb.append(context.getString(R.string.me_message_author_format, "@" + bVar.b.a()));
        StringBuilder sb2 = new StringBuilder(sb.toString());
        StringBuilder sb3 = new StringBuilder();
        String strA = null;
        try {
            for (String str2 : bVar.i) {
                if (strA == null) {
                    strA = str2;
                } else {
                    sb3.append("#\u001b");
                    sb3.append(str2);
                    sb3.append("# ");
                }
            }
        } catch (Throwable unused) {
        }
        try {
            for (String str3 : bVar.k) {
                if (strA == null) {
                    strA = str3;
                } else {
                    sb3.append("#\u001b");
                    sb3.append(str3);
                    sb3.append("# ");
                }
            }
        } catch (Throwable unused2) {
        }
        try {
            for (String str4 : bVar.j) {
                if (strA == null) {
                    strA = str4;
                } else {
                    sb3.append("#\u001b");
                    sb3.append(str4);
                    sb3.append("# ");
                }
            }
        } catch (Throwable unused3) {
        }
        sb3.append(chat.ola.vn.util.i.d(bVar.b.b(), "").toString());
        sb3.append((CharSequence) sb2);
        w wVarB = bVar.b.B();
        if (wVarB != null) {
            short sC = (short) wVarB.c();
            if (strA == null) {
                strA = wVarB.a();
            }
            str = strA;
            s = sC;
        } else {
            str = strA;
            s = 0;
        }
        OlaNetworkService olaNetworkService = OlaApplication.b;
        if (olaNetworkService != null) {
            olaNetworkService.a(sb3.toString(), str, s, (String) null, (short) 0);
        }
        chat.ola.vn.i.i.a(context, R.string.string_share_watting, 3000L, new Runnable() { // from class: chat.ola.vn.q.b.5
            @Override // java.lang.Runnable
            public void run() {
                chat.ola.vn.me.c.a(context, (String) null);
            }
        });
    }

    public boolean a(Context context, View view) {
        try {
            if (view.getTag() == null) {
                return false;
            }
            switch (view.getId()) {
                case R.id.btnMeItemFooterReply /* 2131296501 */:
                    h(context, (chat.ola.vn.entry.b) view.getTag());
                    return true;
                case R.id.contactIdTextView /* 2131296697 */:
                case R.id.profilePictureImageView /* 2131297255 */:
                case R.id.suggestedFriendItemLayout /* 2131297447 */:
                    OlaUserMePageActivity.a(context, ((chat.ola.vn.message.f) view.getTag()).j());
                    return true;
                case R.id.imgMeAvatarThumbnail /* 2131296910 */:
                    break;
                case R.id.imgMeItemMediaSound /* 2131296914 */:
                    c(context, view);
                    return true;
                case R.id.imgMeItemMediaVideo /* 2131296915 */:
                    d(context, view);
                    return true;
                case R.id.imgMeYoutubeThumbnail1 /* 2131296917 */:
                case R.id.linearYoutubeSpan /* 2131297031 */:
                    e(context, view);
                    return true;
                case R.id.meOwnerInfoSpan /* 2131297082 */:
                    a(context, ((chat.ola.vn.entry.b) view.getTag()).c());
                    return true;
                case R.id.mediaImageView1 /* 2131297096 */:
                    a(context, view, 0);
                    return true;
                case R.id.mediaImageView2 /* 2131297097 */:
                    a(context, view, 1);
                    return true;
                case R.id.mediaImageView3 /* 2131297098 */:
                    a(context, view, 2);
                    return true;
                case R.id.mediaImageView4 /* 2131297099 */:
                    a(context, view, 3);
                    return true;
                case R.id.mediaImageView5 /* 2131297100 */:
                    a(context, view, 4);
                    return true;
                case R.id.txtMeItemLikeWrapper /* 2131297614 */:
                    chat.ola.vn.entry.b bVar = (chat.ola.vn.entry.b) view.getTag();
                    if (bVar.b.i() != 1) {
                        b(context, view, bVar);
                        String strC = bVar.c();
                        if (!m.a(strC) && !m.b(strC, h.a())) {
                            OlaApplication.b.i(strC);
                            chat.ola.vn.c cVarC = chat.ola.vn.c.c();
                            if (cVarC != null) {
                                cVarC.a(view, cVarC.z());
                            }
                        }
                        return true;
                    }
                    break;
                default:
                    return false;
            }
            if (view.getTag() == null) {
                return false;
            }
            String strC2 = ((chat.ola.vn.entry.b) view.getTag()).c();
            if (!m.a(strC2)) {
                if (m.b(strC2, h.a())) {
                    OlaUserMePageActivity.a(context, strC2);
                    return true;
                }
                OlaApplication.b.i(strC2);
                chat.ola.vn.c cVarC2 = chat.ola.vn.c.c();
                if (cVarC2 != null) {
                    cVarC2.a(view, cVarC2.z());
                }
            }
            return true;
        } catch (Throwable unused) {
            return false;
        }
    }

    /* JADX WARN: Can't fix incorrect switch cases order, some code will duplicate */
    public void b(final Context context, View view) {
        long jCurrentTimeMillis;
        d dVarS;
        chat.ola.vn.entry.b bVar;
        OlaNetworkService olaNetworkService;
        String str;
        String str2;
        String str3;
        String str4;
        String str5;
        String strJ;
        List<String> list;
        chat.ola.vn.entry.b bVar2;
        int i;
        StringBuilder sb;
        String str6;
        try {
            jCurrentTimeMillis = System.currentTimeMillis();
        } catch (Throwable unused) {
            return;
        }
        switch (view.getId()) {
            case R.id.advButton1 /* 2131296315 */:
            case R.id.advButton2 /* 2131296316 */:
            case R.id.advButton3 /* 2131296317 */:
                dVarS = (d) view.getTag();
                try {
                    OlaApplication.b.l(dVarS.g(), dVarS.a());
                    break;
                } catch (Throwable unused2) {
                }
                if (m.b(dVarS.a(), "like") || m.b(dVarS.a(), "likeadme")) {
                    a(context, view, dVarS);
                }
                d.a(context, dVarS);
                break;
            case R.id.advImage /* 2131296325 */:
                chat.ola.vn.entry.b bVar3 = (chat.ola.vn.entry.b) view.getTag();
                d dVarS2 = bVar3.b.s();
                if (dVarS2 == null || m.a(dVarS2.a())) {
                    try {
                        OlaApplication.b.l(bVar3.b.u(), dVarS2.a());
                        break;
                    } catch (Throwable unused3) {
                    }
                    OlaImageViewerActivity.a(context, view, 0, bVar3);
                } else {
                    try {
                        OlaApplication.b.l(bVar3.b.u(), dVarS2.a());
                        break;
                    } catch (Throwable unused4) {
                    }
                    d.a(context, dVarS2);
                }
                break;
            case R.id.advProductTitle /* 2131296327 */:
                if (view.getTag() != null) {
                    bVar = (chat.ola.vn.entry.b) view.getTag();
                    if (bVar.b.s() != null) {
                        dVarS = bVar.b.s();
                        try {
                            OlaApplication.b.l(bVar.b.u(), dVarS.a());
                            break;
                        } catch (Throwable unused5) {
                        }
                        d.a(context, dVarS);
                    } else {
                        try {
                            OlaApplication.b.l(bVar.b.u(), "viewme");
                            break;
                        } catch (Throwable unused6) {
                        }
                        strJ = bVar.c();
                        chat.ola.vn.me.c.a(context, strJ);
                    }
                    break;
                }
                break;
            case R.id.advSoftwareFrameLayout /* 2131296328 */:
            case R.id.advSoftwareRatingBar /* 2131296333 */:
                k kVar = (k) view.getTag();
                if (!m.a(kVar.h)) {
                    chat.ola.vn.util.b.n(context, kVar.h);
                    olaNetworkService = OlaApplication.b;
                    str = kVar.g;
                    olaNetworkService.l(str, "wap");
                }
                break;
            case R.id.advSoftwareVideoLayout /* 2131296338 */:
                k kVar2 = (k) view.getTag();
                if (!m.a(kVar2.b)) {
                    str2 = kVar2.b;
                    chat.ola.vn.util.b.a(context, str2, view);
                } else if (!m.a(kVar2.h)) {
                    chat.ola.vn.util.b.n(context, kVar2.h);
                    olaNetworkService = OlaApplication.b;
                    str = kVar2.g;
                    olaNetworkService.l(str, "wap");
                }
                break;
            case R.id.advViewCount /* 2131296342 */:
                if (view.getTag() != null) {
                    chat.ola.vn.entry.b bVar4 = (chat.ola.vn.entry.b) view.getTag();
                    if (bVar4.b.A() > 0) {
                        chat.ola.vn.util.b.a(context);
                    } else if (bVar4.b.c) {
                        chat.ola.vn.util.b.a(context, bVar4.b.e());
                    }
                    break;
                }
                break;
            case R.id.attachedMeCommentMediaPan /* 2131296372 */:
                if (view.getTag() != null) {
                    chat.ola.vn.entity.f fVar = (chat.ola.vn.entity.f) view.getTag();
                    if (m.a(fVar.e)) {
                        if (!m.a(fVar.o)) {
                            str3 = fVar.o;
                            chat.ola.vn.util.b.a(context, str3);
                        } else if (!m.a(fVar.n)) {
                            try {
                                chat.ola.vn.util.b.a((chat.ola.vn.c) context, fVar.n, 0, view.getTop());
                            } catch (Throwable th) {
                                th.printStackTrace();
                                return;
                            }
                        }
                        break;
                    } else {
                        switch (i.i(fVar.e)) {
                            case 1:
                                try {
                                    g gVar = new g();
                                    gVar.a((byte) 0);
                                    gVar.b(fVar.c);
                                    gVar.a(fVar.f);
                                    gVar.b(fVar.d.toString());
                                    gVar.b(fVar.t);
                                    gVar.a(fVar.r);
                                    gVar.c(fVar.c());
                                    gVar.c(fVar.e);
                                    OlaImageViewerActivity.a(context, view, 0, new chat.ola.vn.entry.b(gVar));
                                } catch (Throwable unused7) {
                                    OlaImageViewerActivity.a(context, (View) null, t.a().b(fVar.e), 0, new OlaMediaEntity(fVar.e, o.g(fVar.e), (short) 1));
                                    return;
                                }
                                break;
                            case 2:
                                str4 = fVar.e;
                                chat.ola.vn.util.b.h(context, str4);
                                break;
                            case 3:
                                str5 = fVar.e;
                                chat.ola.vn.util.b.f(context, str5);
                                break;
                        }
                    }
                    break;
                }
                break;
            case R.id.attachedMeCommentNumberOfLike /* 2131296375 */:
                if (view.getTag() != null) {
                    chat.ola.vn.entity.f fVar2 = (chat.ola.vn.entity.f) view.getTag();
                    if (OlaApplication.b.b(fVar2.c, !fVar2.a())) {
                        if (fVar2.a()) {
                            fVar2.a((short) 0);
                            fVar2.r--;
                            if (fVar2.r < 0) {
                                fVar2.r = 0;
                            }
                        } else {
                            fVar2.a((short) 1);
                            fVar2.r++;
                        }
                        chat.ola.vn.c.c().j();
                        break;
                    }
                }
                break;
            case R.id.attachedMeItemSpan /* 2131296377 */:
                if (view.getTag() != null) {
                    chat.ola.vn.entity.f fVar3 = (chat.ola.vn.entity.f) view.getTag();
                    d.a(context, fVar3.b);
                    if (m.b(fVar3.b.a(), "rss")) {
                        String strB = fVar3.b.b();
                        if (m.a(strB)) {
                            strB = fVar3.b.c();
                        }
                        if (!m.a(strB)) {
                            OlaApplication.b.d(strB, (String) null, (short) 0);
                        }
                    }
                    break;
                }
                break;
            case R.id.btnAdMeClose /* 2131296421 */:
                chat.ola.vn.entry.b bVar5 = (chat.ola.vn.entry.b) view.getTag();
                if (m.b(bVar5.b.q(), "update")) {
                    h.L = null;
                    h.M = null;
                    h.N = null;
                    h.u.a(bVar5);
                } else if (h.H == 0) {
                    chat.ola.vn.i.i.c(context);
                } else {
                    h.u.a(bVar5);
                }
                chat.ola.vn.c.c().j();
                break;
            case R.id.btnAdMeItemLikeSpan /* 2131296422 */:
                chat.ola.vn.entry.b bVar6 = (chat.ola.vn.entry.b) view.getTag();
                OlaAdMeLikeListActivity.a(context, bVar6.b.u(), bVar6.b.f());
                break;
            case R.id.btnMeHistoryStoryClose /* 2131296498 */:
                h.u.a((chat.ola.vn.entry.b) view.getTag());
                chat.ola.vn.c.c().j();
                break;
            case R.id.btnMeItemFooterMore /* 2131296500 */:
                if (view.getTag() != null) {
                    c(context, (chat.ola.vn.entry.b) view.getTag());
                    break;
                }
                break;
            case R.id.btnMeItemFooterReply /* 2131296501 */:
                if (view.getTag() != null) {
                    b(context, (chat.ola.vn.entry.b) view.getTag());
                    break;
                }
                break;
            case R.id.btnMeItemFooterShare /* 2131296502 */:
                if (view.getTag() != null) {
                    String strB2 = ((chat.ola.vn.entry.b) view.getTag()).a.b.b();
                    if (!m.a(strB2)) {
                        OlaApplication.b.a(OlaApplication.a(R.string.string_shared_this) + "\nrss://" + strB2, (String) null, (short) 0, (String) null, (short) 0);
                        chat.ola.vn.i.i.a(context, R.string.dialog_title_inform, R.string.message_shared_on_your_timeline);
                    }
                    break;
                }
                break;
            case R.id.btnMeItemLikeSpan /* 2131296503 */:
                chat.ola.vn.entry.b bVar7 = (chat.ola.vn.entry.b) view.getTag();
                OlaMeLikerListActivity.a(context, bVar7.b.f(), bVar7.b.e());
                break;
            case R.id.btnMeItemViewComment /* 2131296504 */:
                if (view.getTag() != null) {
                    a(context, (chat.ola.vn.entry.b) view.getTag(), jCurrentTimeMillis);
                    break;
                }
                break;
            case R.id.contactIdTextView /* 2131296697 */:
            case R.id.profilePictureImageView /* 2131297255 */:
            case R.id.suggestedFriendItemLayout /* 2131297447 */:
                strJ = ((chat.ola.vn.message.f) view.getTag()).j();
                chat.ola.vn.me.c.a(context, strJ);
                break;
            case R.id.imgHistoryStoryCover /* 2131296890 */:
            case R.id.imgHistoryStorySymbol /* 2131296891 */:
            case R.id.txtMeHistoryStorySubTitle /* 2131297605 */:
            case R.id.txtMeHistoryStoryTitle /* 2131297606 */:
                d.a(context, (d) view.getTag());
                break;
            case R.id.imgMeAvatarThumbnail /* 2131296910 */:
            case R.id.meOwnerInfoSpan /* 2131297082 */:
            case R.id.txtMeItemTitle /* 2131297616 */:
                if (view.getTag() != null) {
                    bVar = (chat.ola.vn.entry.b) view.getTag();
                    strJ = bVar.c();
                    chat.ola.vn.me.c.a(context, strJ);
                    break;
                }
                break;
            case R.id.imgMeItemMediaSound /* 2131296914 */:
                if (view.getTag() != null) {
                    chat.ola.vn.entry.b bVar8 = (chat.ola.vn.entry.b) view.getTag();
                    if (bVar8.k != null && !bVar8.k.isEmpty()) {
                        if (bVar8.k.size() != 1) {
                            list = bVar8.k;
                            a(context, view, list);
                        } else {
                            str5 = bVar8.k.get(0);
                            chat.ola.vn.util.b.f(context, str5);
                        }
                        break;
                    }
                }
                break;
            case R.id.imgMeItemMediaVideo /* 2131296915 */:
                if (view.getTag() != null) {
                    chat.ola.vn.entry.b bVar9 = (chat.ola.vn.entry.b) view.getTag();
                    if (bVar9.j != null && !bVar9.j.isEmpty()) {
                        if (bVar9.j.size() != 1) {
                            list = bVar9.j;
                            a(context, view, list);
                        } else {
                            str4 = bVar9.j.get(0);
                            chat.ola.vn.util.b.h(context, str4);
                        }
                        break;
                    }
                }
                break;
            case R.id.imgMeYoutubeThumbnail1 /* 2131296917 */:
            case R.id.linearYoutubeSpan /* 2131297031 */:
                chat.ola.vn.entry.b bVar10 = (chat.ola.vn.entry.b) view.getTag();
                if (!m.a(bVar10.m)) {
                    switch (bVar10.l) {
                        case 1:
                            str3 = bVar10.m;
                            chat.ola.vn.util.b.a(context, str3);
                            break;
                        case 2:
                            str4 = bVar10.m;
                            chat.ola.vn.util.b.h(context, str4);
                            break;
                        default:
                            str2 = bVar10.m;
                            chat.ola.vn.util.b.a(context, str2, view);
                            break;
                    }
                }
                break;
            case R.id.mediaImageView1 /* 2131297096 */:
                a(context, view, 0, (chat.ola.vn.entry.b) view.getTag());
                break;
            case R.id.mediaImageView2 /* 2131297097 */:
                a(context, view, 1, (chat.ola.vn.entry.b) view.getTag());
                break;
            case R.id.mediaImageView3 /* 2131297098 */:
                bVar2 = (chat.ola.vn.entry.b) view.getTag();
                i = 2;
                a(context, view, i, bVar2);
                break;
            case R.id.mediaImageView4 /* 2131297099 */:
                bVar2 = (chat.ola.vn.entry.b) view.getTag();
                i = 3;
                a(context, view, i, bVar2);
                break;
            case R.id.mediaImageView5 /* 2131297100 */:
                bVar2 = (chat.ola.vn.entry.b) view.getTag();
                i = 4;
                a(context, view, i, bVar2);
                break;
            case R.id.txtAdMeTitleContainer /* 2131297515 */:
                chat.ola.vn.util.b.a(context);
                break;
            case R.id.txtCheckInAction /* 2131297539 */:
            case R.id.vLinearMeCheckInInfo /* 2131297744 */:
                chat.ola.vn.entity.o oVar = (chat.ola.vn.entity.o) view.getTag();
                Bundle bundle = new Bundle();
                bundle.putString("_byte_data", oVar.d().b());
                Intent intent = new Intent(context, (Class<?>) OlaVenueDetailActivity.class);
                intent.setFlags(131072);
                intent.putExtras(bundle);
                context.startActivity(intent);
                ((chat.ola.vn.c) context).overridePendingTransition(R.anim.push_left_in, R.anim.push_left_out);
                break;
            case R.id.txtMeItemDislikeWrapper /* 2131297610 */:
                if (view.getTag() != null) {
                    a(context, view, (chat.ola.vn.entry.b) view.getTag());
                    break;
                }
                break;
            case R.id.txtMeItemLikeWrapper /* 2131297614 */:
                if (view.getTag() != null) {
                    b(context, view, (chat.ola.vn.entry.b) view.getTag());
                    break;
                }
                break;
            case R.id.txtMeUserNote /* 2131297625 */:
                j.a(context, "note/" + ((chat.ola.vn.entry.b) view.getTag()).c());
                break;
            case R.id.viewAllSuggestedPhotoTextView /* 2131297766 */:
                chat.ola.vn.entry.b bVar11 = (chat.ola.vn.entry.b) view.getTag();
                if (!m.a(bVar11.f)) {
                    if (!m.b(h.a(), bVar11.f)) {
                        OlaCloudPhotoListActivity.a(context, bVar11.f);
                    } else {
                        OlaCloudAlbumListActivity.a(context);
                    }
                }
                break;
            case R.id.viewAllTextView /* 2131297767 */:
                OlaSuggestedFriendListActivity.a(context, true);
                break;
            case R.id.vipAccountGroup /* 2131297772 */:
                if (m.b(x.i(), "vi")) {
                    sb = new StringBuilder();
                    sb.append("vip_account_introduction");
                    str6 = "-vi.html";
                } else {
                    sb = new StringBuilder();
                    sb.append("vip_account_introduction");
                    str6 = "-en.html";
                }
                sb.append(str6);
                chat.ola.vn.i.o.a(context, R.string.message_vip_account, sb.toString()).a(R.string.string_buy_vip, new Runnable() { // from class: chat.ola.vn.q.b.8
                    @Override // java.lang.Runnable
                    public void run() {
                        try {
                            BuyVipActivity.a(context);
                        } catch (Throwable unused8) {
                        }
                    }
                });
                break;
        }
    }

    @Override // chat.ola.vn.activity.OlaCropImageActivity.a
    public void b_() {
    }

    @Override // chat.ola.vn.activity.OlaCropImageActivity.a
    public void f(String str) {
    }
}
