package chat.ola.vn.b;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.ProgressBar;
import android.widget.TextView;
import chat.ola.vn.R;
import chat.ola.vn.activity.BuyVipActivity;
import chat.ola.vn.activity.OlaPhoneVerificationActivity;
import chat.ola.vn.view.OlaCachedImageView;
import com.facebook.appevents.AppEventsConstants;
import com.google.android.gms.ads.AdRequest;
import com.google.android.gms.ads.AdView;

/* JADX INFO: loaded from: classes.dex */
public class y extends j<chat.ola.vn.entity.s> {
    private LayoutInflater a;

    private class a {
        private OlaCachedImageView b;
        private ProgressBar c;
        private TextView d;
        private TextView e;
        private TextView f;
        private TextView g;
        private View h;
        private View i;
        private View j;
        private Button k;
        private TextView l;
        private TextView m;
        private chat.ola.vn.entity.s n;

        a(View view) {
            try {
                this.f = (TextView) view.findViewById(R.id.labelTextView);
            } catch (Throwable unused) {
            }
            try {
                this.d = (TextView) view.findViewById(R.id.roomTitleTextView);
                this.e = (TextView) view.findViewById(R.id.roomSubtitleTextView);
                this.g = (TextView) view.findViewById(R.id.roomSizeTextView);
                this.b = (OlaCachedImageView) view.findViewById(R.id.roomIconImageView);
                this.c = (ProgressBar) view.findViewById(R.id.roomProgressBar);
                this.h = view.findViewById(R.id.listViewBottomDividerView);
                this.i = view.findViewById(R.id.roomRowViewLayout);
            } catch (Throwable unused2) {
            }
            try {
                this.j = view.findViewById(R.id.warningLayout);
                this.k = (Button) view.findViewById(R.id.warningButton);
                this.l = (TextView) view.findViewById(R.id.warningLine1TextView);
                this.m = (TextView) view.findViewById(R.id.warningLine2TextView);
            } catch (Throwable unused3) {
            }
        }

        public void a(chat.ola.vn.entity.s sVar, chat.ola.vn.entity.s sVar2, chat.ola.vn.entity.s sVar3) {
            TextView textView;
            StringBuilder sb;
            String string;
            View view;
            int i;
            this.n = sVar;
            if (this.n.h() == 2) {
                this.f.setText(this.n.d());
                return;
            }
            try {
                if (this.i != null) {
                    if (this.n.c() == chat.ola.vn.h.x.k()) {
                        view = this.i;
                        i = chat.ola.vn.f.I;
                    } else {
                        view = this.i;
                        i = chat.ola.vn.f.d;
                    }
                    view.setBackgroundColor(i);
                }
            } catch (Throwable unused) {
            }
            if (sVar3 == null || sVar3.h() == 2) {
                this.h.setVisibility(4);
            } else {
                this.h.setVisibility(0);
            }
            if (this.n.h() == 1) {
                this.c.setVisibility(8);
                this.b.setBackgroundResource(0);
                this.b.setImageResource(R.drawable.ic_tab_friend_location);
                this.d.setText(R.string.string_around_you);
                this.e.setText(R.string.string_around_you_description);
            } else {
                if (this.n.h() == 6) {
                    try {
                        try {
                            if (this.j != null) {
                                this.j.setVisibility(8);
                            }
                            if (chat.ola.vn.h.O.u == 0) {
                                this.j.setVisibility(0);
                                this.j.setTag(AppEventsConstants.EVENT_PARAM_VALUE_NO);
                                this.k.setText(R.string.string_buy_vip);
                                this.l.setText(R.string.message_register_vip_account);
                                this.m.setText(R.string.message_register_vip_explaination);
                            } else if (chat.ola.vn.h.O.q > 0 && chat.ola.vn.h.O.q < 3) {
                                this.j.setVisibility(0);
                                this.j.setTag("1");
                                this.k.setText(R.string.string_extend_vip);
                                this.l.setText(R.string.message_extend_vip_account);
                                this.m.setText(R.string.message_extend_vip_explaination);
                            } else if (!chat.ola.vn.h.O.x) {
                                this.j.setVisibility(0);
                                this.j.setTag("2");
                                this.k.setText(R.string.string_verify);
                                this.l.setText(R.string.message_phone_number_not_validate);
                                this.m.setText(R.string.message_warning_need_verify_phone_to_protect_your_account);
                            }
                            this.j.setOnClickListener(new View.OnClickListener() { // from class: chat.ola.vn.b.y.a.1
                                @Override // android.view.View.OnClickListener
                                public void onClick(View view2) {
                                    try {
                                        String str = (String) view2.getTag();
                                        if (chat.ola.vn.util.m.c(str, AppEventsConstants.EVENT_PARAM_VALUE_NO)) {
                                            BuyVipActivity.a(chat.ola.vn.c.c());
                                        } else if (chat.ola.vn.util.m.c(str, "1")) {
                                            BuyVipActivity.b(chat.ola.vn.c.c());
                                        } else if (chat.ola.vn.util.m.c(str, "2")) {
                                            OlaPhoneVerificationActivity.a(chat.ola.vn.c.c());
                                        }
                                    } catch (Throwable unused2) {
                                    }
                                }
                            });
                            return;
                        } catch (Throwable unused2) {
                            return;
                        }
                    } catch (Throwable unused3) {
                        this.j.setVisibility(8);
                        return;
                    }
                }
                this.d.setText(this.n.d());
                this.e.setText(this.n.f());
                if (this.n.h() != 5) {
                    if (this.n.h() == 3) {
                        this.b.setBackgroundResource(0);
                        this.g.setVisibility(8);
                    } else {
                        this.b.setBackgroundResource(R.drawable.bg_shadown_border);
                        this.g.setVisibility(0);
                        if (this.n.a() >= 200) {
                            this.g.setTextColor(chat.ola.vn.f.L);
                            textView = this.g;
                            string = "200+";
                        } else {
                            if (this.n.a() >= 100) {
                                this.g.setTextColor(chat.ola.vn.f.z);
                                textView = this.g;
                                sb = new StringBuilder();
                            } else {
                                this.g.setTextColor(chat.ola.vn.f.A);
                                textView = this.g;
                                sb = new StringBuilder();
                            }
                            sb.append("");
                            sb.append(this.n.a());
                            string = sb.toString();
                        }
                        textView.setText(string);
                    }
                    chat.ola.vn.c.t.a().a(this.n.g(), this.b, this.c);
                    return;
                }
                this.c.setVisibility(8);
                this.b.setBackgroundResource(0);
                this.b.setImageResource(R.drawable.ic_action_auto_join_room);
            }
            this.g.setVisibility(8);
        }
    }

