package chat.ola.vn.m;

import android.app.Dialog;
import android.content.Context;
import android.graphics.Bitmap;
import android.os.Bundle;
import android.os.Handler;
import android.support.v4.app.FragmentTransaction;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.view.animation.Animation;
import android.view.animation.AnimationUtils;
import android.widget.AdapterView;
import android.widget.ImageView;
import android.widget.ListAdapter;
import android.widget.ListView;
import android.widget.TextView;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import chat.ola.vn.activity.OlaBottomTabActivity;
import chat.ola.vn.b.af;
import com.google.android.gms.maps.CameraUpdateFactory;
import com.google.android.gms.maps.GoogleMap;
import com.google.android.gms.maps.OnMapReadyCallback;
import com.google.android.gms.maps.SupportMapFragment;
import com.google.android.gms.maps.model.BitmapDescriptorFactory;
import com.google.android.gms.maps.model.LatLng;
import com.google.android.gms.maps.model.Marker;
import com.google.android.gms.maps.model.MarkerOptions;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public class h extends a implements View.OnClickListener, AdapterView.OnItemClickListener, GoogleMap.OnInfoWindowClickListener, GoogleMap.OnMarkerClickListener {
    public static boolean a = true;
    private GoogleMap b;
    private LatLng c;
    private SupportMapFragment d;
    private ImageView e;
    private ListView f;
    private af g;
    private Animation h;
    private Animation i;
    private Marker j;

    public static void a(Context context) {
        OlaBottomTabActivity.a(context, 11);
    }

    private void a(final chat.ola.vn.message.f fVar, final String str, final String str2) {
        try {
            chat.ola.vn.c.f fVarB = chat.ola.vn.c.f.b(fVar.j());
            fVarB.a(new chat.ola.vn.c.g() { // from class: chat.ola.vn.m.h.3
                @Override // chat.ola.vn.c.g
                public void a(chat.ola.vn.c.f fVar2) {
                    try {
                        if (h.this.getActivity() == null || !chat.ola.vn.util.m.b(fVar.j(), fVar2.f()) || h.this == null) {
                            return;
                        }
                        MarkerOptions markerOptionsIcon = new MarkerOptions().position(new LatLng(Double.parseDouble(str), Double.parseDouble(str2))).icon(BitmapDescriptorFactory.fromBitmap(chat.ola.vn.n.b.a(h.this.getActivity(), fVar2.c())));
                        markerOptionsIcon.snippet(fVar.j());
                        if (chat.ola.vn.h.x.a(markerOptionsIcon)) {
                            h.this.b.addMarker(markerOptionsIcon);
                        }
                    } catch (Throwable unused) {
                    }
                }

                @Override // chat.ola.vn.c.g
                public void b(chat.ola.vn.c.f fVar2) {
                }
            });
            new chat.ola.vn.c.e().a(fVarB);
        } catch (Throwable unused) {
        }
    }

    private void a(List<chat.ola.vn.message.f> list, chat.ola.vn.message.f fVar) {
        chat.ola.vn.h.x.n();
        if (fVar != null) {
            chat.ola.vn.h.x.f = fVar.j();
            String strT = fVar.t();
            String strS = fVar.s();
            if (!chat.ola.vn.util.m.a(strS) && !chat.ola.vn.util.m.a(strT)) {
                this.c = new LatLng(Double.parseDouble(strT), Double.parseDouble(strS));
                this.b.moveCamera(CameraUpdateFactory.newLatLngZoom(this.c, 5.0f));
                this.b.animateCamera(CameraUpdateFactory.zoomTo(17.0f), 3000, null);
                if (list == null) {
                    list = new ArrayList<>();
                }
                list.add(0, fVar);
            }
        }
        if (list == null || list.size() <= 0) {
            return;
        }
        int size = list.size();
        for (int i = 0; i < size; i++) {
            chat.ola.vn.message.f fVar2 = list.get(i);
            if (fVar2.k() != 5 && fVar2.k() != 6) {
                String strT2 = fVar2.t();
                String strS2 = fVar2.s();
                if (!chat.ola.vn.util.m.a(strT2) && !chat.ola.vn.util.m.a(strS2)) {
                    Bitmap bitmapC = chat.ola.vn.c.t.a().c(fVar2.j());
                    if (bitmapC == null) {
                        a(fVar2, strT2, strS2);
                    } else {
                        Bitmap bitmapA = chat.ola.vn.n.b.a(getActivity(), bitmapC);
                        if (bitmapA != null) {
                            MarkerOptions markerOptionsIcon = new MarkerOptions().position(new LatLng(Double.parseDouble(strT2), Double.parseDouble(strS2))).icon(BitmapDescriptorFactory.fromBitmap(bitmapA));
                            markerOptionsIcon.snippet(fVar2.j());
                            if (chat.ola.vn.h.x.a(markerOptionsIcon)) {
                                this.b.addMarker(markerOptionsIcon);
                            }
                        }
                    }
                }
            }
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void e() {
        if (this.d == null) {
            j();
            return;
        }
        try {
            this.d.getMapAsync(new OnMapReadyCallback() { // from class: chat.ola.vn.m.h.1
                @Override // com.google.android.gms.maps.OnMapReadyCallback
                public void onMapReady(GoogleMap googleMap) {
                    try {
                        h.this.b = googleMap;
                        h.this.b.setInfoWindowAdapter(new chat.ola.vn.b.d(h.this.getActivity(), h.this));
                        h.this.b.setOnMarkerClickListener(h.this);
                        h.this.b.setOnInfoWindowClickListener(h.this);
                        h.this.h();
                    } catch (Throwable unused) {
                    }
                }
            });
        } catch (Throwable th) {
            th.printStackTrace();
            j();
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void h() {
        String string;
        try {
            Bundle arguments = getArguments();
            if (arguments != null) {
                String string2 = arguments.getString("pivot_contact_id");
                if (chat.ola.vn.util.m.a(string2)) {
                    string2 = chat.ola.vn.h.a();
                }
                if (!chat.ola.vn.util.m.b(string2, chat.ola.vn.h.x.f) || chat.ola.vn.h.x.m() <= 0) {
                    chat.ola.vn.message.f fVar = new chat.ola.vn.message.f(string2, (short) 0);
                    if (chat.ola.vn.util.m.b(string2, chat.ola.vn.h.a())) {
                        fVar.d(chat.ola.vn.h.H);
                        fVar.k(chat.ola.vn.n.c.a().c());
                        string = chat.ola.vn.n.c.a().b();
                    } else {
                        fVar.d(arguments.getShort("pivot_contact_vip_icon_index", (short) 0));
                        fVar.k(arguments.getString("pivot_contact_lat"));
                        string = arguments.getString("pivot_contact_long");
                    }
                    fVar.j(string);
                    List<chat.ola.vn.message.f> listH = chat.ola.vn.h.x.h();
                    if (listH == null || listH.size() <= 0) {
                        return;
                    }
                    a(new ArrayList(listH), fVar);
                    return;
                }
            } else if (!chat.ola.vn.util.m.b(chat.ola.vn.h.a(), chat.ola.vn.h.x.f) || chat.ola.vn.h.x.m() <= 0) {
                chat.ola.vn.message.f fVar2 = new chat.ola.vn.message.f(chat.ola.vn.h.a(), (short) 0);
                fVar2.d(chat.ola.vn.h.H);
                fVar2.k(chat.ola.vn.n.c.a().c());
                fVar2.j(chat.ola.vn.n.c.a().b());
                List<chat.ola.vn.message.f> listH2 = chat.ola.vn.h.x.h();
                if (listH2 == null || listH2.size() <= 0) {
                    return;
                }
                a(new ArrayList(listH2), fVar2);
                return;
            }
            v();
        } catch (Throwable unused) {
            j();
        }
    }

    private void j() {
        try {
            chat.ola.vn.i.i.a(getActivity());
        } catch (Throwable unused) {
        }
    }

    private void v() {
        try {
            Iterator<MarkerOptions> itL = chat.ola.vn.h.x.l();
            if (itL != null) {
                while (itL.hasNext()) {
                    this.b.addMarker(itL.next());
                }
            }
            String strC = chat.ola.vn.n.c.a().c();
            String strB = chat.ola.vn.n.c.a().b();
            if (chat.ola.vn.util.m.a(strB) || chat.ola.vn.util.m.a(strC)) {
                this.c = new LatLng(10.795199d, 106.663685d);
            } else {
                this.c = new LatLng(Double.parseDouble(strC), Double.parseDouble(strB));
            }
            this.b.moveCamera(CameraUpdateFactory.newLatLngZoom(this.c, 17.0f));
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.m.a, chat.ola.vn.m.f
    protected void a(Bundle bundle) {
        super.a(bundle);
        if (bundle != null) {
            try {
                int i = 0;
                boolean z = bundle.getBoolean("showFriendList", false);
                ListView listView = this.f;
                if (!z) {
                    i = 8;
                }
                listView.setVisibility(i);
            } catch (Throwable unused) {
            }
        }
    }

    @Override // chat.ola.vn.m.f
    protected void b(Bundle bundle) {
        super.b(bundle);
        this.g = new af(getActivity(), chat.ola.vn.h.x);
        this.g.a(false);
        this.f.setAdapter((ListAdapter) this.g);
        this.d = SupportMapFragment.newInstance();
        FragmentTransaction fragmentTransactionBeginTransaction = getChildFragmentManager().beginTransaction();
        fragmentTransactionBeginTransaction.add(R.id.mapContentView, this.d, SupportMapFragment.class.getName());
        fragmentTransactionBeginTransaction.commit();
        new Handler().post(new Runnable() { // from class: chat.ola.vn.m.h.2
            @Override // java.lang.Runnable
            public void run() {
                h.this.e();
            }
        });
    }

    public void c() {
    }

    public int d() {
        return 0;
    }

    @Override // chat.ola.vn.m.f
    public boolean g_() {
        c();
        return true;
    }

    @Override // chat.ola.vn.m.f
    public Dialog h_() {
        chat.ola.vn.i.m mVar = new chat.ola.vn.i.m(getActivity());
        try {
            final ArrayList arrayList = new ArrayList();
            arrayList.add(this.f.getVisibility() == 0 ? getString(R.string.menu_show_map_full_screen) : getString(R.string.menu_show_friend_list));
            if (this.b != null) {
                arrayList.add(this.b.getMapType() == 1 ? getString(R.string.menu_show_satellite_map) : getString(R.string.menu_hide_satellite_map));
            }
            arrayList.add(getString(R.string.menu_close_map));
            mVar.a(arrayList);
            mVar.a(new AdapterView.OnItemClickListener() { // from class: chat.ola.vn.m.h.4
                @Override // android.widget.AdapterView.OnItemClickListener
                public void onItemClick(AdapterView<?> adapterView, View view, int i, long j) {
                    GoogleMap googleMap;
                    int i2;
                    ImageView imageView;
                    int i3;
                    try {
                        String str = (String) arrayList.get(i);
                        if (chat.ola.vn.util.m.b(h.this.getString(R.string.menu_show_map_full_screen), str)) {
                            h.this.f.setVisibility(8);
                            h.this.f.clearAnimation();
                            h.this.f.startAnimation(h.this.i);
                            imageView = h.this.e;
                            i3 = R.drawable.ic_action_friend_list;
                        } else {
                            if (!chat.ola.vn.util.m.b(h.this.getString(R.string.menu_show_friend_list), str)) {
                                if (chat.ola.vn.util.m.b(h.this.getString(R.string.menu_show_satellite_map), str)) {
                                    googleMap = h.this.b;
                                    i2 = 4;
                                } else {
                                    if (!chat.ola.vn.util.m.b(h.this.getString(R.string.menu_hide_satellite_map), str)) {
                                        if (chat.ola.vn.util.m.b(h.this.getString(R.string.menu_close_map), str)) {
                                            h.this.c();
                                            return;
                                        }
                                        return;
                                    }
                                    googleMap = h.this.b;
                                    i2 = 1;
                                }
                                googleMap.setMapType(i2);
                                return;
                            }
                            h.this.f.setVisibility(0);
                            h.this.f.clearAnimation();
                            h.this.f.startAnimation(h.this.h);
                            imageView = h.this.e;
                            i3 = R.drawable.ic_action_full_screen;
                        }
                        imageView.setImageResource(i3);
                    } catch (Throwable unused) {
                    }
                }
            });
            mVar.show();
        } catch (Throwable unused) {
        }
        return mVar;
    }

    @Override // chat.ola.vn.m.f
    public boolean i() {
        return true;
    }

    @Override // android.view.View.OnClickListener
    public void onClick(View view) {
        try {
            int id = view.getId();
            if (id != R.id.btnFriendList) {
                if (id != R.id.btnMyLocation) {
                    if (id != R.id.olaActionBarCloseButtonImageView) {
                        return;
                    }
                    a().d(d());
                    return;
                } else {
                    if (this.c != null) {
                        this.b.animateCamera(CameraUpdateFactory.newLatLng(this.c));
                        return;
                    }
                    return;
                }
            }
            if (this.f.getVisibility() == 0) {
                this.f.setVisibility(8);
                this.f.clearAnimation();
                this.f.startAnimation(this.i);
                this.e.setImageResource(R.drawable.ic_action_friend_list);
                return;
            }
            this.f.setVisibility(0);
            this.f.clearAnimation();
            this.f.startAnimation(this.h);
            this.e.setImageResource(R.drawable.ic_action_full_screen);
            this.j.hideInfoWindow();
        } catch (Throwable unused) {
        }
    }

    @Override // android.support.v4.app.Fragment
    public View onCreateView(LayoutInflater layoutInflater, ViewGroup viewGroup, Bundle bundle) {
        try {
            View viewInflate = layoutInflater.inflate(R.layout.location_viewer_layout, (ViewGroup) null);
            viewInflate.findViewById(R.id.btnMyLocation).setOnClickListener(this);
            viewInflate.findViewById(R.id.olaActionBarCloseButtonImageView).setOnClickListener(this);
            ((ImageView) viewInflate.findViewById(R.id.olaActionBarIconImageView)).setImageResource(R.drawable.ic_tab_friend_location);
            ((TextView) viewInflate.findViewById(R.id.olaActionBarTitleTextView)).setText(R.string.general_tab_find_neighbor);
            this.e = (ImageView) viewInflate.findViewById(R.id.btnFriendList);
            this.e.setOnClickListener(this);
            this.f = (ListView) viewInflate.findViewById(R.id.lvFriendList);
            this.f.setOnItemClickListener(this);
            if (chat.ola.vn.h.x == null || chat.ola.vn.h.x.g() == 0) {
                c();
            }
            this.h = AnimationUtils.loadAnimation(getActivity(), R.anim.slide_in_from_bottom);
            this.i = AnimationUtils.loadAnimation(getActivity(), R.anim.slide_out_to_bottom);
            return viewInflate;
        } catch (Throwable unused) {
            return viewGroup;
        }
    }

    @Override // android.support.v4.app.Fragment
    public void onDetach() {
        try {
            if (this.b != null) {
                this.b.stopAnimation();
                this.b.clear();
            }
        } catch (Throwable unused) {
        }
        super.onDetach();
    }

    @Override // com.google.android.gms.maps.GoogleMap.OnInfoWindowClickListener
    public void onInfoWindowClick(Marker marker) {
        String snippet = marker.getSnippet();
        if (snippet != null) {
            chat.ola.vn.me.c.a(getActivity(), OlaApplication.b, snippet);
        }
    }

    @Override // android.widget.AdapterView.OnItemClickListener
    public void onItemClick(AdapterView<?> adapterView, View view, int i, long j) {
        try {
            chat.ola.vn.message.f fVar = (chat.ola.vn.message.f) this.g.getItem(i);
            this.b.animateCamera(CameraUpdateFactory.newLatLng(new LatLng(Double.valueOf(fVar.t()).doubleValue(), Double.valueOf(fVar.s()).doubleValue())), 150, null);
        } catch (Throwable unused) {
        }
    }

    @Override // com.google.android.gms.maps.GoogleMap.OnMarkerClickListener
    public boolean onMarkerClick(Marker marker) {
        this.j = marker;
        try {
            if (this.f.getVisibility() != 0) {
                return false;
            }
            this.f.setVisibility(8);
            this.f.clearAnimation();
            this.f.startAnimation(this.i);
            this.e.setImageResource(R.drawable.ic_action_friend_list);
            return false;
        } catch (Throwable unused) {
            return false;
        }
    }

    @Override // chat.ola.vn.m.f, android.support.v4.app.Fragment
    public void onSaveInstanceState(Bundle bundle) {
        try {
            bundle.putBoolean("showFriendList", this.f.getVisibility() == 0);
        } catch (Exception unused) {
        }
        super.onSaveInstanceState(bundle);
    }
}
