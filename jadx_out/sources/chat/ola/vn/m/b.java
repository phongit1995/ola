package chat.ola.vn.m;

import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import chat.ola.vn.activity.PurchaseKENActivity;
import chat.ola.vn.network.OlaNetworkService;
import chat.ola.vn.transferken.OlaTransferKenActivity;

/* JADX INFO: loaded from: classes.dex */
public class b extends a implements View.OnClickListener, chat.ola.vn.d.a {
    private TextView a;
    private TextView b;
    private View c;

    private void b(long j) {
        TextView textView;
        int i;
        if (j == 0) {
            this.b.setVisibility(0);
            textView = this.b;
            i = R.string.message_out_of_ken;
        } else {
            if (j > 10000) {
                this.b.setVisibility(8);
                this.a.setText(chat.ola.vn.util.m.a(chat.ola.vn.h.o) + " KEN");
            }
            this.b.setVisibility(0);
            textView = this.b;
            i = R.string.message_low_ken;
        }
        textView.setText(i);
        this.a.setText(chat.ola.vn.util.m.a(chat.ola.vn.h.o) + " KEN");
    }

    @Override // chat.ola.vn.d.a
    public void a(long j) {
        b(j);
    }

    public int b() {
        return 10;
    }

    @Override // chat.ola.vn.m.f, android.support.v4.app.Fragment
    public void onActivityCreated(Bundle bundle) {
        super.onActivityCreated(bundle);
        OlaNetworkService olaNetworkService = OlaApplication.b;
        if (olaNetworkService != null) {
            olaNetworkService.r();
        }
    }

    @Override // android.view.View.OnClickListener
    public void onClick(View view) {
        switch (view.getId()) {
            case R.id.btnSupportService /* 2131296541 */:
                if (com.mg.ola.common.d.g.a(getActivity()) && chat.ola.vn.util.n.b(getActivity())) {
                    chat.ola.vn.util.b.c(getActivity(), "1900588883");
                } else {
                    chat.ola.vn.i.i.b(getActivity());
                }
                break;
            case R.id.btnTraddingHistory /* 2131296554 */:
                m.a(getActivity(), "bank", getString(R.string.string_bank));
                break;
            case R.id.btnTraddingTransferKen /* 2131296555 */:
                OlaTransferKenActivity.a(getActivity());
                break;
            case R.id.buyKENButton /* 2131296576 */:
            case R.id.kenNotify /* 2131296964 */:
                PurchaseKENActivity.a(getActivity());
                break;
            case R.id.olaActionBarCloseButtonImageView /* 2131297183 */:
                a().d(b());
                break;
        }
    }

    @Override // android.support.v4.app.Fragment
    public View onCreateView(LayoutInflater layoutInflater, ViewGroup viewGroup, Bundle bundle) {
        this.c = layoutInflater.inflate(R.layout.ken_store_view_layout, (ViewGroup) null);
        this.a = (TextView) this.c.findViewById(R.id.txtKenAvaliable);
        this.b = (TextView) this.c.findViewById(R.id.kenNotify);
        this.b.setVisibility(8);
        this.b.setOnClickListener(this);
        this.c.findViewById(R.id.btnSupportService).setVisibility(0);
        ((ImageView) this.c.findViewById(R.id.olaActionBarIconImageView)).setImageResource(R.drawable.ic_tab_ken_store);
        ((TextView) this.c.findViewById(R.id.olaActionBarTitleTextView)).setText(R.string.general_tab_kenstore);
        this.c.findViewById(R.id.olaActionBarCloseButtonImageView).setOnClickListener(this);
        this.c.findViewById(R.id.buyKENButton).setOnClickListener(this);
        this.c.findViewById(R.id.btnTraddingTransferKen).setOnClickListener(this);
        this.c.findViewById(R.id.btnTraddingHistory).setOnClickListener(this);
        this.c.findViewById(R.id.btnSupportService).setOnClickListener(this);
        return this.c;
    }

    @Override // chat.ola.vn.m.f, android.support.v4.app.Fragment
    public void onResume() {
        super.onResume();
        b(chat.ola.vn.h.o);
    }
}
