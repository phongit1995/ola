package chat.ola.vn.entry.b;

import android.text.SpannableStringBuilder;
import android.text.method.LinkMovementMethod;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;
import chat.ola.vn.R;
import chat.ola.vn.view.OlaCachedImageView;
import chat.ola.vn.view.OlaRatioImageView;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public class h {
    public View a;
    public View b;
    private int c;
    private int d;
    private View e;
    private OlaRatioImageView f;
    private TextView g;
    private TextView h;
    private TextView i;
    private TextView j;
    private chat.ola.vn.entity.e k;
    private View.OnClickListener l;
    private View.OnLongClickListener m;
    private ImageView n;
    private ImageView o;
    private View p;
    private View q;
    private ImageView r;
    private TextView s;
    private View t;
    private TextView u;
    private TextView v;
    private ImageView w;
    private TextView x;
    private View y;
    private View z;

    private h() {
    }

    public h(View view, double d) {
        this.e = view;
        this.b = this.e.findViewById(R.id.linearItemWrap);
        this.f = (OlaRatioImageView) this.e.findViewById(R.id.imgVideoThumbnail);
        this.f.setBaseOrientation(OlaRatioImageView.BASE_SIDE.BASE_WIDTH);
        this.f.setRatio(d);
        this.a = this.e.findViewById(R.id.linearHighlightInfoSpan);
        this.o = (ImageView) this.e.findViewById(R.id.imgVideoTypeIcon);
        this.n = (ImageView) this.e.findViewById(R.id.imgVideoPlayType);
        this.g = (TextView) this.e.findViewById(R.id.txtVideoTitle);
        this.h = (TextView) this.e.findViewById(R.id.txtVideoViewCount);
        this.i = (TextView) this.e.findViewById(R.id.txtVideoCreatedDate);
        this.j = (TextView) this.e.findViewById(R.id.txtVideoDuration);
        this.q = this.e.findViewById(R.id.btnMallItemDetailLike);
        this.r = (ImageView) this.e.findViewById(R.id.imgMallItemDetailLikeIcon);
        this.s = (TextView) this.e.findViewById(R.id.txtMallItemDetailLikeNumber);
        this.t = this.e.findViewById(R.id.btnMallItemDetailComment);
        this.u = (TextView) this.e.findViewById(R.id.txtMallItemDetailCommentNumber);
        this.y = this.e.findViewById(R.id.mallInfoSpan);
        this.x = (TextView) this.e.findViewById(R.id.txtMallItemTagList);
        this.w = (ImageView) this.e.findViewById(R.id.btnMallInfo);
        this.v = (TextView) this.e.findViewById(R.id.txtVideoDescription);
        this.z = this.e.findViewById(R.id.linearMallItemActionSpan);
        this.p = this.e.findViewById(R.id.btnMallItemDetailShare);
        view.setTag(this);
    }

    public static int a() {
        return 4;
    }

    public static int a(int i) {
        if (i == -6 || i == -2 || i == 0) {
            return 3;
        }
        int i2 = 2;
        if (i != 2) {
            i2 = 0;
            switch (i) {
                case 100:
                case 102:
                    break;
                case 101:
                    return 1;
                default:
                    return 0;
            }
        }
        return i2;
    }

    public static View a(LayoutInflater layoutInflater, ViewGroup viewGroup, int i) {
        View viewInflate;
        h hVar;
        if (i == -6 || i == -2 || i == 0) {
            viewInflate = layoutInflater.inflate(R.layout.mall_time_tab_item_layout, viewGroup, false);
            hVar = new h();
            hVar.e = viewInflate;
            viewInflate.setTag(hVar);
        } else if (i != 2) {
            switch (i) {
                case 100:
                case 101:
                case 102:
                    viewInflate = layoutInflater.inflate(R.layout.mall_video_item_layout, viewGroup, false);
                    hVar = new h(viewInflate, 1.7777777777777777d);
                    break;
                default:
                    viewInflate = layoutInflater.inflate(R.layout.mall_video_item_layout, viewGroup, false);
                    hVar = new h(viewInflate, 1.7777777777777777d);
                    break;
            }
        } else {
            viewInflate = layoutInflater.inflate(R.layout.mall_category_item_layout, viewGroup, false);
            hVar = new h(viewInflate, 1.0d);
        }
        int dimensionPixelSize = viewGroup.getResources().getDimensionPixelSize(R.dimen.mall_entry_thumb_width);
        hVar.c = dimensionPixelSize;
        hVar.d = dimensionPixelSize;
        return viewInflate;
    }

    public static View a(LayoutInflater layoutInflater, ViewGroup viewGroup, boolean z) {
        View viewInflate = layoutInflater.inflate(R.layout.mall_highlight_detail_span, viewGroup, false);
        h hVar = new h(viewInflate, 1.7777777777777777d);
        hVar.c = Math.min(chat.ola.vn.e.c, chat.ola.vn.e.d);
        hVar.d = Math.min(chat.ola.vn.e.c, chat.ola.vn.e.d);
        return viewInflate;
    }

    private void a(final chat.ola.vn.entity.e eVar, ViewGroup viewGroup) {
        try {
            final View viewFindViewById = viewGroup.findViewById(R.id.linearMallItemTabSpan);
            List<chat.ola.vn.entity.e> listM = eVar.m();
            eVar.l();
            if (listM != null) {
                LayoutInflater layoutInflaterFrom = LayoutInflater.from(this.e.getContext());
                while (listM.size() > viewGroup.getChildCount()) {
                    viewGroup.addView(layoutInflaterFrom.inflate(R.layout.mall_tab_button, viewGroup, false), new LinearLayout.LayoutParams(0, -1, 1.0f));
                }
                while (listM.size() < viewGroup.getChildCount()) {
                    viewGroup.removeViewAt(viewGroup.getChildCount() - 1);
                }
                chat.ola.vn.entity.e eVarL = eVar.l();
                int size = listM.size();
                chat.ola.vn.entity.e eVar2 = eVarL;
                for (int i = 0; i < size; i++) {
                    final chat.ola.vn.entity.e eVar3 = listM.get(i);
                    TextView textView = (TextView) viewGroup.getChildAt(i);
                    textView.setText(eVar3.z());
                    textView.setTag(eVar3);
                    textView.setOnClickListener(new View.OnClickListener() { // from class: chat.ola.vn.entry.b.h.3
                        @Override // android.view.View.OnClickListener
                        public void onClick(View view) {
                            eVar.c(eVar3);
                            h.this.l.onClick(viewFindViewById);
                        }
                    });
                    if (i == 0) {
                        textView.setBackgroundResource(R.drawable.btn_left_mall_tab_selector);
                    } else if (i == size - 1) {
                        textView.setBackgroundResource(R.drawable.btn_right_mall_tab_selector);
                    } else {
                        textView.setBackgroundResource(R.drawable.btn_mall_tab_selector);
                    }
                    if (eVar2 == null) {
                        eVar.c(eVar3);
                        textView.setSelected(true);
                        eVar2 = eVar3;
                    } else if (eVar2 == eVar3) {
                        textView.setSelected(true);
                    } else {
                        textView.setSelected(false);
                    }
                }
            }
        } catch (Throwable unused) {
        }
    }

    private void a(OlaCachedImageView olaCachedImageView, String str, boolean z) {
        if (str == null) {
            olaCachedImageView.setVisibility(8);
        } else {
            olaCachedImageView.setVisibility(0);
            chat.ola.vn.c.t.a().a(str, olaCachedImageView, z);
        }
    }

    private int b(int i) {
        return i <= 50 ? this.k.a() ? R.drawable.ic_like_white : R.drawable.ic_button_stroke_like : (i <= 50 || i > 100) ? (i <= 100 || i > 200) ? i > 200 ? R.drawable.ic_award_star_level3 : R.drawable.ic_button_stroke_like : R.drawable.ic_award_star_level2 : R.drawable.ic_award_star_level1;
    }

    public static View b(LayoutInflater layoutInflater, ViewGroup viewGroup, boolean z) {
        View viewInflate = layoutInflater.inflate(R.layout.mall_highlight_detail_header_span, viewGroup, false);
        h hVar = new h(viewInflate, 1.7777777777777777d);
        hVar.c = Math.min(chat.ola.vn.e.c, chat.ola.vn.e.d);
        hVar.d = Math.min(chat.ola.vn.e.c, chat.ola.vn.e.d);
        return viewInflate;
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void b() {
        final String strQ = this.k.Q();
        final List<chat.ola.vn.entity.e> listG = this.k.g();
        if (chat.ola.vn.util.m.a(strQ)) {
            this.w.setOnClickListener(null);
            this.w.setVisibility(8);
            this.y.setVisibility(8);
        } else {
            if (chat.ola.vn.util.m.a(strQ)) {
                this.v.setVisibility(8);
            } else {
                this.v.setVisibility(0);
                this.v.setText(strQ);
            }
            this.w.setOnClickListener(new View.OnClickListener() { // from class: chat.ola.vn.entry.b.h.1
                @Override // android.view.View.OnClickListener
                public void onClick(View view) {
                    ImageView imageView;
                    int i;
                    if (!view.isSelected()) {
                        if (!chat.ola.vn.util.m.a(strQ) || listG != null) {
                            h.this.y.setVisibility(0);
                            h.this.b();
                            imageView = h.this.w;
                            i = R.drawable.ic_expander_hide_span;
                        }
                        view.setSelected(!view.isSelected());
                    }
                    h.this.y.setVisibility(8);
                    imageView = h.this.w;
                    i = R.drawable.ic_expander_show_span;
                    imageView.setImageResource(i);
                    view.setSelected(!view.isSelected());
                }
            });
        }
    }

    private void c() {
        try {
            if (this.x != null) {
                List<chat.ola.vn.entity.e> listG = this.k.g();
                if (listG == null) {
                    this.x.setVisibility(8);
                    return;
                }
                SpannableStringBuilder spannableStringBuilder = new SpannableStringBuilder(" ");
                int size = listG.size();
                for (int i = 0; i < size; i++) {
                    final chat.ola.vn.entity.e eVar = listG.get(i);
                    String strZ = eVar.z();
                    spannableStringBuilder.append((CharSequence) strZ);
                    spannableStringBuilder.append((CharSequence) " ");
                    spannableStringBuilder.setSpan(new com.mg.ola.common.d.a.a(this.x.getResources().getColor(R.color.color_action_tab), true) { // from class: chat.ola.vn.entry.b.h.2
                        @Override // com.mg.ola.common.d.a.a, android.text.style.ClickableSpan
                        public void onClick(View view) {
                            chat.ola.vn.m.g.b(h.this.x.getContext(), eVar.t());
                        }
                    }, (spannableStringBuilder.length() - strZ.length()) - 1, spannableStringBuilder.length() - 1, 33);
                }
                this.x.setMovementMethod(LinkMovementMethod.getInstance());
                this.x.setText(spannableStringBuilder);
                this.x.setVisibility(0);
            }
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    private void d() {
        TextView textView;
        int i;
        if (this.r == null || this.s == null || this.q == null) {
            return;
        }
        this.q.setTag(this.k);
        this.q.setOnClickListener(this.l);
        int iB = this.k.b();
        this.r.setVisibility(0);
        this.r.setImageResource(b(iB));
        if (iB <= 0) {
            this.q.setSelected(false);
            this.s.setVisibility(8);
            return;
        }
        this.s.setVisibility(0);
        this.s.setText(chat.ola.vn.util.m.a(iB));
        if (this.k.a()) {
            this.q.setSelected(true);
            textView = this.s;
            i = chat.ola.vn.f.g;
        } else {
            this.q.setSelected(false);
            textView = this.s;
            i = chat.ola.vn.f.z;
        }
        textView.setTextColor(i);
    }

    public void a(View.OnClickListener onClickListener) {
        this.l = onClickListener;
    }

    public void a(View.OnLongClickListener onLongClickListener) {
        this.m = onLongClickListener;
    }

    /* JADX WARN: Failed to find 'out' block for switch in B:58:0x0171. Please report as an issue. */
    /* JADX WARN: Failed to find 'out' block for switch in B:61:0x017f. Please report as an issue. */
    public void a(chat.ola.vn.entity.e eVar) {
        ImageView imageView;
        ImageView imageView2;
        ImageView imageView3;
        ImageView imageView4;
        if (this.z != null) {
            this.z.setVisibility(0);
        }
        int iE = eVar.E();
        if (iE == -6 || iE == -2 || iE == 0) {
            a(eVar, (ViewGroup) this.e);
            return;
        }
        if (iE == 102 && this.z != null) {
            this.z.setVisibility(4);
        }
        this.k = eVar;
        try {
            this.g.setText(this.k.z());
            if (this.y != null) {
                this.y.setVisibility(8);
                this.w.setImageResource(R.drawable.ic_expander_show_span);
                b();
            }
            c();
            if (this.h != null) {
                this.h.setText(chat.ola.vn.util.m.a(this.k.D()));
            }
            if (this.i != null) {
                this.i.setText(com.mg.ola.common.d.i.a(this.k.F(), chat.ola.vn.b.d().c(), chat.ola.vn.b.d().a(), chat.ola.vn.b.d().b()));
            }
            if (this.j != null) {
                if (iE == -4 || iE == 101) {
                    this.j.setText(this.k.i() + " ");
                    this.j.append(this.j.getResources().getString(R.string.string_chap));
                } else {
                    int iC = this.k.C();
                    if (iC == 0) {
                        this.j.setVisibility(4);
                    } else {
                        this.j.setText(com.mg.ola.common.d.i.a(iC, ":", ":"));
                        this.j.setVisibility(0);
                    }
                }
            }
            if (this.u != null) {
                if (this.k.c() == 0) {
                    this.u.setVisibility(8);
                } else {
                    this.u.setText(chat.ola.vn.util.m.a(this.k.c()));
                    this.u.setVisibility(0);
                }
            }
            if (this.t != null) {
                this.t.setTag(this.k);
                this.t.setOnClickListener(this.l);
            }
            d();
            if (this.f != null) {
                a(this.f, this.k.a(this.c, this.d), this.c != chat.ola.vn.e.c);
                this.f.setTag(eVar);
                this.f.setOnClickListener(this.l);
                this.f.setOnLongClickListener(this.m);
            }
            if (this.p != null) {
                this.p.setTag(eVar);
                this.p.setOnClickListener(this.l);
                this.p.setVisibility(0);
            }
            if (this.n != null) {
                switch (eVar.G()) {
                    case 1:
                        this.n.setImageResource(R.drawable.ic_play_media);
                        imageView3 = this.n;
                        imageView3.setVisibility(0);
                        break;
                    case 2:
                        switch (chat.ola.vn.util.o.g(eVar.A())) {
                            case 2:
                            case 3:
                                this.n.setImageResource(R.drawable.ic_play_media);
                                imageView3 = this.n;
                                imageView3.setVisibility(0);
                                break;
                            default:
                                imageView4 = this.n;
                                imageView4.setVisibility(8);
                                break;
                        }
                        break;
                    default:
                        imageView4 = this.n;
                        imageView4.setVisibility(8);
                        break;
                }
            }
            if (this.o != null) {
                if (iE == 101 || iE == -4) {
                    this.o.setImageResource(R.drawable.ic_item_type_playlist);
                    imageView = this.o;
                } else {
                    switch (eVar.G()) {
                        case 1:
                            this.o.setImageResource(R.drawable.ic_item_type_video);
                            imageView = this.o;
                            break;
                        case 2:
                            switch (chat.ola.vn.util.o.g(eVar.A())) {
                                case 1:
                                    this.o.setImageResource(R.drawable.ic_item_type_photo);
                                    imageView = this.o;
                                    break;
                                case 2:
                                    this.o.setImageResource(R.drawable.ic_item_type_video);
                                    imageView = this.o;
                                    break;
                                case 3:
                                    this.o.setImageResource(R.drawable.ic_item_type_sound);
                                    imageView = this.o;
                                    break;
                                default:
                                    imageView2 = this.o;
                                    imageView2.setVisibility(8);
                                    return;
                            }
                            break;
                        case 3:
                            this.o.setImageResource(R.drawable.ic_item_type_photo);
                            imageView = this.o;
                            break;
                        case 4:
                            this.o.setImageResource(R.drawable.ic_item_type_android);
                            imageView = this.o;
                            break;
                        case 5:
                            this.o.setImageResource(R.drawable.ic_item_type_apple);
                            imageView = this.o;
                            break;
                        default:
                            imageView2 = this.o;
                            imageView2.setVisibility(8);
                            return;
                    }
                }
                imageView.setVisibility(0);
            }
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }
}