    public y(Context context) {
        super(context);
        this.a = (LayoutInflater) context.getSystemService("layout_inflater");
    }

    @Override // chat.ola.vn.b.j
    public View a(int i, View view, ViewGroup viewGroup) {
        a aVar;
        chat.ola.vn.entity.s item;
        chat.ola.vn.entity.s item2;
        View viewInflate;
        try {
            chat.ola.vn.entity.s item3 = getItem(i);
            if (view == null) {
                if (getItemViewType(i) == 1) {
                    viewInflate = this.a.inflate(R.layout.list_view_section_item_layout, (ViewGroup) null);
                } else if (getItemViewType(i) == 2) {
                    viewInflate = this.a.inflate(R.layout.conversation_admob_native_item_layout, (ViewGroup) null);
                    try {
                        chat.ola.vn.util.a.a(viewInflate, this.a);
                        item3.b = 0L;
                    } catch (Throwable unused) {
                        view = viewInflate;
                    }
                } else {
                    viewInflate = getItemViewType(i) == 3 ? this.a.inflate(R.layout.room_warning_item_layout, (ViewGroup) null) : this.a.inflate(R.layout.room_item_layout, (ViewGroup) null);
                }
                view = viewInflate;
                aVar = new a(view);
            } else {
                aVar = view.getTag() == null ? new a(view) : (a) view.getTag();
            }
            if (getItemViewType(i) == 2 && view.getTag() != null && System.currentTimeMillis() - item3.b >= 180000) {
                try {
                    item3.b = System.currentTimeMillis();
                    ((AdView) view.getTag()).loadAd(new AdRequest.Builder().build());
                } catch (Throwable unused2) {
                }
            }
            view.setTag(aVar);
            try {
                item = getItem(i - 1);
            } catch (Throwable unused3) {
                item = null;
            }
            try {
                item2 = getItem(i + 1);
            } catch (Throwable unused4) {
                item2 = null;
            }
            aVar.a(item3, item, item2);
        } catch (Throwable unused5) {
        }
        return view == null ? viewGroup : view;
    }

    @Override // android.widget.Adapter
    /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
    public chat.ola.vn.entity.s getItem(int i) {
        try {
            return chat.ola.vn.h.x.b(i);
        } catch (Throwable unused) {
            return null;
        }
    }

    @Override // chat.ola.vn.b.j, android.widget.Adapter
    public int getCount() {
        try {
            return chat.ola.vn.h.x.f();
        } catch (Throwable unused) {
            return 0;
        }
    }

    @Override // android.widget.BaseAdapter, android.widget.Adapter
    public int getItemViewType(int i) {
        try {
            chat.ola.vn.entity.s item = getItem(i);
            if (item.h() == 2) {
                return 1;
            }
            if (item.h() == 4) {
                return 2;
            }
            return item.h() == 6 ? 3 : 0;
        } catch (Throwable unused) {
            return 0;
        }
    }

    @Override // android.widget.BaseAdapter, android.widget.Adapter
    public int getViewTypeCount() {
        return 4;
    }
}
