package chat.ola.vn.view;

import android.content.Context;
import android.util.AttributeSet;
import android.view.View;
import chat.ola.vn.R;

/* JADX INFO: loaded from: classes.dex */
public class f extends d implements View.OnClickListener {
    private View a;
    private View b;
    private View c;
    private View d;
    private a e;

    public interface a {
        void N();

        void O();

        void P();

        void Q();
    }

    public f(Context context) {
        super(context);
        a(context);
    }

    public f(Context context, AttributeSet attributeSet) {
        super(context, attributeSet);
        a(context);
    }

    public f(Context context, AttributeSet attributeSet, int i) {
        super(context, attributeSet, i);
        a(context);
    }

    private void a(Context context) {
        inflate(context, R.layout.ola_attachment_more_tab_layout, this);
        try {
            this.a = findViewById(R.id.sendLocationButton);
            this.a.setOnClickListener(this);
            this.b = findViewById(R.id.transferKenButton);
            this.b.setOnClickListener(this);
            this.c = findViewById(R.id.tradingVipButton);
            this.c.setOnClickListener(this);
            this.d = findViewById(R.id.sendVipDayButton);
            this.d.setOnClickListener(this);
        } catch (Throwable unused) {
        }
    }

    public a getOnMoreActionClickedListener() {
        return this.e;
    }

    @Override // android.view.View.OnClickListener
    public void onClick(View view) {
        try {
            int id = view.getId();
            if (id == R.id.sendLocationButton) {
                if (this.e != null) {
                    this.e.N();
                }
            } else if (id == R.id.sendVipDayButton) {
                if (this.e != null) {
                    this.e.Q();
                }
            } else if (id == R.id.tradingVipButton) {
                if (this.e != null) {
                    this.e.P();
                }
            } else if (id == R.id.transferKenButton && this.e != null) {
                this.e.O();
            }
        } catch (Throwable unused) {
        }
    }

    public void setOnMoreActionClickedListener(a aVar) {
        this.e = aVar;
    }

    public void setSendVipDayButtonVisibility(boolean z) {
        this.d.setVisibility(z ? 0 : 8);
    }

    public void setTradingVipButtonVisibility(boolean z) {
        this.c.setVisibility(z ? 0 : 8);
    }

    public void setTransferKenButtonVisibility(boolean z) {
        this.b.setVisibility(z ? 0 : 8);
    }
}
