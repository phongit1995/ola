package chat.ola.vn.entry.b;

import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.text.SpannableString;
import android.text.style.ForegroundColorSpan;
import android.view.View;
import android.view.ViewGroup;
import android.view.ViewStub;
import android.widget.ImageView;
import android.widget.TextView;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import chat.ola.vn.b.al;
import chat.ola.vn.entity.OlaCheckInActionEntity;
import chat.ola.vn.entity.OlaCheckInItemEntity;
import chat.ola.vn.entity.OlaVenueEntity;
import chat.ola.vn.view.AutoScrollTextView;
import chat.ola.vn.view.OlaCachedImageView;
import chat.ola.vn.view.OlaGalleryView;
import chat.ola.vn.view.OlaRatioImageView;
import com.mg.ola.common.widget.CommpressTextView;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public class ab extends j implements chat.ola.vn.p.a {
    private OlaCachedImageView A;
    private View B;
    private View C;
    private View D;
    private View E;
    private ImageView F;
    private ImageView G;
    private View H;
    private ViewGroup I;
    private TextView J;
    private chat.ola.vn.entry.b.a.b K;
    private TextView M;
    private View N;
    private OlaCachedImageView[] O;
    private OlaCachedImageView[] P;
    private AutoScrollTextView Q;
    private TextView R;
    private OlaCachedImageView S;
    private ViewStub T;
    private ViewStub U;
    private View W;
    private OlaCachedImageView X;
    private View Y;
    private ImageView aa;
    public TextView i;
    public CommpressTextView j;
    protected OlaCachedImageView k;
    public TextView l;
    public TextView m;
    public TextView n;
    public TextView o;
    public View p;
    public TextView q;
    public TextView r;
    public TextView s;
    public View t;
    public View u;
    View v;
    OlaGalleryView w;
    al x;
    TextView y;
    private OlaCachedImageView z;
    private boolean L = false;
    private View V = null;
    private chat.ola.vn.entity.y Z = null;

    public ab(View view, int i) {
        this.T = null;
        this.U = null;
        try {
            view.setClickable(true);
            this.z = (OlaCachedImageView) view.findViewById(R.id.imgMeAvatarThumbnail);
            this.A = (OlaCachedImageView) view.findViewById(R.id.vipImageMeOwner);
            this.H = view.findViewById(R.id.meOwnerInfoSpan);
            try {
                this.I = (ViewGroup) view.findViewById(R.id.attachedMeItemSpan);
            } catch (Throwable unused) {
            }
            try {
                this.J = (TextView) view.findViewById(R.id.advViewCount);
            } catch (Throwable unused2) {
            }
            this.d = view.findViewById(R.id.meContentView);
            this.i = (TextView) view.findViewById(R.id.txtMeItemTitle);
            this.k = (OlaCachedImageView) view.findViewById(R.id.stickerImageView);
            this.j = (CommpressTextView) view.findViewById(R.id.txtMeItemContent);
            this.j.setMoreText(OlaApplication.a(R.string.string_view_more));
            this.j.setOlaSpanClickListener(chat.ola.vn.q.a.a());
            this.l = (TextView) view.findViewById(R.id.imgMeItemMediaSound);
            this.m = (TextView) view.findViewById(R.id.imgMeItemMediaVideo);
            this.n = (TextView) view.findViewById(R.id.txtMeItemTimeAgo);
            this.o = (TextView) view.findViewById(R.id.btnMeItemViewComment);
            this.aa = (ImageView) view.findViewById(R.id.btnMakeFriend);
            this.q = (TextView) view.findViewById(R.id.txtMeItemLikeNumber);
            this.r = (TextView) view.findViewById(R.id.txtMeItemLikeTextView);
            this.s = (TextView) view.findViewById(R.id.txtMeItemDislikeTextView);
            this.F = (ImageView) view.findViewById(R.id.txtMeItemLikeIcon);
            this.G = (ImageView) view.findViewById(R.id.txtMeItemDislikeIcon);
            this.D = view.findViewById(R.id.txtMeItemLikeWrapper);
            this.E = view.findViewById(R.id.txtMeItemDislikeWrapper);
            this.p = view.findViewById(R.id.btnMeItemFooterReply);
            this.B = view.findViewById(R.id.btnMeItemFooterMore);
            this.C = view.findViewById(R.id.btnMeItemLikeSpan);
            try {
                this.P = new OlaCachedImageView[3];
                this.P[0] = (OlaCachedImageView) view.findViewById(R.id.imgMeItemLikeBuddy1);
                this.P[1] = (OlaCachedImageView) view.findViewById(R.id.imgMeItemLikeBuddy2);
                this.P[2] = (OlaCachedImageView) view.findViewById(R.id.imgMeItemLikeBuddy3);
            } catch (Exception unused3) {
            }
            this.j.setEclipesizeMaxLine(6);
            this.t = view.findViewById(R.id.btnMeActionSpan);
            this.u = view.findViewById(R.id.btnMeActionSpanDivider);
            try {
                this.j.setMoreTextColor(chat.ola.vn.f.A);
            } catch (Throwable th) {
                th.printStackTrace();
            }
            this.T = (ViewStub) view.findViewById(R.id.meMediaAttachedViewStub);
            if (i != 0) {
                this.T.setLayoutResource(i);
                this.T.setVisibility(0);
                this.O = new OlaCachedImageView[5];
                try {
                    this.O[0] = (OlaCachedImageView) view.findViewById(R.id.mediaImageView1);
                    this.O[1] = (OlaCachedImageView) view.findViewById(R.id.mediaImageView2);
                    this.O[2] = (OlaCachedImageView) view.findViewById(R.id.mediaImageView3);
                    this.O[3] = (OlaCachedImageView) view.findViewById(R.id.mediaImageView4);
                    this.O[4] = (OlaCachedImageView) view.findViewById(R.id.mediaImageView5);
                    this.M = (TextView) view.findViewById(R.id.moreMediaTextView);
                    this.N = view.findViewById(R.id.theTenViewLayout);
                } catch (Throwable unused4) {
                }
            } else if (this.T != null) {
                this.T.setVisibility(8);
            }
            this.U = (ViewStub) view.findViewById(R.id.meCheckInViewStub);
        } catch (Throwable unused5) {
        }
    }

    private void h() {
        if (this.a != null) {
            View.OnClickListener onClickListener = new View.OnClickListener() { // from class: chat.ola.vn.entry.b.ab.1
                @Override // android.view.View.OnClickListener
                public void onClick(View view) {
                    view.setTag(ab.this.b);
                    ab.this.a.onClick(view);
                }
            };
            if (this.z != null) {
                this.z.setOnClickListener(onClickListener);
                this.z.setTag(this.b);
                this.z.setOnLongClickListener(this.e);
            }
            this.H.setOnClickListener(onClickListener);
            this.H.setTag(this.b);
            this.H.setOnLongClickListener(this.e);
            this.o.setOnClickListener(onClickListener);
            this.p.setOnClickListener(onClickListener);
            this.m.setOnClickListener(onClickListener);
            this.l.setOnClickListener(onClickListener);
            this.B.setOnClickListener(onClickListener);
            this.D.setOnClickListener(onClickListener);
            this.E.setOnClickListener(onClickListener);
            this.C.setOnClickListener(onClickListener);
            this.p.setTag(this.b);
            this.p.setOnLongClickListener(this.e);
            this.D.setTag(this.b);
            this.E.setTag(this.b);
            this.D.setOnLongClickListener(this.e);
            if (this.J != null) {
                this.J.setOnClickListener(onClickListener);
            }
            if (this.aa != null) {
                this.aa.setOnClickListener(onClickListener);
            }
            if (this.v != null) {
                this.v.setTag(this.b);
                this.v.setOnClickListener(onClickListener);
            }
        }
        if (this.e != null) {
            View.OnLongClickListener onLongClickListener = new View.OnLongClickListener() { // from class: chat.ola.vn.entry.b.ab.2
                @Override // android.view.View.OnLongClickListener
                public boolean onLongClick(View view) {
                    view.setTag(ab.this.b);
                    return ab.this.e.onLongClick(view);
                }
            };
            this.m.setOnLongClickListener(onLongClickListener);
            this.l.setOnLongClickListener(onLongClickListener);
        }
    }

    private void i() {
        OlaCheckInItemEntity olaCheckInItemEntity;
        AutoScrollTextView autoScrollTextView;
        View.OnClickListener onClickListener;
        View view;
        try {
            if (this.b.b.z() == null) {
                if (this.U != null) {
                    this.U.setVisibility(8);
                    return;
                }
                return;
            }
            if (this.U != null && this.R == null) {
                if (this.b.g() == null || this.b.g().size() == 0) {
                    this.U.setLayoutResource(R.layout.me_entry_venue_layout);
                    this.W = this.U.inflate();
                    this.W.setVisibility(8);
                    this.Y = this.W.findViewById(R.id.vLinearMeCheckInInfo);
                } else {
                    this.U.setLayoutResource(R.layout.me_entry_venue_with_mediacodes_layout);
                    this.W = this.U.inflate();
                    this.W.setVisibility(0);
                    this.Y = this.W.findViewById(R.id.vLinearMeCheckInInfo);
                    this.Y.setVisibility(8);
                }
                this.W.setOnClickListener(this.a);
                if (this.Y != null) {
                    this.Y.setOnClickListener(this.a);
                }
                try {
                    this.S = (OlaCachedImageView) this.W.findViewById(R.id.imCheckInCover);
                } catch (Throwable unused) {
                }
                this.Q = (AutoScrollTextView) this.W.findViewById(R.id.txtCheckInAction);
                this.R = (TextView) this.W.findViewById(R.id.txtCheckInVenueName);
                this.X = (OlaCachedImageView) this.W.findViewById(R.id.imgCheckInAction);
            }
            if (this.b.b.e == null) {
                if (OlaApplication.b != null) {
                    OlaApplication.b.b(this.b.b.z(), this);
                }
                if (this.U != null) {
                    if (this.b.g() == null || this.b.g().size() == 0) {
                        view = this.W;
                    } else {
                        this.W.setVisibility(0);
                        view = this.Y;
                    }
                    view.setVisibility(8);
                    return;
                }
                return;
            }
            try {
                j();
                this.W.setTag(this.b.b.e);
                if (this.Y != null) {
                    this.Y.setTag(this.b.b.e);
                }
                if (this.b.b.e.b() != null) {
                    try {
                        olaCheckInItemEntity = this.b.b.e.c().get(0);
                    } catch (Throwable unused2) {
                        olaCheckInItemEntity = null;
                    }
                    if (olaCheckInItemEntity != null && !chat.ola.vn.util.m.c(olaCheckInItemEntity.d())) {
                        chat.ola.vn.c.f.a((Context) chat.ola.vn.c.c(), this.X, olaCheckInItemEntity.d(), R.drawable.ic_check_in_item_default, false);
                    } else if (!chat.ola.vn.util.m.c(this.b.b.e.b().c())) {
                        chat.ola.vn.c.f.a((Context) chat.ola.vn.c.c(), this.X, this.b.b.e.b().c(), R.drawable.ic_check_in_item_default, false);
                    }
                    if (!chat.ola.vn.util.m.c(this.b.b.e.b().b())) {
                        if (chat.ola.vn.util.m.c(this.b.b.e.e())) {
                            this.Q.setText(this.b.b.e.b().b());
                            if (this.b.b.e.c() != null && this.b.b.e.c().size() > 0) {
                                String strB = this.b.b.e.c().get(0).b();
                                if (!chat.ola.vn.util.m.c(strB)) {
                                    if (chat.ola.vn.util.m.c(this.b.b.e.c().get(0).g())) {
                                        this.Q.append(" ");
                                        this.Q.append(strB);
                                    } else {
                                        SpannableString spannableString = new SpannableString(strB);
                                        spannableString.setSpan(new ForegroundColorSpan(chat.ola.vn.f.A), 0, strB.length(), 33);
                                        this.Q.append(" ");
                                        this.Q.append(spannableString);
                                    }
                                    this.b.b.e.a(this.Q.getText());
                                }
                            }
                        } else {
                            this.Q.setText(this.b.b.e.e());
                        }
                        this.R.setText(this.b.b.e.d().c());
                    }
                } else {
                    this.Q.setText(this.b.b.e.d().c());
                    if (chat.ola.vn.util.m.c(this.b.b.e.d().e())) {
                        this.R.setVisibility(8);
                    } else {
                        this.R.setVisibility(0);
                        this.R.setText(this.b.b.e.d().e());
                    }
                    this.X.a(BitmapFactory.decodeResource(chat.ola.vn.c.c().getResources(), R.drawable.ic_check_in_action_default), null);
                }
                this.U.setVisibility(0);
                this.Y.setVisibility(0);
                if (chat.ola.vn.util.m.c(this.b.b.e.c().get(0).g())) {
                    this.Q.setTag(this.b.b.e);
                    autoScrollTextView = this.Q;
                    onClickListener = this.a;
                } else {
                    autoScrollTextView = this.Q;
                    onClickListener = new View.OnClickListener() { // from class: chat.ola.vn.entry.b.ab.3
                        @Override // android.view.View.OnClickListener
                        public void onClick(View view2) {
                            try {
                                chat.ola.vn.util.b.a(chat.ola.vn.c.c(), ab.this.b.b.e.c().get(0).g(), view2);
                            } catch (Throwable unused3) {
                            }
                        }
                    };
                }
                autoScrollTextView.setOnClickListener(onClickListener);
            } catch (Throwable unused3) {
            }
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    private void j() {
        try {
            if (this.S != null) {
                if (this.Z == null) {
                    if (OlaApplication.b != null) {
                        OlaApplication.b.c(this.b.b.e.d().b(), this);
                    }
                    this.S.a(null, null);
                } else {
                    if (!chat.ola.vn.util.m.c(this.Z.i())) {
                        k();
                        this.S.setVisibility(0);
                        return;
                    }
                    String strF = this.Z.f();
                    String strG = this.Z.g();
                    this.S.setVisibility(0);
                    final chat.ola.vn.c.f fVarA = chat.ola.vn.c.f.a(strG, strF, this.S.getWidth(), this.S.getHeight(), 16);
                    final String strE = fVarA.e();
                    if (this.S.a(strE)) {
                        return;
                    }
                    this.S.setScaleType(ImageView.ScaleType.CENTER_INSIDE);
                    this.S.setImageResource(R.drawable.ic_media_map);
                    chat.ola.vn.c.t.a().a(strE, new chat.ola.vn.c.i() { // from class: chat.ola.vn.entry.b.ab.4
                        @Override // chat.ola.vn.c.w
                        public void c(String str) {
                            try {
                                if (chat.ola.vn.util.m.b(str, strE)) {
                                    fVarA.a(new chat.ola.vn.c.g() { // from class: chat.ola.vn.entry.b.ab.4.1
                                        @Override // chat.ola.vn.c.g
                                        public void a(chat.ola.vn.c.f fVar) {
                                            try {
                                                if (chat.ola.vn.util.m.b(strE, fVar.e())) {
                                                    ab.this.S.setScaleType(ImageView.ScaleType.CENTER_CROP);
                                                    ab.this.S.a(fVar.c(), strE);
                                                }
                                            } catch (Throwable unused) {
                                            }
                                        }

                                        @Override // chat.ola.vn.c.g
                                        public void b(chat.ola.vn.c.f fVar) {
                                        }
                                    });
                                    new chat.ola.vn.c.e().a(fVarA);
                                }
                            } catch (Throwable unused) {
                            }
                        }

                        @Override // chat.ola.vn.c.w
                        public void c(String str, Bitmap bitmap) {
                            try {
                                if (chat.ola.vn.util.m.b(strE, str)) {
                                    ab.this.S.setScaleType(ImageView.ScaleType.CENTER_CROP);
                                    ab.this.S.a(bitmap, str);
                                }
                            } catch (Throwable unused) {
                            }
                        }
                    });
                }
            }
        } catch (Throwable unused) {
        }
    }

    private void k() {
        try {
            String strI = this.Z.i();
            if (chat.ola.vn.util.m.a(strI)) {
                return;
            }
            if (chat.ola.vn.c.f.o(strI)) {
                chat.ola.vn.c.t.a().a(strI, this.S);
            } else {
                chat.ola.vn.c.t.a().b(strI, this.S, chat.ola.vn.e.c);
            }
        } catch (Throwable unused) {
            this.S.a(null, null);
            this.S.setLoadingUrl(null);
        }
    }

    private void l() {
        if (this.b.j == null || this.b.j.isEmpty()) {
            this.m.setVisibility(8);
        } else {
            this.m.setVisibility(0);
            int size = this.b.j.size();
            if (size == 1) {
                this.m.setText("");
            } else {
                this.m.setText(size + "");
            }
            this.m.setBackgroundResource(R.drawable.ic_media_video);
        }
        if (this.b.k == null || this.b.k.isEmpty()) {
            this.l.setVisibility(8);
            return;
        }
        this.l.setVisibility(0);
        int size2 = this.b.k.size();
        this.l.setBackgroundResource(R.drawable.ic_media_sound);
        if (size2 == 1) {
            this.l.setText("");
            return;
        }
        this.l.setText(size2 + "");
    }

    private void m() {
        this.j.setFullText(this.b.c);
        this.j.setOnEclipesizeListener(null);
        if (this.b.e()) {
            this.j.a();
        } else {
            this.j.b();
        }
        this.j.setOnEclipesizeListener(new CommpressTextView.a() { // from class: chat.ola.vn.entry.b.ab.7
            @Override // com.mg.ola.common.widget.CommpressTextView.a
            public void a(boolean z) {
                ab.this.b.a(z);
            }
        });
        chat.ola.vn.entity.w wVarB = this.b.b.B();
        if (wVarB != null) {
            this.k.setVisibility(0);
            if (!chat.ola.vn.util.m.a(wVarB.a())) {
                chat.ola.vn.c.t.a().a(wVarB.a(), this.k, ImageView.ScaleType.CENTER_INSIDE, (View) null, 240);
                this.k.setScaleType(ImageView.ScaleType.CENTER_INSIDE);
                return;
            } else if (wVarB.c() > 0) {
                this.k.setImageResource(chat.ola.vn.util.c.a(wVarB.c()));
                return;
            }
        }
        this.k.setVisibility(8);
    }

    private void n() {
        OlaCachedImageView olaCachedImageView;
        int i;
        try {
            this.i.setText(this.b.b());
            switch (this.b.b.h()) {
                case 1:
                    if (this.A == null || this.A.a("2131232414")) {
                        return;
                    }
                    this.A.setVisibility(0);
                    olaCachedImageView = this.A;
                    i = R.drawable.ic_clan_role_leader;
                    break;
                case 2:
                    if (this.A == null || this.A.a("2131232416")) {
                        return;
                    }
                    this.A.setVisibility(0);
                    olaCachedImageView = this.A;
                    i = R.drawable.ic_clan_role_vice_leader;
                    break;
                case 3:
                    if (this.A == null || this.A.a("2131232415")) {
                        return;
                    }
                    this.A.setVisibility(0);
                    olaCachedImageView = this.A;
                    i = R.drawable.ic_clan_role_supporter;
                    break;
                default:
                    y();
                    return;
            }
            olaCachedImageView.setImageResource(i);
        } catch (Throwable unused) {
        }
    }

    private void o() {
        short sK;
        TextView textView;
        StringBuilder sb;
        if (this.L && (sK = this.b.b.k()) != 11) {
            try {
                switch (sK) {
                    case 2:
                        if (this.b.b.v() <= 0) {
                            if (this.b.b.g() != 0) {
                                this.o.setVisibility(0);
                                if (this.b.b.g() > 1) {
                                    textView = this.o;
                                    sb = new StringBuilder();
                                    sb.append(this.b.b.g());
                                    sb.append(" ");
                                    sb.append(OlaApplication.a(R.string.string_comment_plural));
                                } else {
                                    textView = this.o;
                                    sb = new StringBuilder();
                                    sb.append(this.b.b.g());
                                    sb.append(" ");
                                    sb.append(OlaApplication.a(R.string.string_comment));
                                }
                                textView.setText(sb.toString());
                            }
                            break;
                        }
                    case 1:
                        this.o.setVisibility(0);
                        this.o.setText(R.string.string_view_comment);
                        break;
                    default:
                        if (this.b.b.g() != 0) {
                            this.o.setVisibility(0);
                            if (this.b.b.g() > 1) {
                                textView = this.o;
                                sb = new StringBuilder();
                                sb.append(this.b.b.g());
                                sb.append(" ");
                                sb.append(OlaApplication.a(R.string.string_comment_plural));
                            } else {
                                textView = this.o;
                                sb = new StringBuilder();
                                sb.append(this.b.b.g());
                                sb.append(" ");
                                sb.append(OlaApplication.a(R.string.string_comment));
                            }
                            textView.setText(sb.toString());
                        }
                        break;
                }
                return;
            } catch (Throwable unused) {
                return;
            }
        }
        this.o.setVisibility(8);
    }

    /* JADX WARN: Unreachable blocks removed: 1, instructions: 1 */
    private void p() {
        try {
            try {
                if (this.K != null) {
                    this.I.removeAllViews();
                    this.K = null;
                }
            } catch (Throwable th) {
                th.printStackTrace();
            }
        } finally {
            this.I.setVisibility(8);
        }
    }

    private void q() {
        try {
        } catch (Throwable unused) {
            return;
        }
        if (this.L) {
            short sK = this.b.b.k();
            if (sK != 11) {
                switch (sK) {
                }
                return;
            }
            try {
                if (this.b.a.a) {
                    p();
                    return;
                }
            } catch (Throwable unused2) {
            }
            try {
                this.I.setVisibility(0);
                s();
                this.K.a(this, this.b);
                return;
            } catch (Throwable th) {
                th.printStackTrace();
                p();
                return;
            }
        }
        p();
    }

    private void r() {
        TextView textView;
        String strA;
        StringBuilder sb;
        String str;
        try {
            long jA = this.b.b.A();
            if (jA > 0) {
                String string = "" + chat.ola.vn.util.m.a(jA);
                if (jA >= 1000000000) {
                    sb = new StringBuilder();
                    sb.append(chat.ola.vn.util.m.a(jA / 1000000));
                    str = "M";
                } else {
                    if (jA >= 1000000) {
                        sb = new StringBuilder();
                        sb.append(chat.ola.vn.util.m.a(jA / 1000));
                        str = "K";
                    }
                    this.J.setVisibility(0);
                    textView = this.J;
                    strA = string + " " + OlaApplication.a(R.string.string_view_count);
                }
                sb.append(str);
                string = sb.toString();
                this.J.setVisibility(0);
                textView = this.J;
                strA = string + " " + OlaApplication.a(R.string.string_view_count);
            } else if (!this.b.b.c) {
                this.J.setVisibility(8);
                return;
            } else {
                this.J.setVisibility(0);
                textView = this.J;
                strA = OlaApplication.a(R.string.message_suggest_promote_products);
            }
            textView.setText(strA);
        } catch (Throwable unused) {
            this.J.setVisibility(8);
        }
    }

    private void s() {
        short sK = this.b.b.k();
        if (sK == 11) {
            if (this.K != null && !this.K.a(chat.ola.vn.entry.b.a.c.a())) {
                this.K = null;
            }
            if (this.K == null) {
                this.K = new chat.ola.vn.entry.b.a.c(d(), this.I, this.a);
                return;
            }
            return;
        }
        switch (sK) {
            case 1:
                if (this.K != null && !this.K.a(chat.ola.vn.entry.b.a.a.a())) {
                    this.K = null;
                }
                if (this.K == null) {
                    this.K = new chat.ola.vn.entry.b.a.a(d(), this.I, this.a);
                }
                break;
            case 2:
                if (this.K != null && !this.K.a(chat.ola.vn.entry.b.a.c.a())) {
                    this.K = null;
                }
                if (this.K == null) {
                    this.K = new chat.ola.vn.entry.b.a.c(d(), this.I, this.a);
                }
                break;
        }
    }

    private void t() {
        OlaCachedImageView olaCachedImageView;
        TextView textView;
        StringBuilder sb;
        int i;
        if (this.b.h() == 1 || this.b.h() == 2) {
            return;
        }
        this.C.setVisibility(0);
        this.u.setVisibility(0);
        int iF = this.b.b.f();
        this.r.setTextColor(chat.ola.vn.f.A);
        if (iF > 0) {
            this.q.setVisibility(0);
            if (iF > 1) {
                textView = this.q;
                sb = new StringBuilder();
                sb.append(chat.ola.vn.util.m.a(iF));
                sb.append(" ");
                i = R.string.string_like_plural;
            } else {
                textView = this.q;
                sb = new StringBuilder();
                sb.append(chat.ola.vn.util.m.a(iF));
                sb.append(" ");
                i = R.string.string_like_single;
            }
            sb.append(OlaApplication.a(i));
            textView.setText(sb.toString());
        } else {
            this.q.setVisibility(8);
        }
        if (this.b.b.i() == 1) {
            this.F.setImageResource(R.drawable.ic_like_selected);
            this.r.setTextColor(chat.ola.vn.f.H);
        } else {
            this.F.setImageResource(R.drawable.ic_like_gray);
        }
        if (this.b.b.E() != null) {
            try {
                switch (this.b.b.E().length) {
                    case 0:
                        break;
                    case 1:
                        if (this.P[0] != null) {
                            this.P[0].setVisibility(0);
                        }
                        w();
                        this.P[1].a(null, null);
                        this.P[1].setVisibility(8);
                        this.P[2].a(null, null);
                        olaCachedImageView = this.P[2];
                        break;
                    case 2:
                        this.P[0].setVisibility(0);
                        this.P[1].setVisibility(0);
                        w();
                        this.P[2].a(null, null);
                        olaCachedImageView = this.P[2];
                        break;
                    default:
                        this.P[0].setVisibility(0);
                        this.P[1].setVisibility(0);
                        this.P[2].setVisibility(0);
                        w();
                        return;
                }
                olaCachedImageView.setVisibility(8);
                return;
            } catch (Throwable unused) {
                return;
            }
        }
        u();
    }

    private void u() {
        try {
            this.P[0].a(null, null);
            this.P[0].setVisibility(8);
            this.P[1].a(null, null);
            this.P[1].setVisibility(8);
            this.P[2].a(null, null);
            this.P[2].setVisibility(8);
            if (this.b.b.f() > 0) {
                this.q.setVisibility(0);
            } else {
                this.q.setVisibility(8);
            }
        } catch (Throwable unused) {
        }
    }

    private void v() {
        try {
            if (this.b.h() == 1 || this.b.h() == 2) {
                return;
            }
            int iD = this.b.b.D();
            this.s.setTextColor(chat.ola.vn.f.A);
            if (iD <= 0) {
                this.G.setImageResource(R.drawable.ic_dislike_gray);
                this.s.setText(OlaApplication.a(R.string.string_dislike));
                return;
            }
            this.s.setText(OlaApplication.a(R.string.string_dislike) + " (" + chat.ola.vn.util.m.a(iD) + ")");
            if (this.b.b.i() != 2) {
                this.G.setImageResource(R.drawable.ic_dislike_gray);
            } else {
                this.G.setImageResource(R.drawable.ic_dislike_black);
                this.s.setTextColor(chat.ola.vn.f.y);
            }
        } catch (Throwable unused) {
        }
    }

    private void w() {
        try {
            if (this.P != null) {
                for (int i = 0; i < this.P.length && i < this.b.b.E().length; i++) {
                    if (this.P[i] != null) {
                        this.P[i].setVisibility(0);
                        chat.ola.vn.c.t.a().f(this.b.b.E()[i], this.P[i]);
                    }
                }
            }
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    private void x() {
        try {
            if (this.z == null || this.z.a(this.b.b.a())) {
                return;
            }
            String strA = this.b.b.a();
            if (strA.startsWith("#")) {
                chat.ola.vn.c.t.a().j(chat.ola.vn.util.m.k(strA), this.z);
            } else {
                chat.ola.vn.c.t.a().g(strA, this.z);
            }
        } catch (Throwable unused) {
        }
    }

    private void y() {
        if (this.A != null) {
            short sO = this.b.b.o();
            if (sO <= 0) {
                this.A.a(null, null);
                this.A.setVisibility(8);
                return;
            }
            if (this.A.a(((int) sO) + "")) {
                return;
            }
            this.A.setVisibility(0);
            this.A.a(chat.ola.vn.j.a().a(sO), ((int) sO) + "");
        }
    }

    @Override // chat.ola.vn.entry.b.j
    public void a() {
        TextView textView;
        String str;
        try {
            if (this.b == null) {
                return;
            }
            h();
            if (this.b.b == null) {
                return;
            }
            if (chat.ola.vn.util.m.a(this.b.b.q())) {
                textView = this.n;
                str = this.b.h;
            } else {
                textView = this.n;
                str = this.b.h + " - " + this.b.b.q();
            }
            textView.setText(str);
            int i = 0;
            this.n.setVisibility(0);
            o();
            x();
            n();
            f();
            i();
            try {
                t();
                v();
                l();
            } catch (Throwable th) {
                th.printStackTrace();
            }
            try {
                if (this.b.h() == 1 || this.b.h() == 2 || this.b.b.k() == 11) {
                    i = 8;
                    this.t.setVisibility(8);
                    this.u.setVisibility(8);
                } else {
                    this.t.setVisibility(0);
                    this.u.setVisibility(0);
                }
                this.C.setVisibility(i);
            } catch (Throwable unused) {
            }
            m();
            q();
            r();
        } catch (Throwable th2) {
            th2.printStackTrace();
        }
    }

    @Override // chat.ola.vn.entry.b.j
    public void a(int i) {
        if (this.d != null) {
            this.d.setBackgroundResource(i);
        }
    }

    @Override // chat.ola.vn.entry.b.j
    public void a(int i, int i2, int i3, int i4) {
        this.c.setPadding(i, i2, i3, i4);
    }

    @Override // chat.ola.vn.entry.b.j
    public void a(View view) {
        super.a(view);
    }

    public void a(View view, String[] strArr, String str) {
        try {
            if (this.V == null) {
                this.V = ((ViewStub) view.findViewById(R.id.meSuggestedPhotoViewStub)).inflate();
            }
            this.v = view.findViewById(R.id.viewAllSuggestedPhotoTextView);
            this.w = (OlaGalleryView) view.findViewById(R.id.suggestedPhotoList);
            this.y = (TextView) view.findViewById(R.id.suggestedPhotoOwnerId);
            this.y.setText(view.getContext().getString(R.string.string_more_photos_of, str));
            this.x = new al(view.getContext());
            this.w.setAdapter(this.x);
            this.x.a(strArr);
            this.V.setVisibility(0);
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.p.a
    public void a(OlaCheckInItemEntity olaCheckInItemEntity) {
    }

    @Override // chat.ola.vn.p.a
    public void a(OlaVenueEntity olaVenueEntity) {
    }

    @Override // chat.ola.vn.p.a
    public void a(chat.ola.vn.entity.o oVar) {
        try {
            if (chat.ola.vn.util.m.b(this.b.b.z(), oVar.a())) {
                this.b.b.e = oVar;
                i();
            }
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    @Override // chat.ola.vn.p.a
    public void a(chat.ola.vn.entity.y yVar) {
        try {
            if (chat.ola.vn.util.m.b(this.b.b.e.d().b(), yVar.a())) {
                this.Z = yVar;
                j();
            }
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.p.a
    public void a(List<chat.ola.vn.entity.g> list, long j) {
    }

    @Override // chat.ola.vn.p.a
    public void a(short s, String str) {
    }

    /* JADX WARN: Unreachable blocks removed: 1, instructions: 1 */
    @Override // chat.ola.vn.entry.b.j
    public void a(boolean z) {
        TextView textView;
        int i;
        super.a(z);
        this.L = z;
        if (z) {
            textView = this.o;
            i = 0;
        } else {
            textView = this.o;
            i = 8;
        }
        textView.setVisibility(i);
    }

    @Override // chat.ola.vn.entry.b.j
    public void b() {
        try {
            if (!chat.ola.vn.util.m.b(chat.ola.vn.h.a(), this.b.c()) && chat.ola.vn.h.t.e(this.b.c(), (short) 0) == null) {
                this.aa.setVisibility(0);
            } else {
                ImageView imageView = this.aa;
                imageView.setVisibility(8);
            }
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    @Override // chat.ola.vn.p.a
    public void b(OlaVenueEntity olaVenueEntity) {
    }

    @Override // chat.ola.vn.p.a
    public void b(List<OlaVenueEntity> list, int i) {
    }

    @Override // chat.ola.vn.p.a
    public void c(List<OlaCheckInActionEntity> list) {
    }

    @Override // chat.ola.vn.p.a
    public void c(List<OlaCheckInItemEntity> list, int i) {
    }

    @Override // chat.ola.vn.entry.b.j
    public Context d() {
        return this.c.getContext();
    }

    public void e() {
        try {
            if (this.V != null) {
                this.V.setVisibility(8);
            }
            this.v = null;
            this.w = null;
            this.x = null;
        } catch (Throwable unused) {
        }
    }

    public void f() {
        OlaCachedImageView olaCachedImageView;
        try {
            try {
                if (this.b == null) {
                    return;
                }
                if (this.a != null) {
                    View.OnClickListener onClickListener = new View.OnClickListener() { // from class: chat.ola.vn.entry.b.ab.5
                        @Override // android.view.View.OnClickListener
                        public void onClick(View view) {
                            view.setTag(ab.this.b);
                            ab.this.a.onClick(view);
                        }
                    };
                    for (int i = 0; i < this.O.length; i++) {
                        this.O[i].setOnClickListener(onClickListener);
                    }
                }
                if (this.e != null) {
                    View.OnLongClickListener onLongClickListener = new View.OnLongClickListener() { // from class: chat.ola.vn.entry.b.ab.6
                        @Override // android.view.View.OnLongClickListener
                        public boolean onLongClick(View view) {
                            view.setTag(ab.this.b);
                            return ab.this.e.onLongClick(view);
                        }
                    };
                    for (int i2 = 0; i2 < this.O.length; i2++) {
                        this.O[i2].setOnLongClickListener(onLongClickListener);
                    }
                }
                for (int i3 = 0; i3 < this.O.length; i3++) {
                    this.O[i3].setVisibility(8);
                }
                this.N.setVisibility(8);
                this.M.setVisibility(8);
                int size = this.b.i.size();
                if (size > 0) {
                    if (size > 5) {
                        if (this.N != null) {
                            this.N.setVisibility(0);
                        }
                        this.M.setVisibility(0);
                        TextView textView = this.M;
                        StringBuilder sb = new StringBuilder();
                        sb.append("+");
                        sb.append(size - 5);
                        textView.setText(sb.toString());
                    } else if (size != 5) {
                        this.M.setVisibility(8);
                    } else if (this.N != null) {
                        this.N.setVisibility(0);
                    }
                    for (int i4 = 0; i4 < this.O.length && i4 < size; i4++) {
                        this.O[i4].setVisibility(0);
                        chat.ola.vn.c.t.a().b(this.b.i.get(i4), this.O[i4], this.g);
                        if (size != 5) {
                            switch (size) {
                                case 1:
                                    break;
                                case 2:
                                    if (i4 == 0) {
                                        ((OlaRatioImageView) this.O[0]).setRatio(0.5625d);
                                    }
                                    if (i4 == 1) {
                                        ((OlaRatioImageView) this.O[1]).setRatio(0.5625d);
                                    } else {
                                        continue;
                                    }
                                    break;
                                case 3:
                                    if (i4 == 0) {
                                        ((OlaRatioImageView) this.O[0]).setRatio(1.0d);
                                    }
                                    if (i4 == 1) {
                                        ((OlaRatioImageView) this.O[1]).setRatio(1.0d);
                                    }
                                    if (i4 == 2) {
                                        ((OlaRatioImageView) this.O[2]).setRatio(1.7777777777777777d);
                                    } else {
                                        continue;
                                    }
                                    break;
                                default:
                                    if (i4 == 0) {
                                        ((OlaRatioImageView) this.O[0]).setRatio(1.0d);
                                    }
                                    if (i4 == 1) {
                                        ((OlaRatioImageView) this.O[1]).setRatio(1.0d);
                                    }
                                    if (i4 == 2) {
                                        olaCachedImageView = this.O[2];
                                    }
                                    break;
                            }
                            ((OlaRatioImageView) olaCachedImageView).setRatio(1.0d);
                        } else {
                            if (i4 == 0) {
                                ((OlaRatioImageView) this.O[0]).setRatio(1.0d);
                            }
                            if (i4 == 1) {
                                ((OlaRatioImageView) this.O[1]).setRatio(1.0d);
                            }
                            if (i4 == 2) {
                                olaCachedImageView = this.O[2];
                                ((OlaRatioImageView) olaCachedImageView).setRatio(1.0d);
                            }
                        }
                    }
                    return;
                }
                return;
            } catch (Throwable unused) {
                if (this.O != null) {
                    if (this.N != null) {
                        this.N.setVisibility(8);
                    }
                    for (int i5 = 0; i5 < this.O.length; i5++) {
                        this.O[i5].setVisibility(8);
                    }
                    return;
                }
                return;
            }
        } catch (Throwable th) {
            th.printStackTrace();
        }
        th.printStackTrace();
    }

    @Override // chat.ola.vn.p.a
    public void f(String str) {
    }

    public void g() {
        try {
            if (this.b.b.e() == this.K.b().b.e()) {
                try {
                    try {
                        this.I.removeAllViews();
                    } catch (Throwable th) {
                        this.I.setVisibility(8);
                        throw th;
                    }
                } catch (Throwable th2) {
                    th2.printStackTrace();
                }
                this.I.setVisibility(8);
            }
        } catch (Throwable unused) {
        }
    }
}
