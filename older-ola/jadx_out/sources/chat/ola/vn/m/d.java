package chat.ola.vn.m;

import android.annotation.SuppressLint;
import android.content.DialogInterface;
import android.content.Intent;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.ListAdapter;
import android.widget.ListView;
import android.widget.TextView;
import chat.ola.vn.R;
import chat.ola.vn.activity.OlaBottomTabActivity;
import chat.ola.vn.activity.OlaReleaseAppActivity;
import chat.ola.vn.activity.OlaUserProfileActivity;
import chat.ola.vn.activity.OlaVipStoreActivity;
import chat.ola.vn.cloud.OlaCloudAlbumListActivity;
import chat.ola.vn.n.b;

/* JADX INFO: loaded from: classes.dex */
@SuppressLint({"DefaultLocale"})
public class d extends a implements AdapterView.OnItemClickListener, chat.ola.vn.f.a {
    private static d d;
    private ListView a;
    private chat.ola.vn.b.i b;
    private View c;
    private chat.ola.vn.i.c e;

    private void a(chat.ola.vn.entry.e eVar) {
        eVar.a(a());
    }

    public static d c() {
        return d;
    }

    @Override // chat.ola.vn.m.a, chat.ola.vn.m.f
    protected void a(Bundle bundle) {
        super.a(bundle);
    }

    @Override // chat.ola.vn.m.f
    public void b(Bundle bundle) {
        super.b(bundle);
        d = this;
        this.b = new chat.ola.vn.b.i(getActivity());
        this.a.setAdapter((ListAdapter) this.b);
    }

    public void d() {
        this.b.notifyDataSetChanged();
    }

    @Override // android.view.View.OnClickListener
    public void onClick(View view) {
    }

    @Override // android.support.v4.app.Fragment
    public View onCreateView(LayoutInflater layoutInflater, ViewGroup viewGroup, Bundle bundle) {
        this.c = layoutInflater.inflate(R.layout.application_store_view_layout, (ViewGroup) null);
        this.a = (ListView) this.c.findViewById(R.id.appListView);
        this.c.findViewById(R.id.olaActionBarBackViewLayout).setVisibility(8);
        ((TextView) this.c.findViewById(R.id.olaActionBarTitleTextView)).setText(R.string.general_tab_app);
        this.a.setOnItemClickListener(this);
        return this.c;
    }

    @Override // android.support.v4.app.Fragment
    public void onDetach() {
        d = null;
        super.onDetach();
    }

    @Override // android.widget.AdapterView.OnItemClickListener
    public void onItemClick(AdapterView<?> adapterView, View view, int i, long j) {
        try {
            chat.ola.vn.entry.e eVarA = this.b.getItem(i);
            OlaBottomTabActivity olaBottomTabActivityA = a();
            switch (eVarA.d()) {
                case R.string.general_tab_contact /* 2131689697 */:
                    OlaBottomTabActivity.a(getActivity(), 0);
                    break;
                case R.string.general_tab_conversation /* 2131689698 */:
                    e.b(getActivity());
                    break;
                case R.string.general_tab_kenstore /* 2131689706 */:
                    if (a() != null) {
                        a().J();
                        OlaBottomTabActivity.a(getActivity(), 10);
                    }
                    break;
                case R.string.general_tab_me /* 2131689707 */:
                    OlaBottomTabActivity.a(getActivity(), 1);
                    break;
                case R.string.general_tab_mediastore /* 2131689710 */:
                    OlaCloudAlbumListActivity.a(getActivity());
                    break;
                case R.string.general_tab_nearby_places /* 2131689711 */:
                    try {
                        if (!chat.ola.vn.n.b.b(getActivity())) {
                            chat.ola.vn.n.b.a(getActivity(), 0);
                            return;
                        }
                        if (this.e == null) {
                            this.e = new chat.ola.vn.i.c(getActivity());
                            this.e.a(R.string.message_getting_location);
                        }
                        chat.ola.vn.n.b.a(getActivity(), 10000L, new b.InterfaceC0042b() { // from class: chat.ola.vn.m.d.1
                            private void d() {
                                try {
                                    d.this.e.a();
                                } catch (Throwable unused) {
                                }
                                OlaBottomTabActivity.a(d.this.getActivity(), 13);
                            }

                            @Override // chat.ola.vn.n.b.InterfaceC0042b
                            public void a(double d2, double d3, float f) {
                                d();
                            }

                            @Override // chat.ola.vn.n.b.InterfaceC0042b
                            public void j_() {
                                if (d.this.e.isShowing()) {
                                    d.this.e.a();
                                    chat.ola.vn.i.i.a(d.this.getActivity(), R.string.dialog_title_fail, R.string.message_not_yet_get_location);
                                }
                            }

                            @Override // chat.ola.vn.n.b.InterfaceC0042b
                            public void k_() {
                                d.this.e.a(30000L, null);
                            }

                            @Override // chat.ola.vn.n.b.InterfaceC0042b
                            public void l_() {
                                d.this.e.a();
                                chat.ola.vn.i.i.a(chat.ola.vn.c.c(), R.string.message_location_provider_gps_unavailable_title, R.string.message_location_provider_unavailable, R.string.string_turn_on_gps, R.string.string_close, new DialogInterface.OnClickListener() { // from class: chat.ola.vn.m.d.1.1
                                    @Override // android.content.DialogInterface.OnClickListener
                                    public void onClick(DialogInterface dialogInterface, int i2) {
                                        if (i2 == 0) {
                                            try {
                                                chat.ola.vn.c.c().startActivity(new Intent("android.settings.LOCATION_SOURCE_SETTINGS"));
                                            } catch (Throwable unused) {
                                                return;
                                            }
                                        }
                                        dialogInterface.dismiss();
                                    }
                                });
                            }
                        });
                    } catch (Throwable unused) {
                    }
                    break;
                case R.string.general_tab_note /* 2131689712 */:
                    m.a(getActivity(), "note", getString(R.string.general_tab_note));
                    break;
                case R.string.general_tab_notify /* 2131689713 */:
                    k.a(getActivity());
                    if (olaBottomTabActivityA != null) {
                        olaBottomTabActivityA.a(0);
                    }
                    break;
                case R.string.general_tab_ola_mall /* 2131689714 */:
                    chat.ola.vn.util.b.b(getActivity(), (String) null);
                    break;
                case R.string.general_tab_personal /* 2131689717 */:
                    OlaUserProfileActivity.a(getActivity());
                    eVarA.c("");
                    eVarA.b(1);
                    break;
                case R.string.general_tab_rss /* 2131689720 */:
                    OlaBottomTabActivity.a(getActivity(), 2);
                    break;
                case R.string.general_tab_translater /* 2131689722 */:
                    z.a(getActivity(), (String) null);
                    break;
                case R.string.general_tab_vipstore /* 2131689723 */:
                    OlaVipStoreActivity.a(getActivity(), chat.ola.vn.h.a());
                    break;
                default:
                    a(eVarA);
                    break;
            }
            OlaReleaseAppActivity.a(getActivity());
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    @Override // chat.ola.vn.m.f, android.support.v4.app.Fragment
    public void onResume() {
        super.onResume();
        chat.ola.vn.h.v.h();
        this.b.notifyDataSetChanged();
        d();
    }

    @Override // chat.ola.vn.m.f, android.support.v4.app.Fragment
    public void onSaveInstanceState(Bundle bundle) {
        super.onSaveInstanceState(bundle);
    }
}
